local sourcePath=arg[1]
SandboxVars={B47ANCEDEssentials={EnableSortingAutomation=true}}
B47ANCEDEssentials={Sorting={}}
package.preload["B47ANCEDEssentials/SortingCore"]=function()return B47ANCEDEssentials.Sorting end
package.preload["B47ANCEDEssentials/InventoryReferences"]=function()
    B47ANCEDEssentials.InventoryReferences={describeWorldContainer=function(object,container)
        local square=object:getSquare();return{schemaVersion=1,providerId="world",x=square:getX(),y=square:getY(),z=square:getZ(),objectIndex=0,containerIndex=0}
    end};return B47ANCEDEssentials.InventoryReferences
end

local fill
Events={OnFillWorldObjectContextMenu={Add=function(fn)fill=fn end}}
local testCalls=0
ISWorldObjectContextMenu={setTest=function()testCalls=testCalls+1;return"TEST"end}
getTextOrNull=function()return nil end

local function list(values)
    return{indexOf=function(_,target)for index,value in ipairs(values)do if value==target then return index-1 end end return-1 end}
end
local function container(kind,containing)
    return{getType=function()return kind end,getContainingItem=function()return containing end}
end
local accepted=container("crate")
local inaccessible=container("cabinet")
local floor=container("floor")
local nested=container("bag",{})
local square
local object={}
function object:getSquare()return square end
function object:getContainerCount()return 4 end
function object:getContainerByIndex(index)return({accepted,inaccessible,floor,nested})[index+1]end
square={getX=function()return 12 end,getY=function()return 34 end,getZ=function()return 1 end,
    getObjects=function()return list({object})end}

local player={canAccessContainer=function(_,candidate)return candidate~=inaccessible end}
getSpecificPlayer=function(index)assert(index==0);return player end
local commands={}
sendClientCommand=function(received,module,command,args)
    commands[#commands+1]={player=received,module=module,command=command,args=args}
end
local options={}
local context={addOption=function(_,label,...)
    local option={label=label,args={...}};options[#options+1]=option;return option
end}

local api=dofile(sourcePath)
assert(api==B47ANCEDEssentials and type(fill)=="function","sorting client must register its safe context hook")
fill(0,context,{object,object},false)
assert(#options==1,"duplicate objects and invalid containers must produce one option")
local args=options[1].args
assert(args[1]==player and type(args[2])=="function","option must retain player and request callback")
local reference=args[3]
assert(reference.schemaVersion==1 and reference.providerId=="world"and reference.x==12 and reference.y==34 and reference.z==1 and reference.objectIndex==0 and reference.containerIndex==0,
    "client must send an exact server-resolvable world-container reference")
args[2](args[1],reference)
assert(#commands==1 and commands[1].module=="B47ANCEDEssentials" and commands[1].command=="sortContainer",
    "option callback must use the authoritative sorting command")
assert(commands[1].args==reference,"callback must send the validated reference unchanged")

options={};fill(0,context,{object},true)
assert(#options==0 and testCalls==1,"test mode must report availability without constructing an option")
SandboxVars.B47ANCEDEssentials.EnableSortingAutomation=false
fill(0,context,{object},false)
assert(#options==0 and #commands==1,"disabled sorting must remain inert")

package.preload["B47ANCEDEssentials/SortingCore"]=nil
package.loaded["B47ANCEDEssentials/SortingCore"]=nil
print("B47ANCEDEssentials sorting-client reference and access checks passed")
