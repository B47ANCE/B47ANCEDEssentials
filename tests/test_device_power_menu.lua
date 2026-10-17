Events={OnFillInventoryObjectContextMenu={Add=function() end}}
SandboxVars={B47ANCEDEssentials={EnableDeviceBatteryMenuGrouping=true}}
require=function() return true end

local battery={getFullType=function() return "powerWorks.BatteryAA" end}
local list={size=function() return 1 end,get=function() return battery end}
local inventory={getAllEvalRecurse=function(_,predicate) assert(predicate(battery)); return list end}
local player={getInventory=function() return inventory end}
getSpecificPlayer=function() return player end
local queued={}
powerWorks={
    getConsumerProfile=function() return {sizes={"AA"}} end,
    isRegisteredBattery=function() return true end, accepts=function() return true end,
    getCharge=function() return 50 end,
    getBatteryProfile=function(value) return {displayName=value=="powerWorks.BatteryAA" and "AA Battery" or "AA Battery",capacity=100} end,
    getInstalledBatteryType=function() return nil end,
    queueInstallBattery=function(...) queued={...}; return true end,
}
local submenu={options={}}
function submenu:addOption(name,target,callback,...) local o={name=name,target=target,onSelect=callback,args={...}}; self.options[#self.options+1]=o; return o end
function submenu:addSubMenu(option,menu) option.menu=menu end
ISContextMenu={getNew=function() return setmetatable({options={}},{__index=submenu}) end}
local context={options={},submenus={}}
function context:getOptionFromName(name) for _,o in ipairs(self.options) do if o.name==name then return o end end end
function context:addOption(name,target,callback) local o={name=name,target=target,onSelect=callback}; self.options[#self.options+1]=o; return o end
function context:addSubMenu(option,menu) option.subOption=#self.submenus+1; self.submenus[option.subOption]=menu end
function context:getSubMenu(index) return self.submenus[index] end
local light={getDisplayName=function() return "Flashlight" end,getFullType=function() return "Base.HandTorch" end,getTex=function() return "icon" end}

local B47ANCEDEssentials=dofile(arg[1])
B47ANCEDEssentials.addDevicePowerActions(0,context,{light})
assert(#context.options==1 and context.options[1].name=="Flashlight")
local deviceMenu=context:getSubMenu(context.options[1].subOption)
assert(#deviceMenu.options==1 and deviceMenu.options[1].name=="Insert Battery")
assert(#deviceMenu.options[1].menu.options==1 and deviceMenu.options[1].menu.options[1].name=="AA Battery (50%)")
print("B47ANCEDEssentials device-power menu checks passed")

-- Weapon wrappers resolve their mounted consumer; occupied consumers expose
-- remove + replace rather than a duplicate insertion action.
local mounted={getFullType=function() return "Base.GunLight" end}
local weapon={getDisplayName=function() return "Pistol" end,getActiveLight=function() return mounted end,getTex=function() return "weapon" end}
powerWorks.getConsumerProfile=function(value) return value==mounted and {sizes={"AA"}} or nil end
powerWorks.getInstalledBatteryType=function(value) return value==mounted and "powerWorks.BatteryAA" or nil end
local occupiedContext={options={},submenus={}}
for key,value in pairs({getOptionFromName=context.getOptionFromName,addOption=context.addOption,
    addSubMenu=context.addSubMenu,getSubMenu=context.getSubMenu}) do occupiedContext[key]=value end
B47ANCEDEssentials.addDevicePowerActions(0,occupiedContext,{weapon})
local weaponMenu=occupiedContext:getSubMenu(occupiedContext.options[1].subOption)
assert(weaponMenu.options[1].name=="Remove AA Battery" and weaponMenu.options[2].name=="Replace Battery")

-- Two-cell consumers expose one complete set, never an invalid single-cell
-- callback. B47ANCEDEssentials presents it; powerWorks owns selection and validation.
local battery2={getFullType=function() return "powerWorks.BatteryAA" end}
list={size=function() return 2 end,get=function(_,index) return index==0 and battery or battery2 end}
powerWorks.getConsumerProfile=function() return {sizes={"AA"},nominalCellCount=2} end
powerWorks.getBatteryProfile=function() return {displayName="AA Battery",size="AA",capacity=100} end
powerWorks.getRequiredCellCount=function() return 2 end
powerWorks.selectBatterySet=function(_,candidates) return {candidates[1],candidates[2]} end
local multiContext={options={},submenus={}}
for key,value in pairs({getOptionFromName=context.getOptionFromName,addOption=context.addOption,
    addSubMenu=context.addSubMenu,getSubMenu=context.getSubMenu}) do multiContext[key]=value end
B47ANCEDEssentials.addDevicePowerActions(0,multiContext,{light})
local multiMenu=multiContext:getSubMenu(multiContext.options[1].subOption)
local choice=multiMenu.options[1].menu.options[1]
assert(choice.name=="2× AA cells (up to 50%)" and type(choice.args[3])=="table" and #choice.args[3]==2)
