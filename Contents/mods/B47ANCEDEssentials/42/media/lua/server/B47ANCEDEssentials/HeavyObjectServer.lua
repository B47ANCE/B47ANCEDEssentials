require "B47ANCEDEssentials/HeavyObjects"
local Heavy=B47ANCEDEssentials.HeavyObjects

local function attachStore()
    if not ModData or type(ModData.getOrCreate)~="function" then return false,"MODDATA_UNAVAILABLE" end
    local ok,value=pcall(ModData.getOrCreate,Heavy.STORE_KEY)
    if not ok then return false,"MODDATA_READ_FAILED" end
    return Heavy.attachStore(value)
end

local function respond(player,request,ok,reason,result,state)
    if type(sendServerCommand)~="function" then return end
    pcall(sendServerCommand,player,"B47ANCEDEssentials","heavyObjectResult",{
        schemaVersion=1,operationId=type(request)=="table" and tostring(request.operationId or ""):sub(1,160) or "invalid",
        phase=type(request)=="table" and tostring(request.phase or ""):sub(1,16) or "",
        ok=ok==true,reason=tostring(reason or "UNKNOWN"):sub(1,160),state=tostring(state or ""):sub(1,32),result=result or {}})
end

local function onClientCommand(module,command,player,args)
    if module~="B47ANCEDEssentials" or command~="heavyObjectPhase" then return end
    local ok,reason,result,state=Heavy.advance(player,args)
    respond(player,args,ok,reason,result,state)
end

if Events and Events.OnInitGlobalModData then Events.OnInitGlobalModData.Add(attachStore) end
if Events and Events.OnClientCommand then Events.OnClientCommand.Add(onClientCommand) end
Heavy.attachProductionStore=attachStore
Heavy.onClientCommand=onClientCommand
return Heavy
