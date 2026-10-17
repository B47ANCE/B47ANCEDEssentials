B47ANCEDEssentials=B47ANCEDEssentials or {}
require "B47ANCEDEssentials/InventoryReferences"
B47ANCEDEssentials.InventoryTransfers=B47ANCEDEssentials.InventoryTransfers or {}
local Transfers=B47ANCEDEssentials.InventoryTransfers

Transfers.SCHEMA_VERSION=1
Transfers.DEFAULT_MAX_MOVES=100
Transfers.HARD_MAX_MOVES=500

local function call(object,method,...)
    if not object then return false,nil end
    local ok,fn=pcall(function() return object[method] end)
    if not ok or type(fn)~="function" then return false,nil end
    return pcall(fn,object,...)
end

local function canAccess(actor,container)
    local ok,value=call(actor,"canAccessContainer",container)
    return ok and value==true
end

local function contains(container,item)
    local ok,value=call(container,"contains",item)
    return ok and value==true
end

local function accepts(actor,container,item)
    local ok,value=call(container,"isItemAllowed",item)
    if ok and value==false then return false,"ITEM_REJECTED" end
    ok,value=call(container,"hasRoomFor",actor,item)
    if not ok then ok,value=call(container,"hasRoomFor",item) end
    if ok and value==false then return false,"NO_CAPACITY" end
    return true
end

local function restore(container,item)
    if not contains(container,item) then pcall(container.AddItem,container,item) end
end

local function transferOne(actor,move,options)
    local source,destination,item=move and move.source,move and move.destination,move and move.item
    if not source or not destination or not item or source==destination then return false,"INVALID_MOVE" end
    if not canAccess(actor,source) or not canAccess(actor,destination) then return false,"ACCESS_DENIED" end
    if type(options.revalidate)=="function" then
        local ok,allowed,reason=pcall(options.revalidate,actor,move)
        if not ok or allowed~=true then return false,tostring(reason or "REVALIDATION_FAILED") end
    end
    if not contains(source,item) or contains(destination,item) then return false,"OWNERSHIP_CHANGED" end
    local accepted,reason=accepts(actor,destination,item)
    if not accepted then return false,reason end

    local removeOK=pcall(source.DoRemoveItem,source,item)
    local remains=contains(source,item)
    if not removeOK or remains then
        if not remains then restore(source,item) end
        return false,"REMOVE_FAILED"
    end
    pcall(destination.AddItem,destination,item)
    local arrived=contains(destination,item)
    local duplicated=contains(source,item)
    if not arrived or duplicated then
        if arrived then pcall(destination.DoRemoveItem,destination,item) end
        restore(source,item)
        return false,"ADD_FAILED"
    end

    local sendRemove=options.sendRemove or sendRemoveItemFromContainer
    local sendAdd=options.sendAdd or sendAddItemToContainer
    if type(sendRemove)=="function" then pcall(sendRemove,source,item) end
    if type(sendAdd)=="function" then pcall(sendAdd,destination,item) end
    return true,"COMMITTED"
end

function Transfers.executeBatch(actor,moves,options)
    options=options or {}
    local maximum=math.max(1,math.min(Transfers.HARD_MAX_MOVES,
        math.floor(tonumber(options.maximum) or Transfers.DEFAULT_MAX_MOVES)))
    local result={schemaVersion=Transfers.SCHEMA_VERSION,requested=0,committed=0,rejected=0,
        limited=false,outcomes={}}
    local seen={}
    for _,move in ipairs(moves or {}) do
        if result.requested>=maximum then result.limited=true break end
        result.requested=result.requested+1
        local item=move and move.item
        if seen[item] then
            result.rejected=result.rejected+1
            result.outcomes[#result.outcomes+1]={index=result.requested,ok=false,reason="DUPLICATE_ITEM"}
        else
            seen[item]=true
            local ok,reason=transferOne(actor,move,options)
            if ok then result.committed=result.committed+1 else result.rejected=result.rejected+1 end
            result.outcomes[#result.outcomes+1]={index=result.requested,ok=ok,reason=reason}
        end
    end
    return result
end

function Transfers.executeReferencedBatch(actor,references,options)
    options=options or{}
    local maximum=math.max(1,math.min(Transfers.HARD_MAX_MOVES,
        math.floor(tonumber(options.maximum)or Transfers.DEFAULT_MAX_MOVES)))
    local resolved={};local rejected={};local requested=0;local limited=false
    for _,move in ipairs(type(references)=="table"and references or{})do
        if requested>=maximum then limited=true break end
        requested=requested+1
        local item,itemReason,source=B47ANCEDEssentials.InventoryReferences.resolveItem(actor,move and move.item)
        local destination,destinationReason=B47ANCEDEssentials.InventoryReferences.resolveContainer(actor,move and move.destination)
        if item and source and destination then
            resolved[#resolved+1]={source=source,destination=destination,item=item,requestIndex=requested}
        else
            rejected[#rejected+1]={index=requested,ok=false,reason=tostring(itemReason or destinationReason or"REFERENCE_UNAVAILABLE")}
        end
    end
    local transaction=Transfers.executeBatch(actor,resolved,{maximum=maximum,revalidate=options.revalidate,
        sendRemove=options.sendRemove,sendAdd=options.sendAdd})
    local outcomes={};for _,entry in ipairs(rejected)do outcomes[#outcomes+1]=entry end
    for index,entry in ipairs(transaction.outcomes)do
        local move=resolved[index];outcomes[#outcomes+1]={index=move and move.requestIndex or index,ok=entry.ok,reason=entry.reason}
    end
    table.sort(outcomes,function(a,b)return a.index<b.index end)
    return{schemaVersion=Transfers.SCHEMA_VERSION,requested=requested,committed=transaction.committed,
        rejected=#rejected+transaction.rejected,limited=limited or transaction.limited,outcomes=outcomes}
end

Transfers.transferOne=transferOne
return Transfers
