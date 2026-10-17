package.path="Contents/mods/B47ANCEDEssentials/42/media/lua/client/?.lua;Contents/mods/B47ANCEDEssentials/42/media/lua/client/?/?.lua;"..package.path

local function list(values)
    local self={values=values or {}}
    function self:size() return #self.values end
    function self:get(index) return self.values[index+1] end
    function self:add(value) table.insert(self.values,value) end
    return self
end

local function container(kind,items,parent)
    local self={kind=kind,items=list(items),parent=parent}
    function self:getItems() return self.items end
    function self:clear() self.items.values={} end
    function self:setExplored() end
    function self:setOnlyAcceptCategory(value) self.accept=value end
    function self:setCapacity(value) self.capacity=value end
    function self:getParent() return self.parent end
    return self
end

ItemContainer={new=function(kind,_,parent) return container(kind,{},parent) end}
ISInventoryPage={}
ISInventoryPane={refreshContainer=function() end}
Events={OnRefreshInventoryWindowContainers={Add=function(callback) _G.refreshCallback=callback end}}
SandboxVars={B47ANCEDEssentials={EnableProximityInventory=true,EnableSeparateEquippedInventory=true}}
function require() return true end
function getText(key) return key end
function instanceof(object,kind) return object and object.class==kind end
function table.wipe(value) for key in pairs(value) do value[key]=nil end end

local wornItem={id="worn"}
local handItem={id="hand"}
local attachedItem={id="attached"}
local currentWorn={wornItem}
local currentPrimary=handItem
local currentSecondary=handItem
local player={}
function player:getPlayerNum() return 0 end
function player:getWornItems()
    local entries={}
    for _,item in ipairs(currentWorn) do
        table.insert(entries,{getItem=function() return item end})
    end
    return list(entries)
end
function player:getPrimaryHandItem() return currentPrimary end
function player:getSecondaryHandItem() return currentSecondary end
function player:getInventory() return self.inventory end
player.inventory=container("inventory",{wornItem,handItem,{id="loose"}})
function getSpecificPlayer() return player end
function getPlayerHotbar() return {attachedItems={attachedItem}} end

dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua")
local api=assert(B47ANCEDEssentials.InventoryViews)

local equipped=container("equipped",{})
local seen=api.collectEquipped(player,equipped)
assert(#equipped.items.values==3,"worn, held, and attached items should be unique")
assert(seen[wornItem] and seen[handItem] and seen[attachedItem],"all equipment sources should classify")

local lockedParent={class="IsoThumpable",isLockedToCharacter=function() return true end}
local accessible=container("crate",{{id="a"},{id="b"}})
local duplicate=accessible
local locked=container("crate",{{id="locked"}},lockedParent)
local aggregate=container("proximity",{})
local page={backpacks={{inventory=aggregate},{inventory=accessible},{inventory=duplicate},{inventory=locked}}}
api.collectProximity(page,aggregate,player)
assert(#aggregate.items.values==2,"proximity view should deduplicate containers and exclude locked storage")
local roots=api.getProximityRoots(page,player)
assert(#roots==2 and roots[1]==aggregate and roots[2]==accessible,
    "nearby roots must reuse the deduplicated unlocked vanilla-button set")

assert(api.virtualKind(aggregate)==nil,"ordinary test containers must not be mistaken for virtual views")

local looseItem=player.inventory.items.values[3]
local groups={
    {name="worn",items={wornItem,wornItem}},
    {name="loose",items={looseItem,looseItem}},
}
local pane={
    player=0,
    parent={onCharacter=true},
    inventory=player.inventory,
    itemslist=groups,
    selected={},
    saveSelection=function() return {[looseItem]=true} end,
    restoreSelection=function(self,value) self.restored=value[looseItem]==true end,
    updateScrollbars=function(self) self.scrolled=true end,
}
api.removeEquippedGroups(pane)
assert(#pane.itemslist==1 and pane.itemslist[1].name=="loose","personal inventory should omit actual equipment only")
assert(pane.restored==true,"filtering should preserve surviving selection")
assert(pane.scrolled==true and pane.firstSelect==nil,"filtering should reset stale range selection and scrollbars")

-- Vanilla prefixes equipped and hotbar groups before grouping equal item names.
-- Model those separate rows and prove an identical loose copy remains visible.
local identicalLoose={id="worn",sameType=true}
pane.itemslist={
    {name="equipped:Flashlight",items={wornItem,wornItem}},
    {name="Flashlight",items={identicalLoose,identicalLoose}},
}
api.removeEquippedGroups(pane)
assert(#pane.itemslist==1 and pane.itemslist[1].items[2]==identicalLoose,
    "an identical loose item must survive removal of vanilla's separate equipped group")

local function inventoryPage(onCharacter)
    local page={player=0,onCharacter=onCharacter,backpacks={}}
    function page:addContainerButton(inventory)
        local button={inventory=inventory}
        table.insert(self.backpacks,button)
        return button
    end
    return page
end

-- A selected virtual container must reflect changes even when vanilla refreshes
-- only the pane and does not rebuild its container buttons.
local equippedPage=inventoryPage(true)
refreshCallback(equippedPage,"begin")
local equippedVirtual=assert(equippedPage.backpacks[1].inventory)
local newlyEquipped={id="newly-equipped"}
currentWorn={newlyEquipped}
currentPrimary=nil
currentSecondary=nil
ISInventoryPane.refreshContainer({inventory=equippedVirtual,parent=equippedPage,player=0})
local equippedNow=equippedVirtual:getItems().values
assert(#equippedNow==2,"equipped pane refresh should rebuild the selected virtual view")
assert(equippedNow[1]==newlyEquipped or equippedNow[2]==newlyEquipped,
    "equipped pane refresh should include newly equipped items")

local proximityPage=inventoryPage(false)
refreshCallback(proximityPage,"begin")
local proximityVirtual=assert(proximityPage.backpacks[1].inventory)
local nearbySource=container("crate",{{id="before"}})
table.insert(proximityPage.backpacks,{inventory=nearbySource})
refreshCallback(proximityPage,"buttonsAdded")
nearbySource:getItems():add({id="after"})
ISInventoryPane.refreshContainer({inventory=proximityVirtual,parent=proximityPage,player=0})
assert(#proximityVirtual:getItems().values==2,
    "proximity pane refresh should rebuild from the current vanilla-admitted containers")

OCDInventory={}
local ocdPage=inventoryPage(true)
refreshCallback(ocdPage,"begin")
assert(#ocdPage.backpacks==0,"O.C.D. Inventory must retain the equipped-view seam when active")
pane.itemslist={{name="equipped:Flashlight",items={wornItem,wornItem}}}
api.removeEquippedGroups(pane)
assert(#pane.itemslist==1,"O.C.D. Inventory activation must disable the B47ANCEDEssentials row filter")
OCDInventory=nil

ProximityInventory={}
local externalProximityPage=inventoryPage(false)
refreshCallback(externalProximityPage,"begin")
assert(#externalProximityPage.backpacks==0,
    "Proximity Inventory must retain the nearby-view seam when active")
ProximityInventory=nil
print("test_inventory_views.lua: PASS")
