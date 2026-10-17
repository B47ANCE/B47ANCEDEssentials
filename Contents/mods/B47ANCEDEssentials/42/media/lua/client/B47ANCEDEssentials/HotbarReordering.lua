require "Hotbar/ISHotbar"

B47ANCEDEssentials=B47ANCEDEssentials or {}

local function enabled()
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    return not values or values.EnableHotbarReordering~=false
end

local function text(key,fallback)
    if type(getTextOrNull)=="function" then
        local ok,value=pcall(getTextOrNull,key)
        if ok and value then return value end
    end
    return fallback
end

local function setAttachedIndex(item,index)
    if not item or type(item.setAttachedSlot)~="function" then return end
    pcall(item.setAttachedSlot,item,index)
end

function B47ANCEDEssentials.moveHotbarSlot(hotbar,fromIndex,toIndex)
    local slots=hotbar and hotbar.availableSlot
    local attached=hotbar and hotbar.attachedItems
    if not slots or not attached or fromIndex==toIndex or not slots[fromIndex] or not slots[toIndex] then return false end
    slots[fromIndex],slots[toIndex]=slots[toIndex],slots[fromIndex]
    attached[fromIndex],attached[toIndex]=attached[toIndex],attached[fromIndex]
    setAttachedIndex(attached[fromIndex],fromIndex)
    setAttachedIndex(attached[toIndex],toIndex)
    if type(hotbar.savePosition)=="function" then pcall(hotbar.savePosition,hotbar) end
    if type(hotbar.reloadIcons)=="function" then pcall(hotbar.reloadIcons,hotbar) end
    return true
end

local function move(hotbar,fromIndex,toIndex)
    local ok,err=pcall(B47ANCEDEssentials.moveHotbarSlot,hotbar,fromIndex,toIndex)
    if not ok then print("[B47ANCEDEssentials] Hotbar move failed safely: "..tostring(err)) end
end

local original=ISHotbar and ISHotbar.doMenu
if type(original)=="function" and not ISHotbar.__B47ANCEDEssentialsReorderWrapped then
    ISHotbar.__B47ANCEDEssentialsReorderWrapped=true
    function ISHotbar:doMenu(index)
        original(self,index)
        if not enabled() then return end
        if not index or index<1 or not self.availableSlot or not self.availableSlot[index] then return end
        local context=ISContextMenu.get(self.playerNum,getMouseX(),getMouseY())
        if index>1 then context:addOption(text("ContextMenu_B47ANCEDEssentials_MoveHotbarLeft","Move hotbar slot left"),self,move,index,index-1) end
        if index<#self.availableSlot then context:addOption(text("ContextMenu_B47ANCEDEssentials_MoveHotbarRight","Move hotbar slot right"),self,move,index,index+1) end
    end
end

return B47ANCEDEssentials
