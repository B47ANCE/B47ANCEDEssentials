require "B47ANCEDEssentials/HeavyObjects"
local Heavy=B47ANCEDEssentials.HeavyObjects
Heavy.Client=Heavy.Client or {}
local Client=Heavy.Client
local results={};local order={};local MAX_RESULTS=128
local phases={reserve=true,start=true,complete=true,cancel=true}

local function valid(value,maximum)
    return type(value)=="string" and #value>0 and #value<=(maximum or 128) and value:match("^[%w_%.:%-]+$")~=nil
end
function Client.request(request)
    if type(request)~="table" or request.schemaVersion~=1 or not valid(request.operationId,160)
        or not valid(request.actorId,160) or not valid(request.targetId,160) or not valid(request.providerId)
        or not Heavy.ACTIONS[request.action] or not phases[request.phase] then return false,"INVALID_REQUEST" end
    if type(sendClientCommand)~="function" then return false,"TRANSPORT_UNAVAILABLE" end
    sendClientCommand("B47ANCEDEssentials","heavyObjectPhase",{schemaVersion=1,operationId=request.operationId,
        actorId=request.actorId,targetId=request.targetId,providerId=request.providerId,action=request.action,phase=request.phase})
    return true,"SENT"
end
function Client.inspectResult(operationId)
    local value=valid(operationId,160) and results[operationId] or nil
    if not value then return nil end
    local result={};for key,entry in pairs(value.result)do result[key]=entry end
    return {schemaVersion=1,operationId=operationId,phase=value.phase,ok=value.ok,reason=value.reason,state=value.state,result=result}
end
local function onServerCommand(module,command,args)
    if module~="B47ANCEDEssentials" or command~="heavyObjectResult" or type(args)~="table" or args.schemaVersion~=1
        or not valid(args.operationId,160) then return end
    local bounded={}
    for key,value in pairs(type(args.result)=="table" and args.result or {})do
        local finite=type(value)~="number" or (value==value and value~=math.huge and value~=-math.huge)
        if valid(key,64) and finite and (type(value)=="string" or type(value)=="number" or type(value)=="boolean") then
            bounded[key]=type(value)=="string" and value:sub(1,160) or value
        end
    end
    if not results[args.operationId] then order[#order+1]=args.operationId end
    results[args.operationId]={phase=tostring(args.phase or ""):sub(1,16),ok=args.ok==true,
        reason=tostring(args.reason or "UNKNOWN"):sub(1,160),state=tostring(args.state or ""):sub(1,32),result=bounded}
    while #order>MAX_RESULTS do results[table.remove(order,1)]=nil end
end
if Events and Events.OnServerCommand then Events.OnServerCommand.Add(onServerCommand) end
Client.onServerCommand=onServerCommand
return Client
