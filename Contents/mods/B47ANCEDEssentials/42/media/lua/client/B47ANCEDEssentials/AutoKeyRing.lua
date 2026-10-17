require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISTimedActionQueue"

B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.KeyPredicates=B47ANCEDEssentials.KeyPredicates or {}
B47ANCEDEssentials.KeyRingPredicates=B47ANCEDEssentials.KeyRingPredicates or {}
local queued=setmetatable({}, {__mode="k"})

local function settings()
    local root=rawget(_G,"SandboxVars")
    return root and root.B47ANCEDEssentials or nil
end

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function fullType(item)
    local ok,value=call(item,"getFullType")
    return ok and tostring(value) or ""
end

local function runPredicates(predicates,item)
    for _,predicate in ipairs(predicates) do
        local ok,value=pcall(predicate,item)
        if ok and value~=nil then return value==true end
    end
    return nil
end

function B47ANCEDEssentials.registerKeyPredicate(predicate)
    assert(type(predicate)=="function","key predicate must be a function")
    B47ANCEDEssentials.KeyPredicates[#B47ANCEDEssentials.KeyPredicates+1]=predicate
end

function B47ANCEDEssentials.registerKeyRingPredicate(predicate)
    assert(type(predicate)=="function","key-ring predicate must be a function")
    B47ANCEDEssentials.KeyRingPredicates[#B47ANCEDEssentials.KeyRingPredicates+1]=predicate
end

function B47ANCEDEssentials.isKey(item)
    local provided=runPredicates(B47ANCEDEssentials.KeyPredicates,item)
    if provided~=nil then return provided end
    local ok,value=pcall(function() return instanceof(item,"Key") end)
    if ok and value then return true end
    local kind=fullType(item)
    return kind=="Base.Key1" or kind=="Base.Key2" or kind=="Base.Key3"
        or kind=="Base.Key4" or kind=="Base.Key5" or kind=="Base.KeyPadlock"
        or kind=="Base.CarKey"
end

function B47ANCEDEssentials.isKeyRing(item)
    local provided=runPredicates(B47ANCEDEssentials.KeyRingPredicates,item)
    if provided~=nil then return provided end
    local kind=fullType(item)
    local moduleName,typeName=kind:match("^([^%.]+)%.(.+)$")
    if moduleName=="Base" and typeName and typeName:find("^KeyRing") then
        local ok,inventory=call(item,"getInventory")
        return ok and inventory~=nil
    end
    return false
end

local function listItems(container)
    local ok,items=call(container,"getItems")
    if not ok or not items then return {} end
    local result={}
    local sizeOK,size=call(items,"size")
    if not sizeOK then return result end
    for index=0,(tonumber(size) or 0)-1 do
        local got,item=call(items,"get",index)
        if got and item then result[#result+1]=item end
    end
    return result
end

local function collect(container,includeNested,out,seen)
    if not container or seen[container] then return end
    seen[container]=true
    for _,item in ipairs(listItems(container)) do
        out[#out+1]=item
        if includeNested and not B47ANCEDEssentials.isKeyRing(item) then
            local ok,nested=call(item,"getInventory")
            if ok and nested then collect(nested,true,out,seen) end
        end
    end
end

function B47ANCEDEssentials.planKeyTransfers(player)
    local config=settings()
    if config and config.EnableAutoKeyRing==false then return {} end
    local ok,inventory=call(player,"getInventory")
    if not ok or not inventory then return {} end
    local includeNested=not config or config.AutoKeyRingIncludeNestedInventory~=false
    local preserveFavorites=not config or config.AutoKeyRingPreserveFavorites~=false
    local maximum=math.max(1,math.floor(tonumber(config and config.AutoKeyRingMaxTransfersPerPass) or 25))
    local entries={}; collect(inventory,includeNested,entries,{})
    local rings={}
    for _,item in ipairs(entries) do if B47ANCEDEssentials.isKeyRing(item) then rings[#rings+1]=item end end
    if #rings==0 then return {} end
    table.sort(rings,function(a,b)
        local aEquipped=select(2,call(player,"isEquipped",a))==true
        local bEquipped=select(2,call(player,"isEquipped",b))==true
        if aEquipped~=bEquipped then return aEquipped end
        return fullType(a)<fullType(b)
    end)
    local _,destination=call(rings[1],"getInventory")
    if not destination then return {} end
    local transfers={}
    for _,item in ipairs(entries) do
        if #transfers>=maximum then break end
        if B47ANCEDEssentials.isKey(item) and not queued[item] then
            local favorite=false
            local favOK,fav=call(item,"isFavorite"); if favOK then favorite=fav==true end
            local sourceOK,source=call(item,"getContainer")
            if sourceOK and source and source~=destination and not (preserveFavorites and favorite) then
                local roomOK,room=call(destination,"hasRoomFor",player,item)
                if not roomOK then roomOK,room=call(destination,"hasRoomFor",item) end
                if not roomOK or room~=false then
                    transfers[#transfers+1]={item=item,source=source,destination=destination}
                end
            end
        end
    end
    return transfers
end

function B47ANCEDEssentials.queueKeyTransfers(player)
    local planned=B47ANCEDEssentials.planKeyTransfers(player)
    for _,entry in ipairs(planned) do
        queued[entry.item]=true
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player,entry.item,entry.source,entry.destination))
    end
    return #planned
end

local reported=false
local function update()
    for playerIndex=0,3 do
        local player=getSpecificPlayer(playerIndex)
        if player then
            for item in pairs(queued) do
                local ok,container=call(item,"getContainer")
                if not ok or not container or B47ANCEDEssentials.isKeyRing(select(2,call(container,"getContainingItem"))) then
                    queued[item]=nil
                end
            end
            local ok,err=pcall(B47ANCEDEssentials.queueKeyTransfers,player)
            if not ok and not reported then
                reported=true
                print("[B47ANCEDEssentials] Auto key-ring filing failed safely: "..tostring(err))
            end
        end
    end
end

if Events and Events.EveryOneMinute then Events.EveryOneMinute.Add(update) end
return B47ANCEDEssentials
