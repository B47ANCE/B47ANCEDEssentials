local classifier=dofile(arg[1])
local function weapon(id,ranged,options)
    options=options or{}
    return{getFullType=function()return id end,isRanged=function()return ranged end,isTwoHandWeapon=function()return options.twoHanded==true end,
        isRequiresEquippedBothHands=function()return options.requiresBoth==true end,isBroken=function()return options.broken==true end,getCondition=function()return options.condition or 10 end}
end
local pistol=weapon("Base.Pistol",true);local knife=weapon("Base.KitchenKnife",false)
assert(classifier.classifyPair(pistol,knife).pairType=="FIREARM_MELEE")
assert(classifier.classifyPair(knife,pistol).pairType=="MELEE_FIREARM")
assert(classifier.classifyPair(pistol,weapon("Base.Revolver",true)).pairType=="FIREARM_FIREARM")
assert(classifier.classifyPair(knife,weapon("Base.Hammer",false)).pairType=="MELEE_MELEE")
local two=classifier.classifyPair(pistol,weapon("Base.Axe",false,{twoHanded=true}))
assert(not two.eligible and two.secondary.reason=="two-handed item")
assert(not classifier.classifyPair(pistol,pistol).eligible,"one object cannot become a dual pair")
assert(not classifier.classifyItem({getFullType=function()return"Base.Spoon"end}).eligible,"unknown objects must fail closed")
assert(not classifier.classifyItem(weapon("Base.Broken",false,{broken=true})).eligible)
assert(classifier.registerProvider({id="test.mod",priority=10,matches=function(item)return item.custom==true end,classify=function()return{kind="MELEE",eligible=true}end}))
local custom=classifier.classifyItem({custom=true,getFullType=function()return"Mod.Tool"end,isTwoHandWeapon=function()return false end,isRequiresEquippedBothHands=function()return false end,isBroken=function()return false end,getCondition=function()return 1 end})
assert(custom.eligible and custom.kind=="MELEE"and custom.providerId=="test.mod")
assert(not classifier.registerProvider({id="test.mod",matches=function()end,classify=function()end}))
assert(classifier.registerProvider({id="throwing",priority=100,matches=function()error("bad provider")end,classify=function()end}))
assert(classifier.classifyItem(pistol).kind=="FIREARM","throwing providers must not break classification")
print("B47ANCEDEssentials independent-hand equipment classifier checks passed")
