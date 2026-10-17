B47ANCEDEssentials=B47ANCEDEssentials or {}

local function settings()
    return SandboxVars and SandboxVars.B47ANCEDEssentials or {}
end

local function translated(key,fallback)
    if type(getTextOrNull)=="function" then
        local ok,value=pcall(getTextOrNull,key)
        if ok and value then return value end
    end
    return fallback
end

local function classify(name,values)
    name=string.lower(tostring(name or ""))
    if values.ContextGroupDebugActions~=false and (name:find("debug",1,true) or name:find("cheat",1,true)) then return true end
    if values.ContextGroupAdminActions~=false and name:find("admin",1,true) then return true end
    return false
end

function B47ANCEDEssentials.groupDeveloperContextActions(context,values)
    values=values or settings()
    if values.EnableContextMenuCleanup==false or not context or type(context.options)~="table" then return 0 end
    local selected={}
    for index,option in ipairs(context.options) do
        if option and not option.__B47ANCEDEssentialsDeveloperBucket and classify(option.name,values) then selected[#selected+1]=index end
    end
    if #selected<2 then return 0 end
    local bucketOption=context:addOption(translated("ContextMenu_B47ANCEDEssentials_DeveloperActions","Developer actions"),nil)
    bucketOption.__B47ANCEDEssentialsDeveloperBucket=true
    local bucket=ISContextMenu:getNew(context)
    context:addSubMenu(bucketOption,bucket)
    for position=#selected,1,-1 do
        local option=table.remove(context.options,selected[position])
        table.insert(bucket.options,1,option)
    end
    for index,option in ipairs(context.options) do option.id=index end
    for index,option in ipairs(bucket.options) do option.id=index end
    context.numOptions=#context.options+1
    bucket.numOptions=#bucket.options+1
    context:calcHeight(); context:setWidth(context:calcWidth())
    bucket:calcHeight(); bucket:setWidth(bucket:calcWidth())
    return #selected
end

local reported=false
local function safe(_,context)
    local ok,err=pcall(B47ANCEDEssentials.groupDeveloperContextActions,context,settings())
    if not ok and not reported then reported=true; print("[B47ANCEDEssentials] Context cleanup failed safely: "..tostring(err)) end
end

if Events and Events.OnFillInventoryObjectContextMenu then Events.OnFillInventoryObjectContextMenu.Add(safe) end
if Events and Events.OnFillWorldObjectContextMenu then Events.OnFillWorldObjectContextMenu.Add(safe) end
return B47ANCEDEssentials
