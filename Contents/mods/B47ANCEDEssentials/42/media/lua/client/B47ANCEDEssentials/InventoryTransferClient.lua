B47ANCEDEssentials=B47ANCEDEssentials or{}
local results={};local order={};local MAX_RESULTS=128
local function valid(value)return type(value)=="string"and#value>0 and#value<=160 and value:match("^[%w_%.:%-]+$")~=nil end
local function copy(value,depth)
    if type(value)~="table"then return value end;depth=(depth or 0)+1;if depth>4 then return nil end
    local result={};local count=0;for key,entry in pairs(value)do if(type(key)=="string"or type(key)=="number")and count<256 then result[key]=copy(entry,depth);count=count+1 end end
    return result
end
function B47ANCEDEssentials.requestReferencedTransfers(player,request)
    if not player or type(request)~="table"or request.schemaVersion~=1 or not valid(request.operationId)
        or type(request.moves)~="table"or#request.moves<1 or#request.moves>100 then return false,"INVALID_REQUEST"end
    if type(sendClientCommand)~="function"then return false,"TRANSPORT_UNAVAILABLE"end
    local ok=pcall(sendClientCommand,player,"B47ANCEDEssentials","transferBatch",request)
    return ok,ok and"SENT"or"TRANSPORT_FAILED"
end
function B47ANCEDEssentials.inspectReferencedTransferResult(operationId)
    local result=valid(operationId)and results[operationId]or nil;if not result then return nil,"RESULT_UNAVAILABLE"end
    return copy(result)
end
local function onCommand(module,command,args)
    if module~="B47ANCEDEssentials"or command~="transferBatchResult"or type(args)~="table"or args.schemaVersion~=1 or not valid(args.operationId)then return end
    if not results[args.operationId]then order[#order+1]=args.operationId end;results[args.operationId]=copy(args)
    while#order>MAX_RESULTS do results[table.remove(order,1)]=nil end
end
if Events and Events.OnServerCommand then Events.OnServerCommand.Add(onCommand)end
B47ANCEDEssentials.receiveReferencedTransferResult=onCommand
return B47ANCEDEssentials
