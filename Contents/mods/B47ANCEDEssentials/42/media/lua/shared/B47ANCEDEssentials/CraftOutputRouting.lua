pcall(require,"Entity/TimedActions/ISHandcraftAction")
pcall(require,"TimedActions/ISCraftAction")
pcall(require,"ActionManager")

B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.CraftOutputRules=B47ANCEDEssentials.CraftOutputRules or {}

local function config()
    local root=rawget(_G,"SandboxVars")
    return root and root.B47ANCEDEssentials or nil
end

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function normalize(value)
    return tostring(value or ""):gsub("^Base[:%.]+",""):gsub("[%s_%-]",""):lower()
end

function B47ANCEDEssentials.getCraftRecipeName(action)
    local recipe=action and (action.craftRecipe or action.recipe) or nil
    for _,method in ipairs({"getName","getOriginalName","getOriginalname"}) do
        local ok,value=call(recipe,method)
        if ok and value then return tostring(value) end
    end
    return ""
end

function B47ANCEDEssentials.registerCraftOutputRule(id,predicate)
    assert(type(id)=="string" and id~="","craft-output rule id is required")
    assert(type(predicate)=="function","craft-output predicate must be a function")
    B47ANCEDEssentials.CraftOutputRules[id]=predicate
end

function B47ANCEDEssentials.shouldRouteCraftOutput(action,item)
    local settings=config()
    if settings and settings.EnableCraftingOutputRouting==false then return false end
    local recipe=normalize(B47ANCEDEssentials.getCraftRecipeName(action))
    local ok,itemType=call(item,"getFullType"); itemType=ok and tostring(itemType) or ""
    if (not settings or settings.RouteSawedPlanksToGround~=false) and itemType=="Base.Plank"
        and (recipe=="sawlog" or recipe=="sawlogs" or recipe=="sawlargebranch") then return true end
    if settings and settings.RouteHeavyCraftingOutputs==true then
        local weightOK,weight=call(item,"getActualWeight")
        if weightOK and (tonumber(weight) or 0)>=(tonumber(settings.CraftingOutputWeightThreshold) or 3.0) then
            return true
        end
    end
    for id,predicate in pairs(B47ANCEDEssentials.CraftOutputRules) do
        local ruleOK,value=pcall(predicate,action,item,recipe)
        if ruleOK and value==true then return true end
        if not ruleOK then print("[B47ANCEDEssentials] Craft-output rule failed safely id="..id.." error="..tostring(value)) end
    end
    return false
end

function B47ANCEDEssentials.dropCraftOutput(character,item)
    local ok,square=call(character,"getCurrentSquare")
    if not ok or not square then ok,square=call(character,"getSquare") end
    if not ok or not square then return false end
    local xOK,x=call(character,"getX"); local yOK,y=call(character,"getY"); local zOK,z=call(character,"getZ")
    x=xOK and ((tonumber(x) or 0)-math.floor(tonumber(x) or 0)) or 0.5
    y=yOK and ((tonumber(y) or 0)-math.floor(tonumber(y) or 0)) or 0.5
    z=zOK and ((tonumber(z) or 0)-math.floor(tonumber(z) or 0)) or 0
    local added,worldItem=call(square,"AddWorldInventoryItem",item,x,y,z)
    return added and worldItem~=nil
end

local function wrapMethod(class,name)
    if not class or type(class[name])~="function" then return false end
    local marker="CraftOutputRouting_"..name
    if B47ANCEDEssentials[marker] then return true end
    local original=class[name]
    class[name]=function(self,...)
        local addOrDrop=Actions and Actions.addOrDropItem
        if type(addOrDrop)~="function" then return original(self,...) end
        Actions.addOrDropItem=function(character,item)
            if character==self.character and B47ANCEDEssentials.shouldRouteCraftOutput(self,item)
                and B47ANCEDEssentials.dropCraftOutput(character,item) then return end
            return addOrDrop(character,item)
        end
        local result={pcall(original,self,...)}
        Actions.addOrDropItem=addOrDrop
        if not result[1] then error(result[2]) end
        return table.unpack(result,2)
    end
    B47ANCEDEssentials[marker]=true
    return true
end

local function install()
    local handcraft=wrapMethod(rawget(_G,"ISHandcraftAction"),"performRecipe")
    local legacy=wrapMethod(rawget(_G,"ISCraftAction"),"complete")
    return handcraft or legacy
end

if not install() and Events and Events.OnTick then
    local function retry()
        if install() then Events.OnTick.Remove(retry) end
    end
    Events.OnTick.Add(retry)
end
return B47ANCEDEssentials
