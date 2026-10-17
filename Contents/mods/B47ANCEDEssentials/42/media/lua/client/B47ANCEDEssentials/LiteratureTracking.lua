require "B47ANCEDEssentials/LiteratureCore"

local function enabled()
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    return not values or values.EnableLiteratureTracking~=false
end

local function setting(name,default)
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials
    if values and values[name]~=nil then return values[name] end
    return default
end

local function unwrap(entry)
    if not entry then return nil end
    local ok,item=pcall(function() return entry.items and entry.items[1] or entry end)
    return ok and item or nil
end

local function translated(key,fallback,...)
    if type(getText)=="function" then
        local ok,value=pcall(getText,key,...)
        if ok and value and value~=key then return value end
    end
    return fallback
end

local function label(status,current,total,copies)
    local value=status=="read" and translated("ContextMenu_B47ANCEDEssentials_LiteratureRead","Literature status: Read")
        or status=="partial" and translated("ContextMenu_B47ANCEDEssentials_LiteraturePartial","Literature status: Partially read ("..current.."/"..total.." pages)",current,total)
        or translated("ContextMenu_B47ANCEDEssentials_LiteratureUnread","Literature status: Unread")
    if copies>1 then value=translated("ContextMenu_B47ANCEDEssentials_CarriedCopies",value.."; carrying "..copies.." copies",value,copies) end
    return value
end

local function addStatus(playerNum,context,items)
    if not enabled() or not context then return end
    local player=getSpecificPlayer and getSpecificPlayer(playerNum)
    local item=type(items)=="table" and unwrap(items[1]) or nil
    local status,current,total=B47ANCEDEssentials.literatureStatus(player,item)
    if status then
        local maximum=tonumber(SandboxVars and SandboxVars.B47ANCEDEssentials and SandboxVars.B47ANCEDEssentials.LiteratureInventoryScanLimit) or 250
        local copies=B47ANCEDEssentials.countCarriedCopies(player and player:getInventory(),tostring(item:getFullType()),maximum)
        local option=context:addOption(label(status,current,total,copies)); option.notAvailable=true; option.itemForTexture=item
    elseif setting("EnableRecordedMediaTracking",true) then
        status,current,total=B47ANCEDEssentials.recordedMediaStatus(player,item)
        if status then
            local text=status=="watched" and translated("ContextMenu_B47ANCEDEssentials_MediaWatched","Media status: Watched")
                or status=="partial" and translated("ContextMenu_B47ANCEDEssentials_MediaPartial","Media status: Partially watched ("..current.."/"..total.." segments)",current,total)
                or translated("ContextMenu_B47ANCEDEssentials_MediaUnwatched","Media status: Unwatched")
            local option=context:addOption(text); option.notAvailable=true; option.itemForTexture=item
        end
    end
    if setting("EnableMediaRewardHints",true) then
        local rewards=B47ANCEDEssentials.mediaRewards(item)
        if #rewards>0 then
            local text=translated("ContextMenu_B47ANCEDEssentials_MediaRewards","Teaches: "..table.concat(rewards,", "),table.concat(rewards,", "))
            local option=context:addOption(text); option.notAvailable=true; option.itemForTexture=item
        end
    end
end

local reported=false
local function safe(...)
    local ok,err=pcall(addStatus,...)
    if not ok and not reported then reported=true; print("[B47ANCEDEssentials] Literature status failed safely: "..tostring(err)) end
end

if Events and Events.OnFillInventoryObjectContextMenu then Events.OnFillInventoryObjectContextMenu.Add(safe) end
return B47ANCEDEssentials
