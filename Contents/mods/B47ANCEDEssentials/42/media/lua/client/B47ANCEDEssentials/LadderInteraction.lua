require "ISUI/ISWorldObjectContextMenu"

B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.Ladders=B47ANCEDEssentials.Ladders or {}
local Ladders=B47ANCEDEssentials.Ladders

local definitions={
    W={tag="ladderW",climb="climbSheetW",top="climbSheetTopW",barrier="HoppableW",dx=0,dy=0},
    N={tag="ladderN",climb="climbSheetN",top="climbSheetTopN",barrier="HoppableN",dx=0,dy=0},
    E={tag="ladderE",climb="climbSheetE",top="climbSheetTopE",barrier="HoppableW",dx=1,dy=0},
    S={tag="ladderS",climb="climbSheetS",top="climbSheetTopS",barrier="HoppableN",dx=0,dy=1},
}
local order={"W","N","E","S"}
local registeredProperties={}
local MAX_REGISTERED_PROPERTIES=128

local function settings()
    return SandboxVars and SandboxVars.B47ANCEDEssentials or {}
end

local function translated(key,fallback)
    if type(getTextOrNull)=="function" then
        local ok,value=pcall(getTextOrNull,key)
        if ok and value then return value end
    end
    return fallback
end

local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return nil end
    local success,value=pcall(fn,object,...)
    return success and value or nil
end

local function has(properties,key)
    return properties and (call(properties,"has",key)==true or (IsoFlagType and IsoFlagType[key] and call(properties,"has",IsoFlagType[key])==true))
end

local function set(properties,key)
    if not properties then return false end
    local flag=IsoFlagType and IsoFlagType[key] or key
    return pcall(properties.set,properties,flag)
end

function Ladders.directionAt(square)
    local objects=call(square,"getObjects")
    local size=tonumber(call(objects,"size")) or 0
    for objectIndex=0,size-1 do
        local object=call(objects,"get",objectIndex)
        local properties=call(object,"getProperties")
        for _,key in ipairs(order) do
            local definition=definitions[key]
            if has(properties,definition.tag) or has(properties,definition.climb) then return key,object end
        end
        for property,key in pairs(registeredProperties) do
            if has(properties,property) then return key,object end
        end
    end
    return nil
end

function Ladders.registerProperty(property,orientation)
    if type(property)~="string" or property=="" or #property>96 then return false,"bounded property name required" end
    if not definitions[orientation] then return false,"orientation must be N, E, S, or W" end
    if registeredProperties[property] then
        return registeredProperties[property]==orientation,registeredProperties[property]==orientation and "already registered" or "property orientation conflict"
    end
    local count=0;for _ in pairs(registeredProperties) do count=count+1 end
    if count>=MAX_REGISTERED_PROPERTIES then return false,"ladder property registry full" end
    registeredProperties[property]=orientation
    return true
end

local function markClimbable(square,key,object)
    local definition=definitions[key]
    local squareProperties=call(square,"getProperties")
    set(squareProperties,definition.climb)
end

local function landingIsSafe(square,key)
    local definition=definitions[key]
    local landing=getCell() and getCell():getGridSquare(square:getX()+definition.dx,square:getY()+definition.dy,square:getZ()+1)
    if not landing then return false end
    if settings().LadderRequireSafeLanding==false then return true end
    return call(landing,"TreatAsSolidFloor")==true or has(call(landing,"getProperties"),"solidfloor")
end

function Ladders.prepare(square)
    if not square then return nil end
    local key,object=Ladders.directionAt(square)
    if not key then return nil end
    markClimbable(square,key,object)
    local maximum=math.max(1,math.min(32,tonumber(settings().LadderMaximumLevels) or 8))
    local top=square
    for level=1,maximum-1 do
        local above=getCell() and getCell():getGridSquare(square:getX(),square:getY(),square:getZ()+level)
        local aboveKey,aboveObject=Ladders.directionAt(above)
        if aboveKey~=key then break end
        markClimbable(above,key,aboveObject)
        top=above
    end
    if not landingIsSafe(top,key) then return square,key,nil end
    local definition=definitions[key]
    set(call(top,"getProperties"),definition.top)
    local barrier=getCell() and getCell():getGridSquare(top:getX()+definition.dx,top:getY()+definition.dy,top:getZ())
    set(call(barrier,"getProperties"),definition.barrier)
    return square,key,top
end

