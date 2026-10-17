B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.Sorting=B47ANCEDEssentials.Sorting or {}
local Sorting=B47ANCEDEssentials.Sorting

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function fullType(item)
    local ok,value=call(item,"getFullType")
    return ok and tostring(value) or ""
end

local function category(item)
    local ok,value=call(item,"getDisplayCategory")
    if not ok or not value or value=="" then ok,value=call(item,"getCategory") end
    return ok and tostring(value) or ""
end

local function items(container)
    local ok,list=call(container,"getItems")
    if not ok or not list then return {} end
    local sizeOK,size=call(list,"size"); if not sizeOK then return {} end
    local result={}
    for index=0,(tonumber(size) or 0)-1 do
        local got,item=call(list,"get",index)
        if got and item then result[#result+1]=item end
    end
    return result
end

function Sorting.describeContainer(container,distanceSquared)
    local description={container=container,types={},categories={},count=0,
        distanceSquared=tonumber(distanceSquared) or math.huge}
    for _,item in ipairs(items(container)) do
        local itemType=fullType(item); local itemCategory=category(item)
        if itemType~="" then description.types[itemType]=(description.types[itemType] or 0)+1 end
        if itemCategory~="" then description.categories[itemCategory]=(description.categories[itemCategory] or 0)+1 end
        description.count=description.count+1
    end
    return description
end

local function accepts(candidate,player,item)
    local allowedOK,allowed=call(candidate.container,"isItemAllowed",item)
    if allowedOK and allowed==false then return false end
    local roomOK,room=call(candidate.container,"hasRoomFor",player,item)
    if not roomOK then roomOK,room=call(candidate.container,"hasRoomFor",item) end
    return not roomOK or room~=false
end

function Sorting.chooseDestination(candidates,player,item,allowCategory)
    local itemType=fullType(item); local itemCategory=category(item)
    local best,bestTier,bestCount=nil,nil,nil
    for _,candidate in ipairs(candidates or {}) do
        local exact=tonumber(candidate.types and candidate.types[itemType]) or 0
        local related=tonumber(candidate.categories and candidate.categories[itemCategory]) or 0
        local tier=exact>0 and 2 or (allowCategory and itemCategory~="" and related>0 and 1 or 0)
        local count=tier==2 and exact or related
        if tier>0 and accepts(candidate,player,item) then
            if not best or tier>bestTier or (tier==bestTier and count>bestCount)
                or (tier==bestTier and count==bestCount
                    and candidate.distanceSquared<best.distanceSquared) then
                best,bestTier,bestCount=candidate,tier,count
            end
        end
    end
    return best and best.container or nil,bestTier
end

function Sorting.plan(source,candidates,player,options)
    options=options or {}
    local maximum=math.max(1,math.floor(tonumber(options.maximum) or 100))
    local preserveFavorites=options.preserveFavorites~=false
    local allowCategory=options.allowCategory==true
    local result={moves={},unmatched=0,protected=0,limited=false}
    for _,item in ipairs(items(source)) do
        if #result.moves>=maximum then result.limited=true break end
        local favorite=false; local ok,value=call(item,"isFavorite"); if ok then favorite=value==true end
        if favorite and preserveFavorites then
            result.protected=result.protected+1
        else
            local destination,tier=Sorting.chooseDestination(candidates,player,item,allowCategory)
            if destination then
                result.moves[#result.moves+1]={item=item,source=source,destination=destination,matchTier=tier}
            else
                result.unmatched=result.unmatched+1
            end
        end
    end
    return result
end

Sorting.fullType=fullType
Sorting.category=category
return Sorting
