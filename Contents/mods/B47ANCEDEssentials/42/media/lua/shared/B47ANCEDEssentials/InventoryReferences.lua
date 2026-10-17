B47ANCEDEssentials=B47ANCEDEssentials or{}
B47ANCEDEssentials.InventoryReferences=B47ANCEDEssentials.InventoryReferences or{}
local References=B47ANCEDEssentials.InventoryReferences

References.SCHEMA_VERSION=1
local providers={}

local function integer(value,minimum,maximum)
    value=tonumber(value)
    if not value or value~=math.floor(value)or value<minimum or value>maximum then return nil end
    return value
end
local function valid(value,maximum)
    return type(value)=="string"and#value>0 and#value<=(maximum or 160)and value:match("^[%w_%.:%-]+$")~=nil
end
local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function()return object[method]end)
    if not ok or type(fn)~="function"then return nil end
    local called,value=pcall(fn,object,...);return called and value or nil
end

function References.registerProvider(definition)
    assert(type(definition)=="table"and valid(definition.id),"inventory reference provider id required")
    assert(type(definition.resolveContainer)=="function","inventory reference provider resolver required")
    assert(not providers[definition.id],"duplicate inventory reference provider: "..definition.id)
    providers[definition.id]={id=definition.id,resolveContainer=definition.resolveContainer,
        resolveItem=definition.resolveItem,describeContainer=definition.describeContainer,describeItem=definition.describeItem}
    return{id=definition.id}
end

local function worldContainer(reference)
    local x=integer(reference.x,-30000000,30000000);local y=integer(reference.y,-30000000,30000000)
    local z=integer(reference.z,-32,32);local objectIndex=integer(reference.objectIndex,0,4095)
    local containerIndex=integer(reference.containerIndex,0,255)
    if not x or not y or not z or not objectIndex or not containerIndex then return nil,"INVALID_REFERENCE"end
    local cell=type(rawget(_G,"getCell"))=="function"and getCell()or nil
    local square=call(cell,"getGridSquare",x,y,z);if not square then return nil,"SQUARE_UNAVAILABLE"end
    local object=call(call(square,"getObjects"),"get",objectIndex);if not object then return nil,"OBJECT_UNAVAILABLE"end
    local container=call(object,"getContainerByIndex",containerIndex)
    if not container then return nil,"CONTAINER_UNAVAILABLE"end
    return container,nil,{providerId="world",x=x,y=y,z=z,objectIndex=objectIndex,containerIndex=containerIndex}
end

providers.world={id="world",resolveContainer=function(_,reference)return worldContainer(reference)end}
providers.vehicle={id="vehicle",resolveContainer=function(_,reference)
    local vehicleId=integer(reference.vehicleId,0,2147483647)
    if not vehicleId or not valid(reference.partId)then return nil,"INVALID_REFERENCE"end
    local cell=type(rawget(_G,"getCell"))=="function"and getCell()or nil
    local vehicles=call(cell,"getVehicles");local size=integer(call(vehicles,"size"),0,4096)or 0
    for index=0,size-1 do
        local vehicle=call(vehicles,"get",index)
        if integer(call(vehicle,"getId"),0,2147483647)==vehicleId then
            local part=call(vehicle,"getPartById",reference.partId)
            local container=call(part,"getItemContainer")
            if not part then return nil,"PART_UNAVAILABLE"end
            if not container then return nil,"CONTAINER_UNAVAILABLE"end
            return container,nil,{schemaVersion=1,providerId="vehicle",vehicleId=vehicleId,partId=reference.partId}
        end
    end
    return nil,"VEHICLE_UNAVAILABLE"
end}
providers.corpse={id="corpse",resolveContainer=function(_,reference)
    local x=integer(reference.x,-30000000,30000000);local y=integer(reference.y,-30000000,30000000)
    local z=integer(reference.z,-32,32);local objectId=tostring(reference.objectId or"")
    if not x or not y or not z or not objectId:match("^%d+$")or#objectId>20 then return nil,"INVALID_REFERENCE"end
    local cell=type(rawget(_G,"getCell"))=="function"and getCell()or nil
    local square=call(cell,"getGridSquare",x,y,z);if not square then return nil,"SQUARE_UNAVAILABLE"end
    local objects=call(square,"getStaticMovingObjects");local size=integer(call(objects,"size"),0,1024)or 0
    for index=0,size-1 do
        local object=call(objects,"get",index)
        if tostring(call(object,"getObjectIDAsLong")or"")==objectId then
            local container=call(object,"getContainer")
            if not container then return nil,"CONTAINER_UNAVAILABLE"end
            return container,nil,{schemaVersion=1,providerId="corpse",x=x,y=y,z=z,objectId=objectId}
        end
    end
    return nil,"CORPSE_UNAVAILABLE"
end}
local function findItem(container,itemId)
    local items=call(container,"getItems");local size=integer(call(items,"size"),0,100000)or 0
    for index=0,size-1 do
        local item=call(items,"get",index);local id=call(item,"getID")
        if id~=nil and tostring(id)==itemId then return item end
    end
