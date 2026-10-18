B47ANCEDEssentials=B47ANCEDEssentials or {}

local kit={
    {"Base.KeyRing",1},{"Base.Key1",5},
    {"Base.9mmClip",3},{"Base.Bullets9mm",45},
    {"Base.Saw",1},{"Base.Log",3},
    {"Base.BookCarpentry1",2},{"Base.Magazine",2},{"Base.VHS_Retail",3},{"Base.VHS_Home",2},
    {"Base.WristWatch_Right_ClassicBlack",1},{"Base.WristWatch_Right_DigitalBlack",1},
    {"Base.HandTorch",1},{"Base.Battery",2},
}

local function player()
    return type(getPlayer)=="function" and getPlayer() or nil
end

local function add(inventory,fullType)
    if not inventory then return nil end
    local ok,item=pcall(inventory.AddItem,inventory,fullType)
    return ok and item or nil
end

function B47ANCEDEssentials.testStatus()
    local values=SandboxVars and SandboxVars.B47ANCEDEssentials or {}
    local names={"EnableProximityInventory","EnableSeparateEquippedInventory",
        "EnableInventorySelectionRepair","EnableDeviceBatteryMenuGrouping","EnableExactMinuteClock",
        "EnableAutoKeyRing","EnableSortingAutomation","EnableBulkMagazineActions","EnableCraftingOutputRouting",
        "EnableHotbarReordering","EnableMapSymbolDefaultScale","EnableLiteratureTracking","EnableRecordedMediaTracking","EnableMediaRewardHints",
        "EnableContextMenuCleanup","EnableLadderClimbing"}
    print("[B47ANCEDEssentials][Test] version=0.19.1 feature status")
    for _,name in ipairs(names) do print("[B47ANCEDEssentials][Test] "..name.."="..tostring(values[name]~=false)) end
    print("[B47ANCEDEssentials][Test] Commands: B47ANCEDEssentialsTestKit(true), B47ANCEDEssentialsTestStatus()")
    return true
end

function B47ANCEDEssentials.testKit(force)
    local character=player()
    local inventory=character and character:getInventory()
    if not inventory then print("[B47ANCEDEssentials][Test] No local player available"); return false end
    local data=character:getModData()
    -- Preserve the serialized grant flag to prevent duplicate kits after a rename.
    if data.itjustWorksTestKitGranted and force~=true then
        print("[B47ANCEDEssentials][Test] Kit already granted; use B47ANCEDEssentialsTestKit(true) to force another")
        return false
    end
    local granted,missing=0,{}
    for _,entry in ipairs(kit) do
        for _=1,entry[2] do
            if add(inventory,entry[1]) then granted=granted+1 else missing[#missing+1]=entry[1] end
        end
    end
    data.itjustWorksTestKitGranted=true
    if type(character.transmitModData)=="function" and type(isClient)=="function" and isClient() then pcall(character.transmitModData,character) end
    print("[B47ANCEDEssentials][Test] Granted "..granted.." items; unavailable="..#missing)
    if #missing>0 then print("[B47ANCEDEssentials][Test] Missing: "..table.concat(missing,", ")) end
    B47ANCEDEssentials.testStatus()
    return #missing==0
end

B47ANCEDEssentialsTestKit=function(force) return B47ANCEDEssentials.testKit(force) end
B47ANCEDEssentialsTestStatus=function() return B47ANCEDEssentials.testStatus() end
print("[B47ANCEDEssentials][Test] Ready: run B47ANCEDEssentialsTestKit() in the Lua debug console")
return B47ANCEDEssentials
