local sourcePath=arg[1]
local hook
Events={OnFillInventoryObjectContextMenu={Add=function(fn)hook=fn end}}
SandboxVars={B47ANCEDEssentials={EnableLiteratureTracking=true,EnableRecordedMediaTracking=true,
    EnableMediaRewardHints=true,LiteratureInventoryScanLimit=75}}
local item={getFullType=function()return"Base.BookTest"end}
local inventory={}
local player={getInventory=function()return inventory end}
getSpecificPlayer=function(index)assert(index==0);return player end
getText=function(key,...)return key end

local calls={copies={}}
B47ANCEDEssentials={
    literatureStatus=function(receivedPlayer,receivedItem)
        assert(receivedPlayer==player and receivedItem==item)
        return"partial",20,100
    end,
    recordedMediaStatus=function()error("literature status must take precedence")end,
    countCarriedCopies=function(inventory,fullType,maximum)
        calls.copies={inventory=inventory,fullType=fullType,maximum=maximum};return 2,false
    end,
    mediaRewards=function(received)assert(received==item);return{"Recipe: Useful Thing"}end,
}
package.preload["B47ANCEDEssentials/LiteratureCore"]=function()return B47ANCEDEssentials end
local options={}
local context={addOption=function(_,label)local option={label=label};options[#options+1]=option;return option end}

assert(dofile(sourcePath)==B47ANCEDEssentials and type(hook)=="function",
    "literature tracking must register its safe inventory hook")
hook(0,context,{{items={item}}})
assert(#options==2,"literature status and reward hint must each add one informational option")
assert(options[1].notAvailable==true and options[1].itemForTexture==item,
    "status option must be disabled and retain the item icon")
assert(options[2].notAvailable==true and options[2].itemForTexture==item,
    "reward option must be disabled and retain the item icon")
assert(calls.copies.inventory==inventory and calls.copies.fullType=="Base.BookTest"
    and calls.copies.maximum==75,"duplicate counting must honor the configured bounded scan")

options={};SandboxVars.B47ANCEDEssentials.EnableLiteratureTracking=false
hook(0,context,{{items={item}}})
assert(#options==0,"disabling literature tracking must suppress status and reward presentation")

SandboxVars.B47ANCEDEssentials.EnableLiteratureTracking=true
B47ANCEDEssentials.literatureStatus=function()return nil end
B47ANCEDEssentials.recordedMediaStatus=function()return"watched",3,3 end
B47ANCEDEssentials.mediaRewards=function()return{}end
options={};hook(0,context,{item})
assert(#options==1 and options[1].itemForTexture==item,
    "recorded media must use its own status path and preserve the item icon")

SandboxVars.B47ANCEDEssentials.EnableRecordedMediaTracking=false
options={};hook(0,context,{item})
assert(#options==0,"recorded-media status must honor its independent switch")

package.preload["B47ANCEDEssentials/LiteratureCore"]=nil
package.loaded["B47ANCEDEssentials/LiteratureCore"]=nil
print("B47ANCEDEssentials literature-tracking context checks passed")
