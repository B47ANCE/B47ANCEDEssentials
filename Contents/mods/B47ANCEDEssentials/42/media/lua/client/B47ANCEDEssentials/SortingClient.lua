require "B47ANCEDEssentials/SortingCore"
require "B47ANCEDEssentials/InventoryReferences"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local function option(name,fallback)
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    local value=values and values[name]
    if value==nil then return fallback end
    return value
end

local function translated(key,fallback)
    if type(getTextOrNull)=="function" then
        local ok,value=pcall(getTextOrNull,key)
        if ok and value then return value end
    end
    return fallback
end

local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return nil end
    local ok,value=pcall(fn,object,...)
    if ok then return value end
    return nil
end

local function referenceFor(object,container)
    return B47ANCEDEssentials.InventoryReferences.describeWorldContainer(object,container)
end

local function requestSort(player,reference)
    if player and reference and type(sendClientCommand)=="function" then
        sendClientCommand(player,"B47ANCEDEssentials","sortContainer",reference)
    end
end

local function addOptions(playerNum,context,worldObjects,test)
    if option("EnableSortingAutomation",true)==false or not context then return end
    local player=getSpecificPlayer and getSpecificPlayer(playerNum)
    if not player then return end
    local seen={}
    for _,object in ipairs(worldObjects or {}) do
        local count=tonumber(call(object,"getContainerCount")) or 0
        for index=0,count-1 do
            local container=call(object,"getContainerByIndex",index)
            if container and not seen[container] and call(container,"getContainingItem")==nil
                and call(container,"getType")~="floor" then
                seen[container]=true
                local reference=referenceFor(object,container)
                if reference and (not player.canAccessContainer or call(player,"canAccessContainer",container)~=false) then
                    if test and ISWorldObjectContextMenu and ISWorldObjectContextMenu.setTest then
                        return ISWorldObjectContextMenu.setTest()
                    end
                    local name=call(container,"getType") or translated("ContextMenu_B47ANCEDEssentials_Container","container")
                    context:addOption(translated("ContextMenu_B47ANCEDEssentials_SortNearby","Sort contents into nearby containers")
                        .." ("..tostring(name)..")",player,requestSort,reference)
                end
            end
        end
    end
end

local reported=false
local function safeAdd(...)
    local ok,err=pcall(addOptions,...)
    if not ok and not reported then
        reported=true
        print("[B47ANCEDEssentials] Sorting context menu failed safely: "..tostring(err))
    end
end

if Events and Events.OnFillWorldObjectContextMenu then
    Events.OnFillWorldObjectContextMenu.Add(safeAdd)
end

B47ANCEDEssentials.requestContainerSort=requestSort
return B47ANCEDEssentials
