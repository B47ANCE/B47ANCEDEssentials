B47ANCEDEssentials=B47ANCEDEssentials or {}
local Classifier={MAX_PROVIDERS=64,Providers={}}

local function call(object,method,...)
    if not object then return nil end
    local ok,fn=pcall(function()return object[method]end)
    if not ok or type(fn)~="function"then return nil end
    local called,value=pcall(fn,object,...)
    if called then return value end
    return nil
end
local function fullType(item)local value=call(item,"getFullType");return value and tostring(value)or"unknown"end
local function providerCount()local count=0;for _ in pairs(Classifier.Providers)do count=count+1 end;return count end

function Classifier.registerProvider(definition)
    if type(definition)~="table"or type(definition.id)~="string"or definition.id==""or #definition.id>96 then return false,"bounded provider id required"end
    if type(definition.matches)~="function"or type(definition.classify)~="function"then return false,"provider callbacks required"end
    if Classifier.Providers[definition.id]then return false,"duplicate provider"end
    if providerCount()>=Classifier.MAX_PROVIDERS then return false,"provider registry full"end
    Classifier.Providers[definition.id]=definition;return true
end
local function providers()
    local values={};for _,provider in pairs(Classifier.Providers)do values[#values+1]=provider end
    table.sort(values,function(a,b)local ap,bp=tonumber(a.priority)or 0,tonumber(b.priority)or 0;return ap==bp and a.id<b.id or ap>bp end)
    return values
end
local function result(item,eligible,kind,reason,providerId)
    return{schemaVersion=1,item=item,fullType=fullType(item),eligible=eligible==true,kind=kind,reason=reason,providerId=providerId}
end

function Classifier.classifyItem(item)
    if not item then return result(nil,false,nil,"item unavailable","builtin")end
    if call(item,"isTwoHandWeapon")==true or call(item,"isRequiresEquippedBothHands")==true then return result(item,false,nil,"two-handed item","builtin")end
    if call(item,"isBroken")==true or(tonumber(call(item,"getCondition"))or 1)<=0 then return result(item,false,nil,"item broken","builtin")end
    for _,provider in ipairs(providers())do
        local ok,matched=pcall(provider.matches,item)
        if ok and matched then
            local classified,value=pcall(provider.classify,item)
            if not classified then return result(item,false,nil,"provider failed",provider.id)end
            if type(value)~="table"or(value.kind~="FIREARM"and value.kind~="MELEE")then return result(item,false,nil,"provider returned invalid classification",provider.id)end
            return result(item,value.eligible~=false,value.kind,value.reason,provider.id)
        end
    end
    local ranged=call(item,"isRanged")
    if ranged==nil then return result(item,false,nil,"not a verified hand weapon","builtin")end
    return result(item,true,ranged==true and"FIREARM"or"MELEE",nil,"builtin")
end

function Classifier.classifyPair(primary,secondary)
    local first=Classifier.classifyItem(primary);local second=Classifier.classifyItem(secondary);local pairType="NONE";local reason
    if primary and secondary and primary==secondary then reason="same item occupies both hands"
    elseif first.eligible and second.eligible then pairType=first.kind.."_"..second.kind
    else reason=not first.eligible and("primary: "..tostring(first.reason))or("secondary: "..tostring(second.reason))end
    return{schemaVersion=1,pairType=pairType,eligible=pairType~="NONE",primary=first,secondary=second,reason=reason}
end

B47ANCEDEssentials.IndependentHandClassifier=Classifier
B47ANCEDEssentials.registerIndependentHandProvider=Classifier.registerProvider
return Classifier