end
providers.actor={id="actor",resolveContainer=function(actor,reference)
    local inventory=call(actor,"getInventory");if not inventory then return nil,"CONTAINER_UNAVAILABLE"end
    if reference.kind=="root"then
        return inventory,nil,{schemaVersion=1,providerId="actor",kind="root"}
    end
    if reference.kind~="path"or type(reference.itemPath)~="table"or#reference.itemPath<1 or#reference.itemPath>16 then
        return nil,"INVALID_REFERENCE"
    end
    local canonical={schemaVersion=1,providerId="actor",kind="path",itemPath={}}
    local container=inventory
    for index,itemId in ipairs(reference.itemPath)do
        itemId=tostring(itemId or"");if not valid(itemId)then return nil,"INVALID_REFERENCE"end
        canonical.itemPath[index]=itemId
        local item=findItem(container,itemId);if not item then return nil,"PATH_ITEM_UNAVAILABLE"end
        container=call(item,"getInventory")or call(item,"getItemContainer")
        if not container then return nil,"PATH_CONTAINER_UNAVAILABLE"end
    end
    return container,nil,canonical
end}

function References.resolveContainer(actor,reference)
    if type(reference)~="table"or reference.schemaVersion~=1 or not valid(reference.providerId)then
        return nil,"INVALID_REFERENCE"
    end
    local provider=providers[reference.providerId];if not provider then return nil,"PROVIDER_UNAVAILABLE"end
    local ok,container,reason,canonical=pcall(provider.resolveContainer,actor,reference)
    if not ok then return nil,"RESOLVER_FAILED"end
    if not container then return nil,tostring(reason or"CONTAINER_UNAVAILABLE")end
    return container,nil,canonical
end

function References.resolveItem(actor,reference)
    if type(reference)~="table"or reference.schemaVersion~=1 or type(reference.container)~="table"
        or not valid(reference.itemId)then return nil,"INVALID_REFERENCE"end
    local container,reason=References.resolveContainer(actor,reference.container);if not container then return nil,reason end
    local provider=providers[reference.container.providerId]
    if type(provider.resolveItem)=="function"then
        local ok,item,itemReason=pcall(provider.resolveItem,actor,container,reference)
        if not ok then return nil,"RESOLVER_FAILED"end
        return item,item and nil or tostring(itemReason or"ITEM_UNAVAILABLE"),container
    end
    local items=call(container,"getItems");local size=integer(call(items,"size"),0,100000)or 0
    for index=0,size-1 do
        local item=call(items,"get",index);local id=call(item,"getID")
        if id~=nil and tostring(id)==reference.itemId then return item,nil,container end
    end
    return nil,"ITEM_UNAVAILABLE"
end

function References.worldContainer(x,y,z,objectIndex,containerIndex)
    return{schemaVersion=1,providerId="world",x=x,y=y,z=z,objectIndex=objectIndex,containerIndex=containerIndex}
end
function References.vehicleContainer(vehicleId,partId)
    vehicleId=integer(vehicleId,0,2147483647)
    if not vehicleId or not valid(partId)then return nil end
    return{schemaVersion=1,providerId="vehicle",vehicleId=vehicleId,partId=partId}
end
function References.corpseContainer(x,y,z,objectId)
    x=integer(x,-30000000,30000000);y=integer(y,-30000000,30000000);z=integer(z,-32,32)
    objectId=tostring(objectId or"")
    if not x or not y or not z or not objectId:match("^%d+$")or#objectId>20 then return nil end
    return{schemaVersion=1,providerId="corpse",x=x,y=y,z=z,objectId=objectId}
end
function References.actorRoot()
    return{schemaVersion=1,providerId="actor",kind="root"}
end
function References.actorPath(itemPath)
    if type(itemPath)~="table"or#itemPath<1 or#itemPath>16 then return nil end
    local copy={}
    for index,itemId in ipairs(itemPath)do
        itemId=tostring(itemId or"");if not valid(itemId)then return nil end
        copy[index]=itemId
    end
    return{schemaVersion=1,providerId="actor",kind="path",itemPath=copy}
end
function References.describeWorldContainer(object,container)
    local square=call(object,"getSquare");local objects=call(square,"getObjects")
    local objectIndex=objects and call(objects,"indexOf",object);local count=integer(call(object,"getContainerCount"),0,256)
    if not square or objectIndex==nil or objectIndex<0 or not count then return nil end
    for containerIndex=0,count-1 do
        if call(object,"getContainerByIndex",containerIndex)==container then
            return References.worldContainer(call(square,"getX"),call(square,"getY"),call(square,"getZ"),objectIndex,containerIndex)
        end
    end
end
function References.describeVehicleContainer(container)
    local part=call(container,"getVehiclePart");local vehicle=call(part,"getVehicle")
    if not part or not vehicle or call(part,"getItemContainer")~=container then return nil end
    return References.vehicleContainer(call(vehicle,"getId"),call(part,"getId"))
end
function References.describeCorpseContainer(object,container)
    local square=call(object,"getSquare");local objectId=call(object,"getObjectIDAsLong")
    if not square or objectId==nil or tostring(objectId)=="-1"or call(object,"getContainer")~=container then return nil end
    return References.corpseContainer(call(square,"getX"),call(square,"getY"),call(square,"getZ"),objectId)
end
function References.item(containerReference,itemId)
    if type(containerReference)~="table"or not valid(tostring(itemId or""))then return nil end
    return{schemaVersion=1,container=containerReference,itemId=tostring(itemId)}
end

return References
