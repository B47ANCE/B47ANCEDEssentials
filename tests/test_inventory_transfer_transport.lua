local serverPath,clientPath=arg[1],arg[2]
local handler;Events={OnClientCommand={Add=function(value)handler=value end},OnServerCommand={Add=function()end}}
local reports={};sendServerCommand=function(_,_,_,args)reports[#reports+1]=args end
B47ANCEDEssentials={InventoryTransfers={executeReferencedBatch=function(_,moves)return{schemaVersion=1,requested=#moves,committed=1,rejected=#moves-1,limited=false,outcomes={}}end}}
package.preload["B47ANCEDEssentials/InventoryTransfers"]=function()return B47ANCEDEssentials.InventoryTransfers end
local server=dofile(serverPath);local player={getOnlineID=function()return 7 end};local request={schemaVersion=1,operationId="transfer:1",moves={{id="a"}}}
server.executeReferencedTransferRequest(player,request);server.executeReferencedTransferRequest(player,request)
assert(#reports==2 and reports[1].committed==1 and reports[2].committed==1,"identical retry must return cached result")
request.moves[1].id="b";server.executeReferencedTransferRequest(player,request)
assert(reports[3].reason=="OPERATION_ID_CONFLICT","changed retry must not execute")
local before=#reports;server.executeReferencedTransferRequest(player,{schemaVersion=1,operationId="empty",moves={}});assert(#reports==before,"empty batches must be rejected at ingress")

local sent={};Events={OnServerCommand={Add=function()end}};sendClientCommand=function(...)sent={...}end
local client=dofile(clientPath);assert(client.requestReferencedTransfers(player,{schemaVersion=1,operationId="client:1",moves={{id="a"}}}))
assert(sent[2]=="B47ANCEDEssentials"and sent[3]=="transferBatch","client must use bounded canonical command")
client.receiveReferencedTransferResult("B47ANCEDEssentials","transferBatchResult",{schemaVersion=1,operationId="client:1",committed=1})
local snapshot=client.inspectReferencedTransferResult("client:1");assert(snapshot.committed==1,"client must expose bounded result lookup")
snapshot.committed=99;assert(client.inspectReferencedTransferResult("client:1").committed==1,"result inspection must not expose mutable cache state")
assert(not client.requestReferencedTransfers(player,{schemaVersion=1,operationId="bad",moves={}}))
print("test_inventory_transfer_transport.lua: PASS")
