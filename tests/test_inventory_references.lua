local function list(values)return{size=function()return#values end,get=function(_,index)return values[index+1]end}end
local nestedItem={getID=function()return 84 end};local nested={getItems=function()return list({nestedItem})end}
local item={getID=function()return 42 end,getInventory=function()return nested end};local container={getItems=function()return list({item})end}
local object={getContainerByIndex=function(_,index)return index==1 and container or nil end}
local square={getObjects=function()return list({object})end}
object.getContainerCount=function()return 2 end;object.getSquare=function()return square end
square.getX=function()return 10 end;square.getY=function()return 20 end;square.getZ=function()return 0 end
square.getObjects=function()local values={object};local result=list(values);result.indexOf=function(_,target)return target==object and 0 or-1 end;return result end
getCell=function()return{getGridSquare=function(_,x,y,z)if x==10 and y==20 and z==0 then return square end end}end
local vehicleContainer={getItems=function()return list({})end};local vehicle
local vehiclePart={getId=function()return"TruckBed"end,getItemContainer=function()return vehicleContainer end}
vehicle={getId=function()return 77 end,getPartById=function(_,id)return id=="TruckBed"and vehiclePart or nil end}
vehiclePart.getVehicle=function()return vehicle end;vehicleContainer.getVehiclePart=function()return vehiclePart end
local corpseContainer={getItems=function()return list({})end};local corpse={getObjectIDAsLong=function()return 9001 end,
    getContainer=function()return corpseContainer end,getSquare=function()return square end}
square.getStaticMovingObjects=function()return list({corpse})end
getCell=function()return{getGridSquare=function(_,x,y,z)if x==10 and y==20 and z==0 then return square end end,
    getVehicles=function()return list({vehicle})end}end
local References=dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua")
local reference=References.worldContainer(10,20,0,0,1)
local described=assert(References.describeWorldContainer(object,container));assert(described.providerId=="world"and described.containerIndex==1)
assert(References.resolveContainer({},reference)==container,"exact world reference must resolve")
local resolved,reason,parent=References.resolveItem({},assert(References.item(reference,42)))
assert(resolved==item and reason==nil and parent==container,"item identity must resolve inside its exact container")
reference.objectIndex=0.5;assert(select(2,References.resolveContainer({},reference))=="INVALID_REFERENCE")
assert(select(2,References.resolveItem({}, {schemaVersion=1,container=References.worldContainer(10,20,0,0,1),itemId="missing"}))=="ITEM_UNAVAILABLE")
References.registerProvider{id="fixture",resolveContainer=function(actor,value)
    if actor.id==value.actorId then return container end return nil,"ACTOR_MISMATCH"end}
assert(References.resolveContainer({id="a"},{schemaVersion=1,providerId="fixture",actorId="a"})==container)
assert(select(2,References.resolveContainer({id="b"},{schemaVersion=1,providerId="fixture",actorId="a"}))=="ACTOR_MISMATCH")
local actor={getInventory=function()return container end}
local actorRoot=References.actorRoot();assert(References.resolveContainer(actor,actorRoot)==container)
assert(select(2,References.resolveContainer(actor,{schemaVersion=1,providerId="actor",kind="nested"}))=="INVALID_REFERENCE")
assert(References.resolveItem(actor,assert(References.item(actorRoot,42)))==item)
local actorPath=assert(References.actorPath({42}));assert(References.resolveContainer(actor,actorPath)==nested)
assert(References.resolveItem(actor,assert(References.item(actorPath,84)))==nestedItem)
assert(select(2,References.resolveContainer(actor,References.actorPath({99})))=="PATH_ITEM_UNAVAILABLE")
assert(References.actorPath({})==nil and References.actorPath({string.rep("x",161)})==nil)
local vehicleReference=assert(References.vehicleContainer(77,"TruckBed"))
assert(References.resolveContainer(actor,vehicleReference)==vehicleContainer)
local describedVehicle=assert(References.describeVehicleContainer(vehicleContainer))
assert(describedVehicle.vehicleId==77 and describedVehicle.partId=="TruckBed")
assert(select(2,References.resolveContainer(actor,References.vehicleContainer(78,"TruckBed")))=="VEHICLE_UNAVAILABLE")
local corpseReference=assert(References.corpseContainer(10,20,0,9001))
assert(References.resolveContainer(actor,corpseReference)==corpseContainer)
local describedCorpse=assert(References.describeCorpseContainer(corpse,corpseContainer))
assert(describedCorpse.objectId=="9001")
assert(select(2,References.resolveContainer(actor,References.corpseContainer(10,20,0,9002)))=="CORPSE_UNAVAILABLE")
print("test_inventory_references.lua: PASS")
