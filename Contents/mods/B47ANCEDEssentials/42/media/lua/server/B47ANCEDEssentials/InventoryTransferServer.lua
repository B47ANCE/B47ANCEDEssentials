require "B47ANCEDEssentials/InventoryTransfers"

B47ANCEDEssentials=B47ANCEDEssentials or{}
local history={};local order={};local MAX_HISTORY=512
local function valid(value)return type(value)=="string"and#value>0 and#value<=160 and value:match("^[%w_%.:%-]+$")~=nil end
local function validMoves(value)
    if type(value)~="table"then return false end;local count=#value;if count<1 or count>100 then return false end
    for key in pairs(value)do if type(key)~="number"or key~=math.floor(key)or key<1 or key>count then return false end end
    return true
end
local function actorId(player)return tostring(player and player.getOnlineID and player:getOnlineID()or player or"")end
local function encode(value,depth,state)
    depth=(depth or 0)+1;state=state or{nodes=0,seen={}}
    state.nodes=state.nodes+1;if depth>6 or state.nodes>4096 then return nil end
    local kind=type(value)
    if kind=="nil"then return"n"elseif kind=="boolean"then return value and"b1"or"b0"
    elseif kind=="number"then if value~=value or value==math.huge or value==-math.huge then return nil end;return"d"..string.format("%.17g",value)
    elseif kind=="string"then if#value>256 then return nil end;return"s"..#value..":"..value
    elseif kind~="table"or state.seen[value]then return nil end
    state.seen[value]=true;local keys={};for key in pairs(value)do if type(key)~="string"and type(key)~="number"then state.seen[value]=nil;return nil end;keys[#keys+1]=key end
    table.sort(keys,function(a,b)return tostring(a)<tostring(b)end);local parts={"t"}
    for _,key in ipairs(keys)do local a=encode(key,depth,state);local b=encode(value[key],depth,state);if not a or not b then state.seen[value]=nil;return nil end;parts[#parts+1]=a;parts[#parts+1]=b end
    state.seen[value]=nil;return table.concat(parts,"|")
end
local function send(player,operationId,result)
    if type(sendServerCommand)=="function"then pcall(sendServerCommand,player,"B47ANCEDEssentials","transferBatchResult",{
        schemaVersion=1,operationId=operationId,committed=result.committed or 0,rejected=result.rejected or 0,
        requested=result.requested or 0,limited=result.limited==true,reason=result.reason,outcomes=result.outcomes})end
end
local function execute(player,args)
    if type(args)~="table"or args.schemaVersion~=1 or not valid(args.operationId)or not validMoves(args.moves)then return end
    local key=actorId(player)..":"..args.operationId;local binding=encode(args.moves)
    if not binding then send(player,args.operationId,{reason="INVALID_REQUEST",rejected=0,requested=0,outcomes={}});return end
    local prior=history[key]
    if prior then
        if prior.binding~=binding then send(player,args.operationId,{reason="OPERATION_ID_CONFLICT",rejected=0,requested=0,outcomes={}})else send(player,args.operationId,prior.result)end
        return
    end
    local result=B47ANCEDEssentials.InventoryTransfers.executeReferencedBatch(player,args.moves,{maximum=100})
    history[key]={binding=binding,result=result};order[#order+1]=key
    while#order>MAX_HISTORY do history[table.remove(order,1)]=nil end
    send(player,args.operationId,result)
end
local function onCommand(module,command,player,args)if module=="B47ANCEDEssentials"and command=="transferBatch"then execute(player,args)end end
if Events and Events.OnClientCommand then Events.OnClientCommand.Add(onCommand)end
B47ANCEDEssentials.executeReferencedTransferRequest=execute
return B47ANCEDEssentials
