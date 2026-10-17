local sourcePath=arg[1]
package.preload["ISUI/ISWorldObjectContextMenu"]=function() return true end
SandboxVars={B47ANCEDEssentials={EnableLadderClimbing=true,LadderMaximumLevels=8,LadderRequireSafeLanding=true}}
IsoFlagType=setmetatable({}, {__index=function(_,key) return key end})
local prefill,fill,controllerFound,nativeCalls
Events={OnPreFillWorldObjectContextMenu={Add=function(callback) prefill=callback end},
    OnFillWorldObjectContextMenu={Add=function(callback) fill=callback end}}
ISWorldObjectContextMenu={onClimbSheetRope=function(_,square,down,playerNum)
    nativeCalls=(nativeCalls or 0)+1;_G.lastNative={square=square,down=down,playerNum=playerNum}
end,setTest=function() controllerFound=true; return true end}
local function menu()
    local result={options={},submenus={}}
    function result:addOption(label,target,callback,...)
        local option={label=label,target=target,callback=callback,args={...}}
        self.options[#self.options+1]=option;return option
    end
    function result:addSubMenu(option,sub) self.submenus[option]=sub end
    return result
end
ISContextMenu={getNew=function() return menu() end}
local function props(initial)
    local values=initial or {}
    return {has=function(_,key) return values[key]==true end,set=function(_,key) values[key]=true end,values=values}
end
local function javaList(values)
    return {size=function() return #values end,get=function(_,index) return values[index+1] end}
end
local squares={}
local function square(x,y,z,objects,solidFloor)
    local property=props()
    local result={getX=function() return x end,getY=function() return y end,getZ=function() return z end,
        getObjects=function() return javaList(objects or {}) end,getProperties=function() return property end,
        TreatAsSolidFloor=function() return solidFloor==true end}
    squares[x..":"..y..":"..z]=result
    return result,property
end
local ladderProps=props({ladderW=true})
local spriteProps=props()
local sprite={getProperties=function() return spriteProps end}
local ladder={getProperties=function() return ladderProps end,getSprite=function() return sprite end}
local base,baseProps=square(10,10,0,{ladder},false)
ladder.getSquare=function() return base end
square(10,10,1,{},true)
getCell=function() return {getGridSquare=function(_,x,y,z) return squares[x..":"..y..":"..z] end} end
local Ladders=dofile(sourcePath)
local found,direction,top=Ladders.prepare(base)
assert(found==base and direction=="W" and top==base,"tagged west ladder should be prepared")
assert(baseProps.values.climbSheetW,"exact ladder square needs native climb semantics")
assert(not spriteProps.values.climbSheetW,"menu discovery must not mutate shared sprite metadata")
assert(baseProps.values.climbSheetTopW and baseProps.values.HoppableW,"safe ladder top needs native top and boundary semantics")
local untagged=square(20,20,0,{},false)
assert(Ladders.prepare(untagged)==nil,"untagged scenery must not become climbable")
assert(Ladders.registerProperty("ThirdPartyClimbable","N")==true)
assert(Ladders.registerProperty("ThirdPartyClimbable","S")==false,"registration conflicts must fail closed")
local thirdProps=props({ThirdPartyClimbable=true})
local third={getProperties=function() return thirdProps end}
local thirdSquare=square(30,30,0,{third},false)
assert(Ladders.directionAt(thirdSquare)=="N","registered third-party metadata must share discovery")

local canUp=true
local player={canClimbSheetRope=function() return canUp end,getSquare=function() return base end,
    canClimbDownSheetRope=function() return false end,isDead=function() return false end,
    isClimbingRope=function() return false end,hasTimedActions=function() return false end}
getSpecificPlayer=function() return player end
local plan=assert(Ladders.resolve(player,base,"test"))
assert(plan.down==false and plan.orientation=="W","resolver must infer ascent")
local context=menu();fill(0,context,{ladder},false)
assert(#context.options==1 and context.options[1].label=="Ladder","context root must be Ladder")
local sub=context.submenus[context.options[1]]
assert(sub and #sub.options==1 and sub.options[1].label=="Climb Ladder","one contextual action is required")
canUp=false
local option=sub.options[1]
option.callback(option.target,table.unpack(option.args))
assert((nativeCalls or 0)==0,"selection must revalidate a newly blocked transition")
canUp=true
option.callback(option.target,table.unpack(option.args))
assert(nativeCalls==1 and lastNative.down==false,"valid selection must use native ascent")

IsoWindow={isTopOfSheetRopeHere=function(squareValue) return squareValue==base end}
player.canClimbDownSheetRope=function() return true end
local down=assert(Ladders.resolve(player,base,"space"))
assert(down.down==true,"resolver must infer descent from a valid top edge")
assert(Ladders.request(0,base,"context-menu",true)==true)
assert(nativeCalls==2 and lastNative.down==true,"descent must use the same request pipeline")

assert(fill(0,{}, {ladder},true)==nil,"protected event wrapper should not leak callback return values")
assert(controllerFound==true,"controller discovery must use the native world-context test path")
print("B47ANCEDEssentials centralized ladder resolver/context-menu checks passed")
