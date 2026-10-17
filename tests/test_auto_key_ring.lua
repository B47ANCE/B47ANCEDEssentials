local sourcePath=arg[1]
local function list(values)
    return {size=function() return #values end,get=function(_,index) return values[index+1] end}
end
local function container(values)
    local c={values=values}
    function c:getItems() return list(self.values) end
    function c:hasRoomFor() return true end
    return c
end
local function item(kind,source,nested,favorite,class)
    return {class=class,getFullType=function() return kind end,getContainer=function() return source end,
        getInventory=function() return nested end,isFavorite=function() return favorite==true end}
end
ISInventoryTransferAction={new=function(_,player,value,source,destination)
    return {player=player,item=value,source=source,destination=destination}
end}
local queued={}
ISTimedActionQueue={add=function(action) queued[#queued+1]=action end}
Events={EveryOneMinute={Add=function() end}}
getSpecificPlayer=function() return nil end
instanceof=function(value,class) return value.class==class end
local realRequire=require
require=function(name)
    if name=="TimedActions/ISInventoryTransferAction" then return ISInventoryTransferAction end
    if name=="TimedActions/ISTimedActionQueue" then return ISTimedActionQueue end
    return realRequire(name)
end
SandboxVars={B47ANCEDEssentials={EnableAutoKeyRing=true,AutoKeyRingIncludeNestedInventory=true,
    AutoKeyRingPreserveFavorites=true,AutoKeyRingMaxTransfersPerPass=2}}

local main=container({}); local ringInventory=container({})
local ring=item("Base.KeyRing_RabbitFoot",main,ringInventory,false)
local key=item("Base.Key1",main,nil,false,"Key")
local favorite=item("Base.CarKey",main,nil,true,"Key")
local nestedContainer=container({}); local bag=item("Base.Bag",main,nestedContainer,false)
local nestedKey=item("Modded.VehicleKey",nestedContainer,nil,false,"Key")
main.values={ring,key,favorite,bag}; nestedContainer.values={nestedKey}
local player={getInventory=function() return main end}
local B47ANCEDEssentials=dofile(sourcePath)
local plan=B47ANCEDEssentials.planKeyTransfers(player)
assert(#plan==2 and plan[1].item==key and plan[2].item==nestedKey,"loose and nested keys must be planned")
assert(B47ANCEDEssentials.queueKeyTransfers(player)==2 and #queued==2,"planned keys must use native timed transfers")
SandboxVars.B47ANCEDEssentials.EnableAutoKeyRing=false
assert(#B47ANCEDEssentials.planKeyTransfers(player)==0,"sandbox toggle must disable key filing")
print("B47ANCEDEssentials auto-key-ring checks passed")
