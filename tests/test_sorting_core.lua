local sourcePath=arg[1]
local function list(values) return {size=function() return #values end,get=function(_,i) return values[i+1] end} end
local function item(kind,category,favorite)
    return {getFullType=function() return kind end,getDisplayCategory=function() return category end,
        isFavorite=function() return favorite==true end}
end
local function container(values,room)
    return {getItems=function() return list(values) end,isItemAllowed=function() return true end,
        hasRoomFor=function() return room~=false end}
end
local exact=container({item("Base.Nails","Hardware"),item("Base.Nails","Hardware")})
local category=container({item("Base.Screwdriver","Hardware")})
local closerExact=container({item("Base.Nails","Hardware")})
local blocked=container({item("Base.Nails","Hardware")},false)
local source=container({item("Base.Nails","Hardware"),item("Base.Hammer","Hardware"),item("Base.Axe","Weapon",true)})
local Sorting=dofile(sourcePath)
local candidates={Sorting.describeContainer(category,1),Sorting.describeContainer(exact,9),
    Sorting.describeContainer(closerExact,2),Sorting.describeContainer(blocked,0)}
local result=Sorting.plan(source,candidates,{}, {maximum=10,preserveFavorites=true,allowCategory=true})
assert(#result.moves==2,"exact and category matches should be planned")
assert(result.moves[1].destination==exact and result.moves[1].matchTier==2,
    "largest exact-type seed must outrank distance and category matches")
assert(result.moves[2].destination==exact and result.moves[2].matchTier==1,
    "category fallback must prefer the strongest category seed before distance")
assert(result.protected==1 and result.unmatched==0,"favorited items must remain protected")
local exactOnly=Sorting.plan(source,candidates,{}, {allowCategory=false,preserveFavorites=false,maximum=1})
assert(#exactOnly.moves==1 and exactOnly.limited==true,"transfer limits must bound each operation")
print("B47ANCEDEssentials sorting-core checks passed")
