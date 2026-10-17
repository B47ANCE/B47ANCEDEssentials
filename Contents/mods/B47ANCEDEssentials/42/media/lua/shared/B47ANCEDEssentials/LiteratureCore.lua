B47ANCEDEssentials=B47ANCEDEssentials or {}

local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return nil end
    local success,value=pcall(fn,object,...)
    if success then return value end
    return nil
end

local function listValues(list)
    local values={}
    if not list then return values end
    local size=tonumber(call(list,"size"))
    if size then
        for index=0,size-1 do values[#values+1]=call(list,"get",index) end
    elseif type(list)=="table" then
        for _,value in ipairs(list) do values[#values+1]=value end
    end
    return values
end

local function uniqueInsert(values,seen,value)
    value=tostring(value or ""):gsub("^%s+",""):gsub("%s+$","")
    if value~="" and not seen[value] then seen[value]=true; values[#values+1]=value end
end

function B47ANCEDEssentials.isTrackedLiterature(item)
    if item==nil then return false end
    if call(item,"IsLiterature")==true then return true end
    return type(instanceof)=="function" and instanceof(item,"Literature")==true
end

function B47ANCEDEssentials.literatureStatus(player,item)
    if not B47ANCEDEssentials.isTrackedLiterature(item) then return nil end
    local pages=tonumber(call(item,"getNumberOfPages")) or 0
    local read=tonumber(call(player,"getAlreadyReadPages",call(item,"getFullType"))) or 0
    local data=call(item,"hasModData") and call(item,"getModData") or nil
    if data and data.literatureTitle and call(player,"isLiteratureRead",data.literatureTitle)==true then return "read",pages,pages end
    if data and data.printMedia and data.printMedia.title and call(player,"isPrintMediaRead",data.printMedia.title)==true then return "read",pages,pages end
    if data and data.learnedRecipe and call(call(player,"getKnownRecipes"),"contains",data.learnedRecipe)==true then return "read",pages,pages end
    local recipes=call(item,"getLearnedRecipes")
    if recipes and call(recipes,"isEmpty")==false and call(call(player,"getKnownRecipes"),"containsAll",recipes)==true then return "read",pages,pages end
    if pages>0 and read>=pages then return "read",pages,pages end
    if read>0 then return "partial",read,pages end
    return "unread",0,pages
end

function B47ANCEDEssentials.isTrackedRecordedMedia(item)
    return item~=nil and call(item,"isRecordedMedia")==true and call(item,"getMediaData")~=nil
end

function B47ANCEDEssentials.recordedMediaStatus(player,item)
    if not B47ANCEDEssentials.isTrackedRecordedMedia(item) then return nil end
    local media=call(item,"getMediaData")
    local total=math.max(0,tonumber(call(media,"getLineCount")) or 0)
    local known=0
    for index=0,total-1 do
        local line=call(media,"getLine",index)
        local guid=call(line,"getTextGuid")
        if guid and call(player,"isKnownMediaLine",guid)==true then known=known+1 end
    end
    if total>0 and known>=total then return "watched",known,total end
    if known>0 then return "partial",known,total end
    return "unwatched",0,total
end

local CODE_SKILLS={
    AXE="Axe",BLD="Blade",BLU="Blunt",CAR="Carpentry",COO="Cooking",CRP="Carpentry",
    DOC="First Aid",ELE="Electrical",FAR="Farming",FIS="Fishing",FIT="Fitness",
    FOR="Foraging",MEC="Mechanics",MET="Metalworking",NIM="Nimble",POT="Pottery",
    REL="Reloading",SPR="Sprinting",STR="Strength",TAI="Tailoring",TRA="Trapping",
    WEL="Welding",
}

local function rewardFromCode(code,rewards,seen)
    code=tostring(code or "")
    for token in code:gmatch("[^;,%s]+") do
        local upper=token:upper()
        local prefix=upper:match("^([A-Z]+)[%+%-=]")
        if prefix and CODE_SKILLS[prefix] then uniqueInsert(rewards,seen,CODE_SKILLS[prefix].." XP")
        elseif upper:find("XP",1,true) then uniqueInsert(rewards,seen,"Skill XP")
        elseif upper:find("RECIPE",1,true) then
            local recipe=token:match("[:=](.+)")
            uniqueInsert(rewards,seen,recipe and ("Recipe: "..recipe) or "Recipe knowledge")
        end
    end
end

function B47ANCEDEssentials.mediaRewards(item)
    local rewards,seen={},{}
    if B47ANCEDEssentials.isTrackedLiterature(item) then
        local skill=call(item,"getSkillTrained")
        local first=tonumber(call(item,"getLvlSkillTrained"))
        local count=tonumber(call(item,"getNumLevelsTrained"))
        if skill and tostring(skill)~="" then
            local text=tostring(skill).." reading multiplier"
            if first and count and count>0 then text=text.." (levels "..first.."-"..(first+count-1)..")" end
            uniqueInsert(rewards,seen,text)
        end
        local recipes=call(item,"getLearnedRecipes") or call(item,"getTeachedRecipes")
        for _,recipe in ipairs(listValues(recipes)) do uniqueInsert(rewards,seen,"Recipe: "..tostring(recipe)) end
    end
    if B47ANCEDEssentials.isTrackedRecordedMedia(item) then
        local media=call(item,"getMediaData")
        local total=math.max(0,tonumber(call(media,"getLineCount")) or 0)
        for index=0,total-1 do rewardFromCode(call(call(media,"getLine",index),"getCodes"),rewards,seen) end
    end
    return rewards
end

function B47ANCEDEssentials.countCarriedCopies(container,fullType,maximum)
    maximum=math.max(1,tonumber(maximum) or 250)
    local count,visited=0,0
    local function scan(current)
        local list=call(current,"getItems")
        local size=tonumber(call(list,"size")) or 0
        for index=0,size-1 do
            if visited>=maximum then return end
            visited=visited+1
            local item=call(list,"get",index)
            if tostring(call(item,"getFullType") or "")==fullType then count=count+1 end
            local nested=call(item,"getInventory")
            if nested then scan(nested) end
        end
    end
    scan(container)
    return count,visited>=maximum
end

return B47ANCEDEssentials
