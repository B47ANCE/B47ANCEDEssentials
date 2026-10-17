local sourcePath=arg[1]
SandboxVars={B47ANCEDEssentials={EnableSortingAutomation=true,SortingRadius=5,SortingMaxTransfersPerOperation=100,
    SortingPreserveFavorites=true,SortingAllowCategoryFallback=false,SortingIncludeMultipleFloors=false}}
Events={OnClientCommand={Add=function() end}}
instanceof=function() return false end
local function item(kind) return {getFullType=function() return kind end,getDisplayCategory=function() return "Hardware" end,isFavorite=function() return false end} end
local moving=item("Base.Nails")
local seed=item("Base.Nails")
local function list(values)
    return {size=function() return #values end,get=function(_,index) return values[index+1] end,
        indexOf=function(_,target) for i,value in ipairs(values) do if value==target then return i-1 end end return -1 end}
end
local function container(values)
    local self={values=values,getContainingItem=function() return nil end,getType=function() return "crate" end,
        getItems=function(s) return list(s.values) end,isItemAllowed=function() return true end,hasRoomFor=function() return true end}
    function self:contains(target) for _,value in ipairs(self.values) do if value==target then return true end end return false end
    function self:DoRemoveItem(target) for i,value in ipairs(self.values) do if value==target then table.remove(self.values,i); return target end end end
    function self:AddItem(target) self.values[#self.values+1]=target; return target end
    return self
end
local source=container({moving})
local destination=container({seed})
local function object(owned) return {getContainerCount=function() return 1 end,getContainerByIndex=function(_,index) return index==0 and owned or nil end} end
local sourceObject,destinationObject=object(source),object(destination)
local squares={}
local function square(x,y,z,objects) squares[x..":"..y..":"..z]={getObjects=function() return list(objects) end}; return squares[x..":"..y..":"..z] end
square(0,0,0,{sourceObject}); square(1,0,0,{destinationObject})
local cell={getGridSquare=function(_,x,y,z) return squares[x..":"..y..":"..z] end}
getCell=function() return cell end
local reports={}
local removeTransmits,addTransmits=0,0
sendServerCommand=function(_,_,_,args) reports[#reports+1]=args end
sendRemoveItemFromContainer=function() removeTransmits=removeTransmits+1 end
sendAddItemToContainer=function() addTransmits=addTransmits+1 end
local player={getX=function() return 0 end,getY=function() return 0 end,getZ=function() return 0 end,
    getOnlineID=function() return 7 end,canAccessContainer=function() return true end}
local B47ANCEDEssentials=dofile(sourcePath)
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==0 and #destination.values==2,"server must execute a validated exact-seed move")
assert(reports[1] and reports[1].moved==1,"server should report authoritative move totals")
assert(removeTransmits==1 and addTransmits==1,"committed moves must replicate once after both postconditions")

source.values={moving}; destination.values={seed}; reports={}; removeTransmits=0; addTransmits=0
player.canAccessContainer=function(_,candidate) return candidate~=destination end
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==1 and #destination.values==1,
    "an explicitly inaccessible destination must be rejected before mutation")
assert(reports[1] and reports[1].moved==0,
    "an inaccessible destination must not count as an authoritative move")
assert(removeTransmits==0 and addTransmits==0,
    "an inaccessible destination must not emit container replication")
player.canAccessContainer=function() return true end

source.values={moving}; destination.values={seed}
player.getX=function() return 50 end
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==1,"remote requests must be rejected before mutation")

player.getX=function() return 0 end
source.values={moving}; destination.values={seed}; reports={}; removeTransmits=0; addTransmits=0
source.DoRemoveItem=function() return moving end
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==1 and #destination.values==1,"a successful no-op removal must not duplicate an item")
assert(reports[1] and reports[1].moved==0,"a no-op removal must not count as a move")
assert(removeTransmits==0 and addTransmits==0,"a rejected no-op must not emit container replication")

source.values={moving}; destination.values={seed}; reports={}; removeTransmits=0; addTransmits=0
source.DoRemoveItem=function(self,target)
    for index,value in ipairs(self.values) do
        if value==target then table.remove(self.values,index); error("throw after removal") end
    end
end
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==1 and source.values[1]==moving and #destination.values==1,
    "a throw-after-removal outcome must restore the source without copying")
assert(reports[1] and reports[1].moved==0,"a restored uncertain removal must not count as a move")
assert(removeTransmits==0 and addTransmits==0,"a restored uncertain removal must not replicate a transfer")

source.values={moving}; destination.values={seed}; reports={}; removeTransmits=0; addTransmits=0
source.DoRemoveItem=container({}).DoRemoveItem
destination.AddItem=function() return moving end
B47ANCEDEssentials.performServerSort(player,{x=0,y=0,z=0,objectIndex=0,containerIndex=0})
assert(#source.values==1 and source.values[1]==moving and #destination.values==1,
    "a successful no-op destination add must roll the item back to its source")
assert(reports[1] and reports[1].moved==0,"an uncommitted destination add must not count as a move")
assert(removeTransmits==0 and addTransmits==0,"a rolled-back destination add must not replicate a transfer")
print("B47ANCEDEssentials sorting-server checks passed")
