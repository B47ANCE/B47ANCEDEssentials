-- B47ANCEDEssentials owns device-menu presentation. powerWorks remains the sole owner of
-- battery compatibility, charge state, timings, and mutations.
B47ANCEDEssentials=B47ANCEDEssentials or {}

local reportedFailure=false

local function enabled()
    local root=rawget(_G,"SandboxVars")
    local values=root and root.B47ANCEDEssentials or nil
    return not values or values.EnableDeviceBatteryMenuGrouping~=false
end

local function unwrap(entry)
    local ok,item=pcall(function() return entry and entry.items and entry.items[1] or entry end)
    return ok and item or nil
end

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function fullType(item)
    local ok,value=call(item,"getFullType")
    return ok and value or nil
end

local function resolveConsumer(item,power)
    if not item or not power then return nil end
    local ok,profile=pcall(power.getConsumerProfile,item)
    if ok and profile then return item end
    local got,active=call(item,"getActiveLight")
    if got and active then
        ok,profile=pcall(power.getConsumerProfile,active)
        if ok and profile then return active end
    end
    return nil
end

local function itemMenu(context,item)
    local _,name=call(item,"getDisplayName")
    if not name then _,name=call(item,"getName") end
    if not name then return nil end
    local option=context:getOptionFromName(tostring(name))
    if not option then option=context:addOption(tostring(name),item,nil) end
    local menu=option.subOption and context:getSubMenu(option.subOption) or nil
    if not menu then
        menu=ISContextMenu:getNew(context)
        context:addSubMenu(option,menu)
    end
    if not option.iconTexture then local _,texture=call(item,"getTex"); option.iconTexture=texture end
    return menu
end

local function carriedBatteries(player,power,consumer)
    local _,inventory=call(player,"getInventory")
    local ok,items=call(inventory,"getAllEvalRecurse",function(candidate)
        local good,registered=pcall(power.isRegisteredBattery,candidate)
        if not good or not registered or fullType(candidate)=="Base.Battery" then return false end
        local acceptsOK,accepts=pcall(power.accepts,consumer,candidate)
        local chargeOK,charge=pcall(power.getCharge,candidate)
        return acceptsOK and accepts and chargeOK and (tonumber(charge) or 0)>0
    end)
    if not ok or not items then return {} end
    local result={}; local _,count=call(items,"size")
    for index=0,(tonumber(count) or 0)-1 do local got,item=call(items,"get",index); if got and item then result[#result+1]=item end end
    return result
end

local function queue(mode,player,consumer,battery)
    local power=rawget(_G,"powerWorks")
    if not power then return false end
    if mode=="install" and power.queueInstallBattery then return power.queueInstallBattery(player,consumer,battery) end
    if mode=="replace" and power.queueReplaceBattery then return power.queueReplaceBattery(player,consumer,battery) end
    if mode=="remove" and power.queueExtractBattery then return power.queueExtractBattery(player,consumer) end
    local fn=mode=="install" and power.installBattery or mode=="replace" and power.replaceBattery or power.extractBattery
    local ok,result,reason=pcall(fn,player,consumer,battery)
    if not ok or not result then print("[B47ANCEDEssentials][DevicePowerMenu] "..mode.." failed safely: "..tostring(reason or result)) end
    return ok and result==true
end

local function addChoices(context,menu,label,player,consumer,batteries,mode,power)
    if #batteries==0 then return end
    local root=menu:addOption(label,consumer,nil)
    local sub=ISContextMenu:getNew(context); menu:addSubMenu(root,sub)
    local choices={}
    local seen={}
    for _,battery in ipairs(batteries) do
        local profile=power.getBatteryProfile(battery) or {}; local size=tostring(profile.size or "?")
        local required=power.getRequiredCellCount and power.getRequiredCellCount(consumer,battery) or 1
        if (required or 1)<=1 then
            choices[#choices+1]={input=battery,battery=battery}
        elseif not seen[size] then
                seen[size]=true
                local set=power.selectBatterySet and power.selectBatterySet(consumer,batteries,battery) or nil
                if set then choices[#choices+1]={input=set,battery=set[1],count=#set,size=size} end
        end
    end
    for _,choice in ipairs(choices) do
        local battery=choice.battery
        local profile=power.getBatteryProfile(battery) or {}
        local capacity=math.max(tonumber(profile.capacity) or 1,0.0001)
        local percent=math.floor(((tonumber(power.getCharge(battery)) or 0)/capacity)*100+0.5)
        local text=choice.count and string.format("%d× %s cells (up to %d%%)",choice.count,choice.size,percent)
            or string.format("%s (%d%%)",tostring(profile.displayName or fullType(battery) or "Battery"),percent)
        sub:addOption(text,player,queue,mode,consumer,choice.input)
    end
end

local function addPowerActions(playerNum,context,rawItems)
    if not enabled() or type(rawItems)~="table" or not context then return end
    local power=rawget(_G,"powerWorks")
    if not power or not power.getConsumerProfile then return end
    pcall(require,"powerWorks/powerWorks_BatteryAction")
    local selected,consumer
    for _,entry in ipairs(rawItems) do
        local item=unwrap(entry); local candidate=resolveConsumer(item,power)
        if candidate then selected,consumer=item,candidate break end
    end
    if not selected then return end
    local player=type(getSpecificPlayer)=="function" and getSpecificPlayer(playerNum) or nil
    if not player then return end
    local menu=itemMenu(context,selected); if not menu then return end
    local batteries=carriedBatteries(player,power,consumer)
    local installed=power.getInstalledBatteryType(consumer)
    if installed then
        local profile=power.getBatteryProfile(installed) or {}
        local set=power.getInstalledCellSet and power.getInstalledCellSet(consumer) or nil
        local count=set and set.cells and #set.cells or 1
        local removeLabel=count>1 and ("Remove "..count.." Batteries")
            or ("Remove "..tostring(profile.displayName or "Battery"))
        menu:addOption(removeLabel,player,queue,"remove",consumer,nil)
        addChoices(context,menu,count>1 and "Replace Batteries" or "Replace Battery",player,consumer,batteries,"replace",power)
    else
        addChoices(context,menu,"Insert Battery",player,consumer,batteries,"install",power)
    end
end

local function safeAdd(...)
    local ok,err=pcall(addPowerActions,...)
    if not ok and not reportedFailure then
        reportedFailure=true
        print("[B47ANCEDEssentials][DevicePowerMenu] context integration failed safely: "..tostring(err))
    end
end

if Events and Events.OnFillInventoryObjectContextMenu then Events.OnFillInventoryObjectContextMenu.Add(safeAdd) end
B47ANCEDEssentials.addDevicePowerActions=addPowerActions
return B47ANCEDEssentials
