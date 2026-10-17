require "B47ANCEDEssentials/SortingCore"
require "B47ANCEDEssentials/InventoryTransfers"

B47ANCEDEssentials=B47ANCEDEssentials or {}
local Sorting=B47ANCEDEssentials.Sorting
local active={}

local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return nil end
    local ok,value=pcall(fn,object,...)
    if ok then return value end
    return nil
end

local function numberOption(name,fallback,minimum,maximum)
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    local value=tonumber(values and values[name]) or fallback
    return math.max(minimum,math.min(maximum,value))
end

local function enabled(name,fallback)
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    local value=values and values[name]
    if value==nil then return fallback end
    return value~=false
end

local function resolveContainer(args)
    local x,y,z=math.floor(tonumber(args.x) or -999999),math.floor(tonumber(args.y) or -999999),math.floor(tonumber(args.z) or -999999)
    local square=getCell() and getCell():getGridSquare(x,y,z)
    local objects=call(square,"getObjects")
    local object=objects and call(objects,"get",math.floor(tonumber(args.objectIndex) or -1))
    local container=object and call(object,"getContainerByIndex",math.floor(tonumber(args.containerIndex) or -1))
    return square,object,container,x,y,z
end

local function usable(container,source,player)
    if not container or container==source or call(container,"getContainingItem")~=nil then return false end
    local kind=string.lower(tostring(call(container,"getType") or ""))
    if kind=="floor" or kind=="inventorymale" or kind=="inventoryfemale" then return false end
    if player and player.canAccessContainer and call(player,"canAccessContainer",container)==false then return false end
    return true
end

local function excludedObject(object)
    return type(instanceof)=="function" and (instanceof(object,"IsoDeadBody")
        or instanceof(object,"IsoWorldInventoryObject") or instanceof(object,"BaseVehicle"))
end

local function candidatesAround(player,source,x,y,z,radius)
    local result={}
    local multipleFloors=enabled("SortingIncludeMultipleFloors",false)
    local minZ,maxZ=z,z
    if multipleFloors then
        minZ=math.floor(tonumber(type(getMinimumWorldLevel)=="function" and getMinimumWorldLevel() or z) or z)
        maxZ=math.floor(tonumber(type(getMaximumWorldLevel)=="function" and getMaximumWorldLevel() or z) or z)
    end
    local cell=getCell()
    for scanX=x-radius,x+radius do for scanY=y-radius,y+radius do
        local dx,dy=scanX-x,scanY-y
        if dx*dx+dy*dy<=radius*radius then for scanZ=minZ,maxZ do
            local square=cell and cell:getGridSquare(scanX,scanY,scanZ)
            local objects=call(square,"getObjects")
            local size=tonumber(call(objects,"size")) or 0
            for objectIndex=0,size-1 do
                local object=call(objects,"get",objectIndex)
                if object and not excludedObject(object) then
                    local count=tonumber(call(object,"getContainerCount")) or 0
                    for containerIndex=0,count-1 do
                        local container=call(object,"getContainerByIndex",containerIndex)
                        if usable(container,source,player) then
                            local dz=scanZ-z
                            result[#result+1]=Sorting.describeContainer(container,dx*dx+dy*dy+dz*dz)
                        end
                    end
                end
            end
        end end
    end end
    return result
end

local function sort(player,args)
    if not enabled("EnableSortingAutomation",true) then return end
    local square,sourceObject,source,x,y,z=resolveContainer(args or {})
    if not square or excludedObject(sourceObject) or not usable(source,nil,player) then return end
    local px,py,pz=tonumber(call(player,"getX")),tonumber(call(player,"getY")),tonumber(call(player,"getZ"))
    if not px or not py or not pz or (px-x)^2+(py-y)^2>9 or math.abs(pz-z)>1 then return end
    local key=tostring(call(player,"getOnlineID") or player)
    if active[key] then return end
    active[key]=true
    local ok,err=pcall(function()
        local radius=math.floor(numberOption("SortingRadius",5,1,20))
        local plan=Sorting.plan(source,candidatesAround(player,source,x,y,z,radius),player,{
            maximum=numberOption("SortingMaxTransfersPerOperation",100,1,500),
            preserveFavorites=enabled("SortingPreserveFavorites",true),
            allowCategory=enabled("SortingAllowCategoryFallback",false),
        })
        local transaction=B47ANCEDEssentials.InventoryTransfers.executeBatch(player,plan.moves,{
            maximum=numberOption("SortingMaxTransfersPerOperation",100,1,500),
        })
        local moved=transaction.committed
        if type(sendServerCommand)=="function" then
            pcall(sendServerCommand,player,"B47ANCEDEssentials","sortResult",{moved=moved,unmatched=plan.unmatched,protected=plan.protected,limited=plan.limited})
        end
    end)
    active[key]=nil
    if not ok then print("[B47ANCEDEssentials] Sorting request failed safely: "..tostring(err)) end
end

local function onCommand(module,command,player,args)
    if module=="B47ANCEDEssentials" and command=="sortContainer" then sort(player,args) end
end

if Events and Events.OnClientCommand then Events.OnClientCommand.Add(onCommand) end
B47ANCEDEssentials.performServerSort=sort
return B47ANCEDEssentials
