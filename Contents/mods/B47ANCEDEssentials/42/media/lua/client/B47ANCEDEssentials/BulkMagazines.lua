require "ISUI/ISInventoryPaneContextMenu"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISLoadBulletsInMagazine"
require "TimedActions/ISUnloadBulletsFromMagazine"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local function config()
    local root=rawget(_G,"SandboxVars")
    return root and root.B47ANCEDEssentials or nil
end

local function translated(key,fallback)
    if type(getTextOrNull)=="function" then
        local ok,value=pcall(getTextOrNull,key)
        if ok and value then return value end
    end
    return fallback
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

local function children(container)
    local ok,list=call(container,"getItems"); if not ok or not list then return {} end
    local sizeOK,size=call(list,"size"); if not sizeOK then return {} end
    local result={}
    for index=0,(tonumber(size) or 0)-1 do
        local got,item=call(list,"get",index); if got and item then result[#result+1]=item end
    end
    return result
end

local function collect(container,recurse,result,seen)
    if not container or seen[container] then return end
    seen[container]=true
    for _,item in ipairs(children(container)) do
        result[#result+1]=item
        if recurse then
            local ok,nested=call(item,"getInventory")
            if ok and nested then collect(nested,true,result,seen) end
        end
    end
end

local function ammoKey(magazine)
    local ok,ammoType=call(magazine,"getAmmoType"); if not ok or not ammoType then return nil end
    local keyOK,key=call(ammoType,"getItemKey")
    return keyOK and tostring(key) or nil
end

function B47ANCEDEssentials.buildBulkMagazinePlan(player,example,unload)
    local settings=config()
    if settings and settings.EnableBulkMagazineActions==false then return {} end
    local ok,inventory=call(player,"getInventory"); if not ok or not inventory then return {} end
    local all={}; collect(inventory,not settings or settings.BulkMagazinesIncludeNestedInventory~=false,all,{})
    local kind=fullType(example); local key=ammoKey(example)
    local magazines,rounds={},{}
    for _,item in ipairs(all) do
        if fullType(item)==kind then
            local countOK,count=call(item,"getCurrentAmmoCount")
            local maxOK,maximum=call(item,"getMaxAmmo")
            if countOK and maxOK then
                count,maximum=tonumber(count) or 0,tonumber(maximum) or 0
                if (unload and count>0) or (not unload and count<maximum) then
                    magazines[#magazines+1]={item=item,current=count,maximum=maximum}
                end
            end
        elseif not unload and key and fullType(item)==key then
            rounds[#rounds+1]=item
        end
    end
    table.sort(magazines,function(a,b)
        if a.current==b.current then return tostring(fullType(a.item))<tostring(fullType(b.item)) end
        return unload and a.current>b.current or (not unload and a.current>b.current)
    end)
    local maximumMagazines=math.max(2,math.floor(tonumber(settings and settings.BulkMagazinesMaximumPerAction) or 50))
    local plan={}; local roundIndex=1
    for _,entry in ipairs(magazines) do
        if #plan>=maximumMagazines then break end
        local amount=unload and entry.current or math.min(entry.maximum-entry.current,#rounds-roundIndex+1)
        if amount>0 then
            local allocation={}
            if not unload then
                for _=1,amount do allocation[#allocation+1]=rounds[roundIndex]; roundIndex=roundIndex+1 end
            end
            plan[#plan+1]={magazine=entry.item,amount=amount,rounds=allocation,unload=unload==true}
        end
    end
    return plan
end

local function addAfter(previous,action)
    if previous then ISTimedActionQueue.addAfter(previous,action) else ISTimedActionQueue.add(action) end
    return action
end

local function transferAction(player,item,destination)
    local ok,source=call(item,"getContainer")
    if not ok or not source or source==destination then return nil end
    if rawget(_G,"ISInventoryTransferUtil") and ISInventoryTransferUtil.newInventoryTransferAction then
        return ISInventoryTransferUtil.newInventoryTransferAction(player,item,source,destination)
    end
    return ISInventoryTransferAction:new(player,item,source,destination)
end

function B47ANCEDEssentials.queueBulkMagazinePlan(player,plan)
    local _,inventory=call(player,"getInventory"); if not inventory then return 0 end
    local previous=nil
    for _,entry in ipairs(plan or {}) do
        local transfer=transferAction(player,entry.magazine,inventory)
        if transfer then previous=addAfter(previous,transfer) end
        for _,round in ipairs(entry.rounds or {}) do
            transfer=transferAction(player,round,inventory)
            if transfer then previous=addAfter(previous,transfer) end
        end
        local action=entry.unload and ISUnloadBulletsFromMagazine:new(player,entry.magazine)
            or ISLoadBulletsInMagazine:new(player,entry.magazine,entry.amount)
        previous=addAfter(previous,action)
    end
    return #(plan or {})
end

local function queue(player,magazine,unload)
    return B47ANCEDEssentials.queueBulkMagazinePlan(player,B47ANCEDEssentials.buildBulkMagazinePlan(player,magazine,unload))
end

local original=ISInventoryPaneContextMenu and ISInventoryPaneContextMenu.doMagazineMenu
if type(original)=="function" and not B47ANCEDEssentials.BulkMagazineHookInstalled then
    function ISInventoryPaneContextMenu.doMagazineMenu(player,magazine,context)
        original(player,magazine,context)
        local settings=config(); if settings and settings.EnableBulkMagazineActions==false then return end
        local loadPlan=B47ANCEDEssentials.buildBulkMagazinePlan(player,magazine,false)
        if #loadPlan>=2 then context:addOption(translated("ContextMenu_B47ANCEDEssentials_LoadAllMagazines","Load all matching magazines"),player,queue,magazine,false) end
        local unloadPlan=B47ANCEDEssentials.buildBulkMagazinePlan(player,magazine,true)
        if #unloadPlan>=2 then context:addOption(translated("ContextMenu_B47ANCEDEssentials_UnloadAllMagazines","Unload all matching magazines"),player,queue,magazine,true) end
    end
    B47ANCEDEssentials.BulkMagazineHookInstalled=true
end

return B47ANCEDEssentials
