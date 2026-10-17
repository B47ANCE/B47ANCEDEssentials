-- Conservative inventory-menu organization. Actions keep their original
-- target, callback, parameters, tooltip, icon, availability, and submenu; this
-- module changes ownership/layout only and does not reimplement device logic.
B47ANCEDEssentials=B47ANCEDEssentials or {}

local reportedFailure=false

local function enabled()
    local root=rawget(_G,"SandboxVars")
    local values=root and root.B47ANCEDEssentials or nil
    return not values or values.EnableDeviceBatteryMenuGrouping~=false
end

local function unwrap(entry)
    if not entry then return nil end
    local ok,item=pcall(function() return entry.items and entry.items[1] or entry end)
    return ok and item or nil
end

local function isLight(item)
    if not item then return false end
    local lightworks=rawget(_G,"lightWorks")
    if lightworks and lightworks.isRegisteredLight then
        local ok,value=pcall(lightworks.isRegisteredLight,item)
        if ok and value then return true end
    end
    local ok,value=pcall(function() return item:canEmitLight() end)
    return ok and value==true
end

local function findItemMenu(context,item)
    local ok,name=pcall(function() return item:getDisplayName() end)
    if not ok or not name then ok,name=pcall(function() return item:getName() end) end
    if not name then return nil end
    local option=context:getOptionFromName(tostring(name))
    if not option then
        option=context:addOption(tostring(name),item,nil)
        local okTex,texture=pcall(function() return item:getTex() end)
        if okTex then option.iconTexture=texture end
        local menu=ISContextMenu:getNew(context)
        context:addSubMenu(option,menu)
        return menu
    end
    if option.subOption==nil then
        local menu=ISContextMenu:getNew(context)
        context:addSubMenu(option,menu)
        return menu
    end
    return context:getSubMenu(option.subOption)
end

local function actionNames()
    local names={
        ["Remove Battery"]="battery-remove", ["Insert Battery"]="battery-add", ["Add Battery"]="battery-add",
        ["Turn On"]="activation", ["Turn Off"]="activation", ["Device Options"]="device-controls",
        ["Set Alarm"]="alarm", ["Stop Alarm"]="alarm",
    }
    if type(getText)=="function" then
        local keys={
            ContextMenu_Remove_Battery="battery-remove", ContextMenu_AddBattery="battery-add",
            ContextMenu_Turn_On="activation", ContextMenu_Turn_Off="activation",
            IGUI_DeviceOptions="device-controls", ContextMenu_SetAlarm="alarm", ContextMenu_StopAlarm="alarm",
        }
        for key,kind in pairs(keys) do
            local ok,value=pcall(getText,key)
            if ok and value then names[tostring(value)]=kind end
        end
    end
    return names
end

local function installedpowerWorksBattery(item)
    local powerworks=rawget(_G,"powerWorks")
    if not powerworks or not powerworks.getInstalledBatteryType then return false end
    local consumer=item
    local ok,registered=pcall(function() return powerworks.getConsumerProfile(consumer)~=nil end)
    if not ok or not registered then
        local got,active=pcall(function() return item:getActiveLight() end)
        if got and active then consumer=active end
    end
    local found,batteryType=pcall(powerworks.getInstalledBatteryType,consumer)
    return found and batteryType~=nil
end

local function moveOption(source,target,index)
    local option=table.remove(source.options,index)
    if not option then return false end
    source.numOptions=math.max(1,(tonumber(source.numOptions) or (#source.options+2))-1)
    for position,entry in ipairs(source.options) do entry.id=position end
    option.id=#target.options+1
    target.options[option.id]=option
    target.numOptions=(tonumber(target.numOptions) or 1)+1
    source:calcHeight(); source:setWidth(source:calcWidth())
    target:calcHeight(); target:setWidth(target:calcWidth())
    return true
end

local function groupDeviceActions(_,context,rawItems)
    if not enabled() then return end
    if type(rawItems)~="table" or not context or type(context.options)~="table" then return end
    local selected=nil
    for _,entry in ipairs(rawItems) do
        local item=unwrap(entry)
        if isLight(item) then selected=item break end
    end
    if not selected then return end
    local names=actionNames()
    local occupied=installedpowerWorksBattery(selected)
    local indexes={}
    for index,option in ipairs(context.options) do
        local name=option and tostring(option.name) or nil
        local kind=name and names[name] or nil
        if kind then
            indexes[#indexes+1]={index=index,suppress=occupied and kind=="battery-add"}
        end
    end
    if #indexes==0 then return end
    local itemMenu=findItemMenu(context,selected)
    if not itemMenu then return end
    local removed=0
    for position=1,#indexes do
        local entry=indexes[position]
        local adjustedIndex=entry.index-removed
        if entry.suppress then
            table.remove(context.options,adjustedIndex)
            context.numOptions=math.max(1,(tonumber(context.numOptions) or (#context.options+2))-1)
            for optionIndex,option in ipairs(context.options) do option.id=optionIndex end
            context:calcHeight(); context:setWidth(context:calcWidth())
        else
            moveOption(context,itemMenu,adjustedIndex)
        end
        removed=removed+1
    end
end

local function safeGroup(...)
    local ok,err=pcall(groupDeviceActions,...)
    if not ok and not reportedFailure then
        reportedFailure=true
        print("[B47ANCEDEssentials] Inventory action grouping failed safely: "..tostring(err))
    end
end

if Events and Events.OnFillInventoryObjectContextMenu then
    Events.OnFillInventoryObjectContextMenu.Add(safeGroup)
end

B47ANCEDEssentials.groupDeviceActions=groupDeviceActions
-- Compatibility alias for integrations written against B47ANCEDEssentials 0.4.0.
B47ANCEDEssentials.groupBatteryActions=groupDeviceActions
return B47ANCEDEssentials
