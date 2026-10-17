Events={OnFillInventoryObjectContextMenu={Add=function() end}}
SandboxVars={B47ANCEDEssentials={EnableDeviceBatteryMenuGrouping=true}}
getText=function(key)
    local values={ContextMenu_Remove_Battery="Remove Battery",ContextMenu_AddBattery="Add Battery",
        ContextMenu_Turn_On="Turn On",ContextMenu_Turn_Off="Turn Off",IGUI_DeviceOptions="Device Options",
        ContextMenu_SetAlarm="Set Alarm",ContextMenu_StopAlarm="Stop Alarm"}
    return values[key] or key
end

local submenu={options={},numOptions=1,calcHeight=function() end,calcWidth=function() return 100 end,setWidth=function() end}
ISContextMenu={getNew=function() return submenu end}
local remove={id=1,name="Remove Battery",target="vanilla-target",onSelect="vanilla-callback",param1="original-param"}
local context={options={remove},numOptions=2,submenus={}}
function context:getOptionFromName(name) for _,option in ipairs(self.options) do if option.name==name then return option end end end
function context:addOption(name,target,onSelect) local option={id=#self.options+1,name=name,target=target,onSelect=onSelect}; self.options[#self.options+1]=option; self.numOptions=self.numOptions+1; return option end
function context:addSubMenu(option,menu) option.subOption=1; self.submenus[1]=menu end
function context:getSubMenu(id) return self.submenus[id] end
function context:calcHeight() end
function context:calcWidth() return 100 end
function context:setWidth() end

local light={canEmitLight=function() return true end,getDisplayName=function() return "Flashlight" end,getTex=function() return "icon" end}
local B47ANCEDEssentials=dofile(arg[1])
B47ANCEDEssentials.groupBatteryActions(0,context,{light})
assert(#context.options==1 and context.options[1].name=="Flashlight","root must retain only device submenu")
assert(#submenu.options==1 and submenu.options[1]==remove,"original vanilla action object must move intact")
assert(remove.target=="vanilla-target" and remove.onSelect=="vanilla-callback" and remove.param1=="original-param",
    "relocation must preserve callback ownership and parameters")
print("B47ANCEDEssentials inventory action-grouping checks passed")

submenu.options={}; submenu.numOptions=1
local turnOn={id=1,name="Turn On",target=light,onSelect="activate"}
local controls={id=2,name="Device Options",target="player",onSelect="radio-panel"}
local drop={id=3,name="Drop",target=light,onSelect="drop"}
local deviceContext={options={turnOn,controls,drop},numOptions=4,submenus={}}
for key,value in pairs({getOptionFromName=context.getOptionFromName,addOption=context.addOption,
    addSubMenu=context.addSubMenu,getSubMenu=context.getSubMenu,calcHeight=context.calcHeight,
    calcWidth=context.calcWidth,setWidth=context.setWidth}) do deviceContext[key]=value end
B47ANCEDEssentials.groupDeviceActions(0,deviceContext,{light})
assert(#deviceContext.options==2 and deviceContext.options[1]==drop and deviceContext.options[2].name=="Flashlight",
    "generic inventory actions must remain at root beside the device submenu")
assert(#submenu.options==2 and submenu.options[1]==turnOn and submenu.options[2]==controls,
    "activation and control-panel callbacks must move intact")

submenu.options={}; submenu.numOptions=1
local add={id=1,name="Add Battery",target="vanilla-target",onSelect="vanilla-add"}
local removeOccupied={id=2,name="Remove Battery",target="vanilla-target",onSelect="vanilla-remove"}
local occupiedContext={options={add,removeOccupied},numOptions=3,submenus={}}
for key,value in pairs({getOptionFromName=context.getOptionFromName,addOption=context.addOption,
    addSubMenu=context.addSubMenu,getSubMenu=context.getSubMenu,calcHeight=context.calcHeight,
    calcWidth=context.calcWidth,setWidth=context.setWidth}) do occupiedContext[key]=value end
powerWorks={getConsumerProfile=function() return {} end,getInstalledBatteryType=function() return "powerWorks.BatteryAA" end}
B47ANCEDEssentials.groupBatteryActions(0,occupiedContext,{light})
assert(#occupiedContext.options==1 and occupiedContext.options[1].name=="Flashlight",
    "occupied powerWorks consumers must suppress the duplicate vanilla add action")
assert(#submenu.options==1 and submenu.options[1]==removeOccupied,
    "occupied consumers must preserve and relocate the vanilla remove callback")

SandboxVars.B47ANCEDEssentials.EnableDeviceBatteryMenuGrouping=false
local untouched={options={{id=1,name="Remove Battery"}},numOptions=2,submenus={}}
for key,value in pairs({getOptionFromName=context.getOptionFromName,addOption=context.addOption,
    addSubMenu=context.addSubMenu,getSubMenu=context.getSubMenu,calcHeight=context.calcHeight,
    calcWidth=context.calcWidth,setWidth=context.setWidth}) do untouched[key]=value end
B47ANCEDEssentials.groupBatteryActions(0,untouched,{light})
assert(#untouched.options==1 and untouched.options[1].name=="Remove Battery",
    "disabled grouping must leave the vanilla context menu untouched")
