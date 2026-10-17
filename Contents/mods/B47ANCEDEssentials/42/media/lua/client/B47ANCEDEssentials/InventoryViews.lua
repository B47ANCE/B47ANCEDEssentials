require "ISUI/ISInventoryPage"
require "ISUI/ISInventoryPane"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local virtualByPlayer={ proximity={}, equipped={} }
local virtualKind=setmetatable({},{__mode="k"})
local equippedSetByPlayer={}
local refreshPatched=false
local reported={}

local function options()
    return SandboxVars and SandboxVars.B47ANCEDEssentials or {}
end

local function enabled(name)
    return options()[name]~=false
end

local function reportOnce(key,err)
    if reported[key] then return end
    reported[key]=true
    print("[B47ANCEDEssentials] Inventory view disabled after error ("..tostring(key).."): "..tostring(err))
end

local function newVirtual(playerNum,kind)
    local existing=virtualByPlayer[kind][playerNum]
    if existing then return existing end
    local container=ItemContainer.new("B47ANCEDEssentials_"..kind,nil,nil)
    container:setExplored(true)
    container:setOnlyAcceptCategory("B47ANCEDEssentials_virtual_read_only")
    container:setCapacity(0)
    virtualByPlayer[kind][playerNum]=container
    virtualKind[container]=kind
    return container
end

local function addUnique(container,item,seen)
    if not item or seen[item] then return end
    seen[item]=true
    container:getItems():add(item)
end

local function collectEquipped(playerObj,container)
    container:clear()
    local seen={}
    local worn=playerObj and playerObj:getWornItems()
    if worn then
        for index=0,worn:size()-1 do
            local entry=worn:get(index)
            addUnique(container,entry and entry:getItem(),seen)
        end
    end
    addUnique(container,playerObj and playerObj:getPrimaryHandItem(),seen)
    addUnique(container,playerObj and playerObj:getSecondaryHandItem(),seen)
    local hotbar=playerObj and getPlayerHotbar and getPlayerHotbar(playerObj:getPlayerNum())
    if hotbar and hotbar.attachedItems then
        for _,item in pairs(hotbar.attachedItems) do addUnique(container,item,seen) end
    end
    if playerObj and playerObj.getPlayerNum then equippedSetByPlayer[playerObj:getPlayerNum()]=seen end
    return seen
end

local function isLocked(container,playerObj)
    local parent=container and container:getParent()
    return parent and instanceof(parent,"IsoThumpable") and parent:isLockedToCharacter(playerObj)
end

local function collectProximity(page,container,playerObj)
    container:clear()
    local seenContainers={[container]=true}
    local seenItems={}
    for _,button in ipairs(page.backpacks or {}) do
        local source=button and button.inventory
        local kind=source and virtualKind[source]
        if source and not kind and not seenContainers[source] and not isLocked(source,playerObj) then
            seenContainers[source]=true
            local items=source:getItems()
            for index=0,items:size()-1 do addUnique(container,items:get(index),seenItems) end
        end
    end
end

local function getProximityRoots(page,playerObj)
    local roots,seen={},{}
    for _,button in ipairs(page and page.backpacks or{})do
        local source=button and button.inventory
        if source and not virtualKind[source]and not seen[source]and not isLocked(source,playerObj)then
            seen[source]=true;roots[#roots+1]=source
        end
    end
    return roots
end

local function addViewButton(page,kind,title)
    local container=newVirtual(page.player,kind)
    container:clear()
    local button=page:addContainerButton(container,nil,title,title)
    button.capacity=0
    return container,button
end

local function removeEquippedGroups(pane)
    if not enabled("EnableSeparateEquippedInventory") then return end
    -- O.C.D. Inventory owns the same presentation seam when active. Defer to it
    -- instead of stacking two refresh filters or duplicate selector buttons.
    if rawget(_G,"OCDInventory") then return end
    if not pane or not pane.parent or not pane.parent.onCharacter then return end
    local playerObj=getSpecificPlayer(pane.player)
    if not playerObj or pane.inventory~=playerObj:getInventory() then return end
    local equipped=collectEquipped(playerObj,newVirtual(pane.player,"equipped"))
    local selected=pane.saveSelection and pane:saveSelection({}) or nil
    local filtered={}
    for _,group in ipairs(pane.itemslist or {}) do
        local item=group and group.items and (group.items[2] or group.items[1])
        if not equipped[item] then table.insert(filtered,group) end
    end
    pane.itemslist=filtered
    table.wipe(pane.selected)
    pane.firstSelect=nil
    if selected and pane.restoreSelection then pane:restoreSelection(selected); table.wipe(selected) end
    pane:updateScrollbars()
end

local function refreshVirtual(pane)
    local container=pane and pane.inventory
    local kind=container and virtualKind[container]
    if not kind then return end
    local page=pane.parent
    local playerNum=(page and page.player) or pane.player
    local playerObj=playerNum~=nil and getSpecificPlayer(playerNum) or nil
    if not playerObj then return end
    if kind=="equipped" then
        collectEquipped(playerObj,container)
    elseif kind=="proximity" and page then
        -- Rebuild from the real buttons that vanilla admitted to this loot page.
        -- The aggregate never performs its own world or radius scan.
        collectProximity(page,container,playerObj)
    end
end

local function patchRefresh()
    if refreshPatched then return end
    refreshPatched=true
    local original=ISInventoryPane.refreshContainer
    ISInventoryPane.refreshContainer=function(self,...)
        -- A selected virtual view can outlive the container-button rebuild that
        -- first populated it. Refresh its borrowed item references immediately
        -- before vanilla rebuilds rows so equipment and nearby-content changes
        -- cannot leave a stale view on screen.
        local refreshed,refreshErr=pcall(refreshVirtual,self)
        if not refreshed then reportOnce("virtual-refresh",refreshErr) end
        local results={original(self,...)}
        local ok,err=pcall(removeEquippedGroups,self)
        if not ok then reportOnce("equipped-filter",err) end
        return (unpack or table.unpack)(results)
    end
end

local function onRefresh(page,state)
    if not page then return end
    local playerObj=getSpecificPlayer(page.player)
    if not playerObj then return end
    if page.onCharacter and enabled("EnableSeparateEquippedInventory") and not rawget(_G,"OCDInventory") then
        if state=="begin" then
            local container=addViewButton(page,"equipped",getText("IGUI_B47ANCEDEssentials_EquippedInventory"))
            collectEquipped(playerObj,container)
        end
        return
    end
    if not page.onCharacter and enabled("EnableProximityInventory") and not rawget(_G,"ProximityInventory") then
        if state=="begin" then
            addViewButton(page,"proximity",getText("IGUI_B47ANCEDEssentials_ProximityInventory"))
        elseif state=="buttonsAdded" then
            local container=virtualByPlayer.proximity[page.player]
            if container then collectProximity(page,container,playerObj) end
        end
    end
end

local function safeRefresh(...)
    local ok,err=pcall(onRefresh,...)
    if not ok then reportOnce("container-refresh",err) end
end

patchRefresh()
Events.OnRefreshInventoryWindowContainers.Add(safeRefresh)

-- Test and compatibility surface. These do not mutate real ownership.
B47ANCEDEssentials.InventoryViews={
    collectEquipped=collectEquipped,
    collectProximity=collectProximity,
    getProximityRoots=getProximityRoots,
    removeEquippedGroups=removeEquippedGroups,
    refreshVirtual=refreshVirtual,
    virtualKind=function(container) return virtualKind[container] end,
}
