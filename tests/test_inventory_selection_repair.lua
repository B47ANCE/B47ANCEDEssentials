local sourcePath=arg[1]
local first,second={},{}
ISInventoryPane={restoreSelection=function(self) self.selected[1]=first end}
local realRequire=require
require=function(name) if name=="ISUI/ISInventoryPane" then return ISInventoryPane end return realRequire(name) end
SandboxVars={B47ANCEDEssentials={EnableInventorySelectionRepair=true}}
dofile(sourcePath)

local group={name="Test",items={first,second}}
local pane={selected={},itemslist={group},collapsed={}}
setmetatable(pane,{__index=ISInventoryPane})
pane:restoreSelection({[first]="group"})
assert(pane.selected[1]==group,"grouped rows must restore the row, not only its first item")

pane.selected={}
pane:restoreSelection({[first]="item",[second]="item"})
assert(pane.selected[1]==first and pane.selected[2]==second,
    "individual selections must survive inventory refreshes, including the first item")

SandboxVars.B47ANCEDEssentials.EnableInventorySelectionRepair=false
pane.selected={}
pane:restoreSelection({[first]="group"})
assert(pane.selected[1]==first,"disabled repair must preserve the previously installed implementation")
print("B47ANCEDEssentials inventory-selection repair checks passed")
