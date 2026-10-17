local sourcePath=arg[1]
Events={OnTick={Add=function() end,Remove=function() end}}
local added,dropped=0,0
Actions={addOrDropItem=function() added=added+1 end}
local recipe={getName=function() return "Saw Logs" end}
local item={getFullType=function() return "Base.Plank" end,getActualWeight=function() return 3 end}
local square={AddWorldInventoryItem=function(_,value) dropped=dropped+1 return {item=value} end}
local character={getCurrentSquare=function() return square end,getX=function() return 1.5 end,
    getY=function() return 2.5 end,getZ=function() return 0 end}
ISHandcraftAction={performRecipe=function(self) Actions.addOrDropItem(self.character,item); return "ok" end}
ISCraftAction=nil
local realRequire=require
require=function(name) return true end
SandboxVars={B47ANCEDEssentials={EnableCraftingOutputRouting=true,RouteSawedPlanksToGround=true,
    RouteHeavyCraftingOutputs=false,CraftingOutputWeightThreshold=3}}
local B47ANCEDEssentials=dofile(sourcePath)
local action={character=character,craftRecipe=recipe}; setmetatable(action,{__index=ISHandcraftAction})
assert(action:performRecipe()=="ok" and dropped==1 and added==0,"verified sawed planks must route to ground")
recipe.getName=function() return "Build Chair" end
action:performRecipe()
assert(added==1,"unregistered ordinary outputs must retain vanilla routing")
SandboxVars.B47ANCEDEssentials.RouteHeavyCraftingOutputs=true
action:performRecipe()
assert(dropped==2,"optional heavy-output routing must use the configured threshold")
SandboxVars.B47ANCEDEssentials.EnableCraftingOutputRouting=false
action:performRecipe()
assert(added==2,"master sandbox toggle must restore vanilla behavior")
assert(Actions.addOrDropItem~=nil,"global output helper must be restored after crafting")
print("B47ANCEDEssentials craft-output routing checks passed")
