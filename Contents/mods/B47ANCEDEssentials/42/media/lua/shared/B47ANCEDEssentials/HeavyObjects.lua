B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.HeavyObjects=B47ANCEDEssentials.HeavyObjects or {}
local Heavy=B47ANCEDEssentials.HeavyObjects

Heavy.SCHEMA_VERSION=1
-- Stable serialized identity: retaining history prevents replay after a project rename.
Heavy.STORE_KEY="itjustWorks.HeavyObjects.v1"
Heavy.MAX_OPERATIONS=512
Heavy.ACTIONS={push=true,pull=true,carry=true}
local providers={}
local store=nil

local function valid(value,maximum)
    return type(value)=="string" and #value>0 and #value<=(maximum or 128)
        and value:match("^[%w_%.:%-]+$")~=nil
end
local function authoritative()
    local client=type(rawget(_G,"isClient"))=="function" and isClient()==true
    local server=type(rawget(_G,"isServer"))=="function" and isServer()==true
    return server or not client
end
local function finite(value)
    return type(value)~="number" or (value==value and value~=math.huge and value~=-math.huge)
end
local function clean(value)
    local result={}
    for key,entry in pairs(type(value)=="table" and value or {}) do
        if valid(key,64) and finite(entry) and (type(entry)=="string" or type(entry)=="number" or type(entry)=="boolean") then
            result[key]=type(entry)=="string" and entry:sub(1,160) or entry
        end
    end
    return result
end
local function providerById(id)
    for _,provider in ipairs(providers) do if provider.id==id then return provider end end
end
local function providerFor(target)
    for _,provider in ipairs(providers) do
        local ok,matches=pcall(provider.matches,target)
        if ok and matches==true then return provider end
    end
end
local function identity(provider,target)
    local ok,value=pcall(provider.getStableId,target)
    value=ok and tostring(value or "") or ""
    return valid(value,160) and value or nil
end
local function actorIdentity(provider,actor)
    if type(provider.getActorId)~="function" then return nil end
    local ok,value=pcall(provider.getActorId,actor)
    value=ok and tostring(value or "") or ""
    return valid(value,160) and value or nil
end