local function prepareNearby(playerNum,_,worldObjects)
    local values=settings()
    if values.EnableLadderClimbing==false then return end
    local seen={}
    for _,object in ipairs(worldObjects or {}) do
        local square=call(object,"getSquare")
        if square and not seen[square] then seen[square]=true; Ladders.prepare(square) end
    end
    local player=getSpecificPlayer and getSpecificPlayer(playerNum)
    local origin=call(player,"getSquare")
    if origin then
        local x,y,z=origin:getX(),origin:getY(),origin:getZ()
        for _,offset in ipairs({{0,0},{-1,0},{1,0},{0,-1},{0,1}}) do
            local square=getCell():getGridSquare(x+offset[1],y+offset[2],z)
            Ladders.prepare(square)
            local below=getCell():getGridSquare(x+offset[1],y+offset[2],z-1)
            Ladders.prepare(below)
        end
    end
end

local function isTop(square)
    if not square or not IsoWindow or type(IsoWindow.isTopOfSheetRopeHere)~="function" then return false end
    local ok,value=pcall(IsoWindow.isTopOfSheetRopeHere,square)
    return ok and value==true
end

-- Every input source (context menu now; movement and Space when their native
-- interception points are verified) must obtain the same immutable plan here.
function Ladders.resolve(player,square,source)
    if settings().EnableLadderClimbing==false then return nil,"disabled" end
    if not player then return nil,"player unavailable" end
    if call(player,"isDead")==true then return nil,"player incapacitated" end
    if call(player,"isClimbingRope")==true then return nil,"already climbing" end
    if call(player,"hasTimedActions")==true then return nil,"player busy" end
    local current=call(player,"getSquare")
    if current and isTop(current) and call(player,"canClimbDownSheetRope",current)==true then
        return {square=current,down=true,source=source or "unknown",
            x=call(current,"getX"),y=call(current,"getY"),z=call(current,"getZ")}
    end
    local ladder,key,top=Ladders.prepare(square)
    if not ladder or not key then return nil,"recognized ladder required" end
    if not top then return nil,"safe connected destination required" end
    if call(player,"canClimbSheetRope",ladder)~=true then return nil,"character cannot climb ladder" end
    return {square=ladder,down=false,source=source or "unknown",orientation=key,
        x=call(ladder,"getX"),y=call(ladder,"getY"),z=call(ladder,"getZ")}
end

function Ladders.request(playerNum,square,source,expectedDown)
    local player=getSpecificPlayer and getSpecificPlayer(playerNum)
    local plan,reason=Ladders.resolve(player,square,source)
    if not plan then return false,reason end
    if expectedDown~=nil and plan.down~=(expectedDown==true) then return false,"ladder transition changed" end
    if type(ISWorldObjectContextMenu)~="table" or type(ISWorldObjectContextMenu.onClimbSheetRope)~="function" then
        return false,"native ladder action unavailable"
    end
    -- This queues the native action; it never changes coordinates directly.
    ISWorldObjectContextMenu.onClimbSheetRope(nil,plan.square,plan.down,playerNum)
    return true,plan
end

local function climb(square,down,playerNum)
    local ok,reason=Ladders.request(playerNum,square,"context-menu",down)
    if not ok then print("[B47ANCEDEssentials] Ladder request rejected: "..tostring(reason)) end
end

local function addOptions(playerNum,context,worldObjects,test)
    if settings().EnableLadderClimbing==false then return end
    local player=getSpecificPlayer(playerNum)
    if not player then return end
    local candidate=nil
    local clickedCurrent=false
    local current=call(player,"getSquare")
    for _,object in ipairs(worldObjects or {}) do
        local square=call(object,"getSquare")
        if not candidate and Ladders.directionAt(square) then candidate=square end
        if square and square==current then clickedCurrent=true end
    end
    if not candidate and not clickedCurrent then return end
    local plan=Ladders.resolve(player,candidate or current,"context-menu-discovery")
    if not plan then return end
    if test and ISWorldObjectContextMenu and ISWorldObjectContextMenu.setTest then
        return ISWorldObjectContextMenu.setTest()
    end
    if not context or type(context.addOption)~="function" or not ISContextMenu or type(ISContextMenu.getNew)~="function" then return end
    local root=context:addOption(translated("ContextMenu_B47ANCEDEssentials_Ladder","Ladder"),plan.square,nil)
    local submenu=ISContextMenu:getNew(context);context:addSubMenu(root,submenu)
    submenu:addOption(translated("ContextMenu_B47ANCEDEssentials_ClimbLadder","Climb Ladder"),plan.square,climb,plan.down,playerNum)
end

local reported=false
local function safe(callback,...)
    local ok,err=pcall(callback,...)
    if not ok and not reported then reported=true; print("[B47ANCEDEssentials] Ladder interaction failed safely: "..tostring(err)) end
end

if Events and Events.OnPreFillWorldObjectContextMenu then
    Events.OnPreFillWorldObjectContextMenu.Add(function(...) safe(prepareNearby,...) end)
end
if Events and Events.OnFillWorldObjectContextMenu then
    Events.OnFillWorldObjectContextMenu.Add(function(...) safe(addOptions,...) end)
end

return Ladders
