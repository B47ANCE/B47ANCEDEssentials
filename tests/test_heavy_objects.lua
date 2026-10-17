isClient=function()return false end;isServer=function()return true end
B47ANCEDEssentials=nil
local Heavy=dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/HeavyObjects.lua")
assert(not Heavy.attachStore({schemaVersion=99}))
local saved={};assert(Heavy.attachStore(saved))
local actor={id="player:1",near=true};local target={id="crate:1",available=true};local calls={}
Heavy.registerProvider{id="fixture",matches=function(v)return v==target end,getStableId=function(v)return v.id end,
    resolveStableId=function(id)return id==target.id and target or nil end,getActorId=function(v)return v.id end,
    observe=function(a,t)return {operations={push={supported=true,eligible=a.near and t.available,reason=a.near and "READY" or "OUT_OF_REACH"},
        carry={supported=true,eligible=false,reason="TOO_HEAVY"}}}end,
    reserve=function()calls[#calls+1]="reserve";return true,{token="fixture-token",unsafe=function()end}end,
    start=function()calls[#calls+1]="start";return true,{moving=true}end,
    complete=function()calls[#calls+1]="complete";return true,{moved=true}end,
    cancel=function()calls[#calls+1]="cancel";return true,{released=true}end}
local view=assert(Heavy.inspect(actor,target));assert(view.targetId=="crate:1" and view.operations.push.eligible)
assert(not view.operations.carry.eligible and not view.operations.pull.supported)
local request={schemaVersion=1,operationId="move:1",actorId="player:1",targetId="crate:1",providerId="fixture",action="push"}
request.phase="start";assert(not Heavy.advance(actor,request),"start requires reservation")
request.phase="reserve";local ok,reason,result,state=Heavy.advance(actor,request)
assert(ok and reason=="RESERVED" and result.token=="fixture-token" and result.unsafe==nil and state=="reserved")
assert(Heavy.advance(actor,request) and #calls==1,"phase replay must not invoke provider twice")
request.phase="start";assert(Heavy.advance(actor,request));request.phase="complete";assert(Heavy.advance(actor,request))
assert(Heavy.inspectOperation("move:1").state=="completed" and table.concat(calls,",")=="reserve,start,complete")
request.phase="cancel";local committed,terminalReason,_,terminal=Heavy.advance(actor,request)
assert(not committed and terminalReason=="TERMINAL_STATE" and terminal=="completed","a different phase cannot alter terminal state")
local denied={schemaVersion=1,operationId="move:2",actorId="player:1",targetId="crate:1",providerId="fixture",action="push",phase="reserve"}
actor.near=false;assert(not Heavy.advance(actor,denied));assert(Heavy.inspectOperation("move:2")==nil,"failed eligibility must not reserve")
actor.near=true;denied.actorId="player:2";assert(not Heavy.advance(actor,denied))
local rejectStart={schemaVersion=1,operationId="move:3",actorId="player:1",targetId="crate:1",providerId="fixture",action="push",phase="reserve"}
assert(Heavy.advance(actor,rejectStart));target.available=false;rejectStart.phase="start"
assert(not Heavy.advance(actor,rejectStart));assert(Heavy.inspectOperation("move:3").state=="reserved","failed start retains reservation")
target.available=true;rejectStart.phase="cancel";assert(Heavy.advance(actor,rejectStart));assert(Heavy.inspectOperation("move:3").state=="cancelled")
print("test_heavy_objects.lua: PASS")