function Heavy.attachStore(value)
    if not authoritative() or type(value)~="table" then return false,"AUTHORITY_STORE_REQUIRED" end
    if value.schemaVersion~=nil and value.schemaVersion~=Heavy.SCHEMA_VERSION then return false,"UNSUPPORTED_SCHEMA" end
    value.schemaVersion=Heavy.SCHEMA_VERSION
    value.operations=type(value.operations)=="table" and value.operations or {}
    value.order=type(value.order)=="table" and value.order or {}
    local order,seen={},{ }
    for _,id in ipairs(value.order) do
        if valid(id,160) and type(value.operations[id])=="table" and not seen[id] then
            order[#order+1]=id;seen[id]=true
        end
    end
    while #order>Heavy.MAX_OPERATIONS do value.operations[table.remove(order,1)]=nil end
    value.order=order;store=value
    return true
end

function Heavy.registerProvider(definition)
    assert(type(definition)=="table" and valid(definition.id),"heavy-object provider id required")
    for _,name in ipairs({"matches","getStableId","resolveStableId","getActorId","observe"}) do
        assert(type(definition[name])=="function","heavy-object provider "..name.." required")
    end
    for _,provider in ipairs(providers) do assert(provider.id~=definition.id,"duplicate heavy-object provider: "..definition.id) end
    local provider={id=definition.id,priority=tonumber(definition.priority) or 0}
    for _,name in ipairs({"matches","getStableId","resolveStableId","getActorId","observe","reserve","start","complete","cancel"}) do
        provider[name]=definition[name]
    end
    providers[#providers+1]=provider
    table.sort(providers,function(a,b)return a.priority==b.priority and a.id<b.id or a.priority>b.priority end)
    return {id=provider.id,priority=provider.priority}
end

function Heavy.resolve(providerId,targetId)
    local provider=valid(providerId) and providerById(providerId) or nil
    if not provider or not valid(targetId,160) then return nil,"PROVIDER_OR_IDENTITY_UNAVAILABLE" end
    local ok,target=pcall(provider.resolveStableId,targetId)
    if not ok then return nil,"RESOLUTION_FAILED" end
    if not target then return nil,"TARGET_UNAVAILABLE" end
    if providerFor(target)~=provider or identity(provider,target)~=targetId then return nil,"RESOLUTION_MISMATCH" end
    return target,provider
end

function Heavy.inspect(actor,target)
    local provider=providerFor(target)
    if not provider then return nil,"UNSUPPORTED_TARGET" end
    local targetId=identity(provider,target);local actorId=actorIdentity(provider,actor)
    if not targetId then return nil,"UNSTABLE_TARGET_IDENTITY" end
    if not actorId then return nil,"UNSTABLE_ACTOR_IDENTITY" end
    local ok,raw=pcall(provider.observe,actor,target)
    if not ok or type(raw)~="table" then return nil,"INVALID_OBSERVATION" end
    local view={schemaVersion=1,providerId=provider.id,targetId=targetId,actorId=actorId,operations={}}
    for action in pairs(Heavy.ACTIONS) do
        local source=type(raw.operations)=="table" and raw.operations[action] or nil
        local supported=type(source)=="table" and source.supported==true
        view.operations[action]={supported=supported,eligible=supported and source.eligible==true or false,
            reason=tostring(type(source)=="table" and source.reason or "UNSUPPORTED"):sub(1,160)}
    end
    return view
end

local function record(id,entry)
    store.operations[id]=entry;store.order[#store.order+1]=id
    while #store.order>Heavy.MAX_OPERATIONS do store.operations[table.remove(store.order,1)]=nil end
end
local function same(entry,request)
    return entry.actorId==request.actorId and entry.targetId==request.targetId
        and entry.providerId==request.providerId and entry.action==request.action
end
local function outcome(entry)
    local ok=entry.lastOutcomeOK
    if ok==nil then ok=entry.state~="rejected" and entry.state~="inspection_required" end
    return ok==true,entry.reason,clean(entry.result),entry.state
end
local function callPhase(provider,phase,actor,target,request,observation)
    local callback=provider[phase]
    if type(callback)~="function" then return false,"PHASE_UNAVAILABLE" end
    local called,ok,result=pcall(callback,actor,target,request,observation)
    if not called then return nil,"PROVIDER_EXCEPTION" end
    if ok~=true then return false,tostring(result or "PHASE_REJECTED"):sub(1,160) end
    return true,clean(result)
end

function Heavy.advance(actor,request)
    if not authoritative() then return false,"NON_AUTHORITY" end
    if not store then return false,"STORE_UNAVAILABLE" end
    if type(request)~="table" or request.schemaVersion~=1 or not valid(request.operationId,160)
        or not valid(request.actorId,160) or not valid(request.targetId,160) or not valid(request.providerId)
        or not Heavy.ACTIONS[request.action] or not ({reserve=true,start=true,complete=true,cancel=true})[request.phase] then
        return false,"INVALID_REQUEST"
    end
    local entry=store.operations[request.operationId]
    if entry and not same(entry,request) then return false,"OPERATION_ID_CONFLICT" end
    if entry and entry.lastPhase==request.phase then return outcome(entry) end
    if entry and (entry.state=="completed" or entry.state=="cancelled" or entry.state=="rejected" or entry.state=="inspection_required") then
        return false,"TERMINAL_STATE",nil,entry.state
    end
    local target,provider=Heavy.resolve(request.providerId,request.targetId)
    if not target then return false,provider end
    local observation,reason=Heavy.inspect(actor,target)
    if not observation then return false,reason end
    if observation.actorId~=request.actorId then return false,"ACTOR_MISMATCH" end
    local capability=observation.operations[request.action]
    if request.phase~="cancel" and (not capability.supported or not capability.eligible) then
        return false,capability.reason
    end
    if not entry then
        if request.phase~="reserve" then return false,"RESERVATION_REQUIRED" end
        entry={actorId=request.actorId,targetId=request.targetId,providerId=request.providerId,action=request.action,state="reserving"}
        record(request.operationId,entry)
    else
        local required={start="reserved",complete="started",cancel=entry.state}
        if request.phase~="cancel" and entry.state~=required[request.phase] then return false,"INVALID_PHASE_ORDER" end
    end
    local transitional={reserve="reserving",start="starting",complete="completing",cancel="cancelling"}
    local previousState=entry.state
    entry.state=transitional[request.phase];entry.lastPhase=request.phase;entry.reason=nil;entry.result=nil;entry.lastOutcomeOK=nil
    local ok,result=callPhase(provider,request.phase,actor,target,request,observation)
    if ok==nil then entry.state="inspection_required";entry.reason=result;entry.lastOutcomeOK=false;return false,result,nil,entry.state end
    if ok==false then
        entry.state=request.phase=="reserve" and "rejected" or previousState
        entry.reason=result;entry.lastOutcomeOK=false
        return false,result,nil,entry.state
    end
    entry.state=({reserve="reserved",start="started",complete="completed",cancel="cancelled"})[request.phase]
    entry.reason=string.upper(entry.state);entry.result=result;entry.lastOutcomeOK=true
    return true,entry.reason,clean(entry.result),entry.state
end

function Heavy.inspectOperation(operationId)
    local entry=store and valid(operationId,160) and store.operations[operationId] or nil
    if not entry then return nil end
    return {schemaVersion=1,operationId=operationId,actorId=entry.actorId,targetId=entry.targetId,
        providerId=entry.providerId,action=entry.action,state=entry.state,reason=entry.reason,result=clean(entry.result)}
end

return Heavy
