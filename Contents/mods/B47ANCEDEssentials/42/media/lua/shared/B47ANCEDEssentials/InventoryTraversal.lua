B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.InventoryTraversal=B47ANCEDEssentials.InventoryTraversal or {}
local Traversal=B47ANCEDEssentials.InventoryTraversal

Traversal.SCHEMA_VERSION=1
Traversal.DEFAULT_MAX_DEPTH=4
Traversal.DEFAULT_MAX_CONTAINERS=64
Traversal.DEFAULT_MAX_ITEMS=512

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function bounded(value,fallback,minimum,maximum)
    value=math.floor(tonumber(value) or fallback)
    return math.max(minimum,math.min(maximum,value))
end

local function listValues(list)
    if type(list)=="table" and type(list.size)~="function" then
        local result={}
        for _,value in ipairs(list) do result[#result+1]=value end
        return result
    end
    local ok,size=call(list,"size")
    local result={}
    if ok then
        for index=0,(tonumber(size) or 0)-1 do
            local got,value=call(list,"get",index)
            if got and value then result[#result+1]=value end
        end
    end
    return result
end

local function defaultItems(container)
    local ok,items=call(container,"getItems")
    return ok and listValues(items) or {}
end

local function defaultChild(item)
    local ok,container=call(item,"getInventory")
    if ok and container then return container end
    ok,container=call(item,"getItemContainer")
    return ok and container or nil
end

local function defaultContainerId(container)
    local ok,id=call(container,"getID")
    if ok and id~=nil then return "container:"..tostring(id) end
    return nil
end

local function defaultItemId(item)
    local ok,id=call(item,"getID")
    return ok and id~=nil and "item:"..tostring(id) or nil
end

local function allowed(callback,actor,value,fallback)
    if type(callback)~="function" then return fallback end
    local ok,result=pcall(callback,actor,value)
    return ok and result==true
end

local function actorCanAccess(actor,container)
    local ok,value=call(actor,"canAccessContainer",container)
    return ok and value==true
end

function Traversal.traverse(actor,roots,options)
    options=options or {}
    local maxDepth=bounded(options.maxDepth,Traversal.DEFAULT_MAX_DEPTH,0,16)
    local maxContainers=bounded(options.maxContainers,Traversal.DEFAULT_MAX_CONTAINERS,1,256)
    local maxItems=bounded(options.maxItems,Traversal.DEFAULT_MAX_ITEMS,1,4096)
    local getItems=options.getItems or defaultItems
    local getChild=options.getChildContainer or defaultChild
    local getContainerId=options.getContainerId or defaultContainerId
    local getItemId=options.getItemId or defaultItemId
    local result={schemaVersion=Traversal.SCHEMA_VERSION,containers={},items={},diagnostics={
        cycles=0,duplicateRoots=0,duplicateItems=0,inaccessible=0,unstableContainers=0,unstableItems=0,
        containerLimit=false,itemLimit=false,depthLimit=false,providerErrors=0,
    }}
    local visited,queued,visitedItems={},{},{}
    local queue={}

    local function enqueue(container,depth,parentId,viaItemId,isRoot)
        if not container then return end
        local ok,id=pcall(getContainerId,container)
        if not ok then result.diagnostics.providerErrors=result.diagnostics.providerErrors+1 return end
        if type(id)~="string" or id=="" then result.diagnostics.unstableContainers=result.diagnostics.unstableContainers+1 return end
        if visited[id] or queued[id] then
            if isRoot then result.diagnostics.duplicateRoots=result.diagnostics.duplicateRoots+1
            else result.diagnostics.cycles=result.diagnostics.cycles+1 end
            return
        end
        queued[id]=true
        queue[#queue+1]={container=container,id=id,depth=depth,parentId=parentId,viaItemId=viaItemId}
    end

    local rootList={}
    for _,root in ipairs(roots or {}) do rootList[#rootList+1]=root end
    table.sort(rootList,function(a,b)
        local oka,ida=pcall(getContainerId,a); local okb,idb=pcall(getContainerId,b)
        return tostring(oka and ida or "")<tostring(okb and idb or "")
    end)
    for _,root in ipairs(rootList) do enqueue(root,0,nil,nil,true) end

    local cursor=1
    while cursor<=#queue do
        if #result.containers>=maxContainers then result.diagnostics.containerLimit=true break end
        local node=queue[cursor]; cursor=cursor+1; queued[node.id]=nil
        if not visited[node.id] then
            visited[node.id]=true
            local visible=allowed(options.canView,actor,node.container,actorCanAccess(actor,node.container))
            if not visible then
                result.diagnostics.inaccessible=result.diagnostics.inaccessible+1
            else
                local transferable=allowed(options.canTransfer,actor,node.container,actorCanAccess(actor,node.container))
                local entry={id=node.id,parentId=node.parentId,viaItemId=node.viaItemId,depth=node.depth,
                    visible=true,transferable=transferable,container=node.container,itemIds={}}
                result.containers[#result.containers+1]=entry
                local ok,values=pcall(getItems,node.container)
                if not ok or type(values)~="table" then values={}; result.diagnostics.providerErrors=result.diagnostics.providerErrors+1 end
                local described={}
                for _,item in ipairs(values) do
                    local idOK,itemId=pcall(getItemId,item)
                    if idOK and type(itemId)=="string" and itemId~="" then described[#described+1]={id=itemId,item=item}
                    else result.diagnostics.unstableItems=result.diagnostics.unstableItems+1 end
                end
                table.sort(described,function(a,b) return a.id<b.id end)
                for _,itemEntry in ipairs(described) do
                    if #result.items>=maxItems then result.diagnostics.itemLimit=true break end
                    if visitedItems[itemEntry.id] then
                        result.diagnostics.duplicateItems=result.diagnostics.duplicateItems+1
                    else
                        visitedItems[itemEntry.id]=true
                        result.items[#result.items+1]={id=itemEntry.id,containerId=node.id,depth=node.depth,
                            visible=true,transferable=transferable,item=itemEntry.item}
                        entry.itemIds[#entry.itemIds+1]=itemEntry.id
                        local childOK,child=pcall(getChild,itemEntry.item)
                        if not childOK then result.diagnostics.providerErrors=result.diagnostics.providerErrors+1
                        elseif child then
                            if node.depth>=maxDepth then result.diagnostics.depthLimit=true
                            else enqueue(child,node.depth+1,node.id,itemEntry.id,false) end
                        end
                    end
                end
                if result.diagnostics.itemLimit then break end
            end
        end
    end
    return result
end

return Traversal
