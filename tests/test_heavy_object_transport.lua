isClient=function()return false end;isServer=function()return true end;B47ANCEDEssentials=nil
package.loaded["B47ANCEDEssentials/HeavyObjects"]=dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/HeavyObjects.lua")
local initCallback,commandCallback,response
Events={OnInitGlobalModData={Add=function(fn)initCallback=fn end},OnClientCommand={Add=function(fn)commandCallback=fn end}}
local saved={schemaVersion=1,operations={},order={}}
ModData={getOrCreate=function(key)
    assert(key=="itjustWorks.HeavyObjects.v1","rename must retain the existing authoritative history store")
    return saved
end};sendServerCommand=function(player,module,command,args)response={player,module,command,args}end
local Heavy=dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/HeavyObjectServer.lua")
assert(initCallback() and commandCallback)
local actor={id="p:1"};local target={id="t:1"}
Heavy.registerProvider{id="fixture",matches=function(v)return v==target end,getStableId=function(v)return v.id end,
    resolveStableId=function(id)return id==target.id and target or nil end,getActorId=function(v)return v.id end,
    observe=function()return {operations={push={supported=true,eligible=true,reason="READY"}}}end,
    reserve=function()return true,{token="one"}end,start=function()return true,{}end,complete=function()return true,{}end,cancel=function()return true,{}end}
local request={schemaVersion=1,operationId="net:1",actorId="p:1",targetId="t:1",providerId="fixture",action="push",phase="reserve"}
commandCallback("B47ANCEDEssentials","heavyObjectPhase",actor,request)
assert(response[1]==actor and response[2]=="B47ANCEDEssentials" and response[3]=="heavyObjectResult" and response[4].ok)
assert(saved.operations["net:1"],"new namespace must write the existing authoritative store")
assert(initCallback(),"reattaching the store must be safe")
commandCallback("B47ANCEDEssentials","heavyObjectPhase",actor,request)
assert(response[4].ok and response[4].state=="reserved","persisted reservation must survive reattachment")

local serverEvent,sent
Events={OnServerCommand={Add=function(fn)serverEvent=fn end}}
sendClientCommand=function(module,command,args)sent={module,command,args}end
local Client=dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HeavyObjectClient.lua")
assert(Client.request(request) and sent[1]=="B47ANCEDEssentials" and sent[2]=="heavyObjectPhase")
serverEvent(response[2],response[3],response[4]);local result=assert(Client.inspectResult("net:1"))
assert(result.ok and result.state=="reserved" and result.result.token=="one")
print("test_heavy_object_transport.lua: PASS")
