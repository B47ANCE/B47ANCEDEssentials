local sourcePath=arg[1]
package.preload["Hotbar/ISHotbar"]=function() ISHotbar={doMenu=function() end}; return true end
SandboxVars={B47ANCEDEssentials={EnableHotbarReordering=true}}
local changed={}
local function item(name) return {name=name,setAttachedSlot=function(self,index) changed[self.name]=index end} end
local first,second=item("first"),item("second")
local hotbar={availableSlot={{slotType="A"},{slotType="B"}},attachedItems={first,second},
    savePosition=function(self) self.saved=true end,reloadIcons=function(self) self.reloaded=true end}
local B47ANCEDEssentials=dofile(sourcePath)
assert(B47ANCEDEssentials.moveHotbarSlot(hotbar,1,2)==true,"valid slots should swap")
assert(hotbar.availableSlot[1].slotType=="B" and hotbar.attachedItems[1]==second,"slot and item must move together")
assert(changed.second==1 and changed.first==2,"engine attachment indexes must follow the new order")
assert(hotbar.saved and hotbar.reloaded,"hotbar order should persist and redraw")
assert(B47ANCEDEssentials.moveHotbarSlot(hotbar,1,3)==false,"invalid moves must fail without mutation")
print("B47ANCEDEssentials hotbar-reordering checks passed")
