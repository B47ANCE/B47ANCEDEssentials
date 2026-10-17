local sourcePath=arg[1]
local function list(values) return {size=function() return #values end,get=function(_,i) return values[i+1] end} end
local function container(values) return {getItems=function() return list(values) end} end
local ammoType={getItemKey=function() return "Base.9mmRound" end}
local function item(kind,current,maximum,source,nested)
    return {getFullType=function() return kind end,getCurrentAmmoCount=function() return current end,
        getMaxAmmo=function() return maximum end,getAmmoType=function() return ammoType end,
        getContainer=function() return source end,getInventory=function() return nested end}
end
ISInventoryPaneContextMenu={doMagazineMenu=function() end}
ISInventoryTransferAction={new=function() return {} end}
ISLoadBulletsInMagazine={new=function(_,player,magazine,amount) return {magazine=magazine,amount=amount} end}
ISUnloadBulletsFromMagazine={new=function(_,player,magazine) return {magazine=magazine} end}
ISTimedActionQueue={add=function() end,addAfter=function() end}
local realRequire=require
require=function(name)
    if name=="ISUI/ISInventoryPaneContextMenu" then return ISInventoryPaneContextMenu end
    if name:find("ISInventoryTransferAction",1,true) then return ISInventoryTransferAction end
    if name:find("ISTimedActionQueue",1,true) then return ISTimedActionQueue end
    if name:find("ISLoadBulletsInMagazine",1,true) then return ISLoadBulletsInMagazine end
    if name:find("ISUnloadBulletsFromMagazine",1,true) then return ISUnloadBulletsFromMagazine end
    return realRequire(name)
end
SandboxVars={B47ANCEDEssentials={EnableBulkMagazineActions=true,BulkMagazinesIncludeNestedInventory=true,BulkMagazinesMaximumPerAction=50}}
local main=container({}); local bagInventory=container({})
local mag1=item("Base.9mmClip",5,15,main); local mag2=item("Base.9mmClip",10,15,bagInventory)
local bag=item("Base.Bag",0,0,main,bagInventory); local rounds={}
for index=1,12 do rounds[index]=item("Base.9mmRound",0,0,index<=6 and main or bagInventory) end
main.getItems=function() local values={mag1,bag}; for i=1,6 do values[#values+1]=rounds[i] end return list(values) end
bagInventory.getItems=function() local values={mag2}; for i=7,12 do values[#values+1]=rounds[i] end return list(values) end
local player={getInventory=function() return main end}
local B47ANCEDEssentials=dofile(sourcePath)
local plan=B47ANCEDEssentials.buildBulkMagazinePlan(player,mag1,false)
assert(#plan==2 and plan[1].magazine==mag2,"fullest matching magazine must load first")
assert(plan[1].amount==5 and plan[2].amount==7,"available rounds must be reserved exactly once")
local seen={}; for _,entry in ipairs(plan) do for _,round in ipairs(entry.rounds) do assert(not seen[round]); seen[round]=true end end
SandboxVars.B47ANCEDEssentials.EnableBulkMagazineActions=false
assert(#B47ANCEDEssentials.buildBulkMagazinePlan(player,mag1,false)==0,"sandbox toggle must disable bulk actions")
print("B47ANCEDEssentials bulk-magazine checks passed")
