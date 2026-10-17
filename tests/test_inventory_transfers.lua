package.path="Contents/mods/B47ANCEDEssentials/42/media/lua/shared/?.lua;Contents/mods/B47ANCEDEssentials/42/media/lua/shared/?/?.lua;"..package.path

local function container(items)
    local self={items=items or {},allow=true,room=true}
    function self:contains(item) for _,value in ipairs(self.items) do if value==item then return true end end return false end
    function self:isItemAllowed() return self.allow end
    function self:hasRoomFor() return self.room end
    function self:DoRemoveItem(item) for index,value in ipairs(self.items) do if value==item then table.remove(self.items,index); return item end end end
    function self:AddItem(item) self.items[#self.items+1]=item return item end
    return self
end
local actor={canAccessContainer=function() return true end}
local a,b,c={}, {}, {}
local source,destination=container({a,b,c}),container({})
dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua")
local api=assert(B47ANCEDEssentials.InventoryTransfers)
local removed,added=0,0
local result=api.executeBatch(actor,{
    {source=source,destination=destination,item=a},
    {source=source,destination=destination,item=a},
    {source=source,destination=destination,item=b},
},{maximum=2,sendRemove=function() removed=removed+1 end,sendAdd=function() added=added+1 end})
assert(result.committed==1 and result.rejected==1 and result.limited,"batch must deduplicate and enforce its bound")
assert(removed==1 and added==1 and destination:contains(a),"only committed ownership must replicate")

actor.canAccessContainer=function(_,candidate) return candidate~=destination end
result=api.executeBatch(actor,{{source=source,destination=destination,item=b}})
assert(result.outcomes[1].reason=="ACCESS_DENIED" and source:contains(b),"access must be revalidated at execution")
actor.canAccessContainer=function() return true end
destination.room=false
result=api.executeBatch(actor,{{source=source,destination=destination,item=b}})
assert(result.outcomes[1].reason=="NO_CAPACITY" and source:contains(b),"capacity must be revalidated")
destination.room=true

destination.AddItem=function() return b end
result=api.executeBatch(actor,{{source=source,destination=destination,item=b}})
assert(result.outcomes[1].reason=="ADD_FAILED" and source:contains(b) and not destination:contains(b),"failed add must roll back")

source.DoRemoveItem=function(self,item)
    for index,value in ipairs(self.items) do if value==item then table.remove(self.items,index); error("after mutation") end end
end
result=api.executeBatch(actor,{{source=source,destination=destination,item=c}})
assert(result.outcomes[1].reason=="REMOVE_FAILED" and source:contains(c),"uncertain remove must restore source")

local references=B47ANCEDEssentials.InventoryReferences
local containers={source=source,destination=destination}
references.registerProvider{id="transferfixture",resolveContainer=function(_,reference)return containers[reference.key],"MISSING"end,
    resolveItem=function(_,owned,reference)for _,value in ipairs(owned.items)do if tostring(value.id)==reference.itemId then return value end end end}
source.DoRemoveItem=container({}).DoRemoveItem;destination.AddItem=container({}).AddItem
local d={id="d"};source.items={d};destination.items={}
local sourceRef={schemaVersion=1,providerId="transferfixture",key="source"}
local destinationRef={schemaVersion=1,providerId="transferfixture",key="destination"}
result=api.executeReferencedBatch(actor,{
    {item={schemaVersion=1,container=sourceRef,itemId="d"},destination=destinationRef},
    {item={schemaVersion=1,container=sourceRef,itemId="missing"},destination=destinationRef},
},{maximum=2,sendRemove=function()removed=removed+1 end,sendAdd=function()added=added+1 end})
assert(result.requested==2 and result.committed==1 and result.rejected==1 and result.outcomes[2].reason=="ITEM_UNAVAILABLE",
    "referenced batch must resolve each identity immediately before canonical execution")
assert(destination:contains(d)and not source:contains(d),"resolved moves must preserve canonical ownership")
print("test_inventory_transfers.lua: PASS")
