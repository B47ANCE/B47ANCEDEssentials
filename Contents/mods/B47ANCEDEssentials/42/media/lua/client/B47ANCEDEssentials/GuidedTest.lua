B47ANCEDEssentials=B47ANCEDEssentials or {}
B47ANCEDEssentials.guidedTestCompletionCallbacks=B47ANCEDEssentials.guidedTestCompletionCallbacks or {}

local steps={
    {id="device_menu",title="Device-owned action menus",instruction="Right-click powered lights, radios, and digital clocks. Verify activation, controls, alarms, bulbs, and batteries are grouped under the device while generic inventory actions remain at root."},
    {id="watch_clock",title="Watch behavior",instruction="Equip classic, digital, and military watches. Verify exact minutes and the intended information for each watch."},
    {id="proximity_inventory",title="Proximity inventory",instruction="Open nearby floor, corpse, vehicle, and world containers. Verify Nearby combines reachable contents once, excludes locked or unreachable storage, and transfers from each real source."},
    {id="equipped_inventory",title="Equipped inventory",instruction="Equip, hold, attach, and remove items. Verify Equipped appears beside inventory and worn bags, updates immediately, preserves selection and drag behavior, and ordinary carried key rings remain in Inventory."},
    {id="selection",title="Inventory selection",instruction="Select stacked and individual rows, then refresh or transfer. Verify valid selections remain selected."},
    {id="keyring",title="Automatic key rings",instruction="Carry loose keys and key rings in root and nested inventory, wait one game minute, and verify filing, favorites, and limits."},
    {id="sorting",title="Container sorting",instruction="Sort a seeded intake container. Check exact matches, favorites, unmatched items, inaccessible/full containers, radius, and category fallback."},
    {id="magazines",title="Bulk magazines",instruction="Load and unload matching magazines using loose ammunition in root and nested bags. Test interruption and insufficient rounds."},
    {id="craft_output",title="Craft output routing",instruction="Saw logs or large branches near normal and full capacity. Verify outputs route correctly and unrelated recipes are unchanged."},
    {id="hotbar",title="Hotbar reordering",instruction="Move slots both ways, equip/activate items, change clothing, save/reload, and verify order persists."},
    {id="map_symbols",title="Map symbol defaults",instruction="Change default scale, place symbols and notes, and verify vanilla per-symbol scaling still works."},
    {id="literature",title="Literature and media tracking",instruction="Inspect unread, partial, completed, recipe, and duplicate books plus unwatched/partial/watched VHS tapes. Verify skill and recipe reward hints."},
    {id="context_cleanup",title="Context-menu cleanup",instruction="In debug/admin mode verify developer actions are grouped and original callbacks and submenus still work."},
    {id="ladders",title="Ladder interaction",instruction="Right-click recognized west, north, east, and south ladders from below and their aligned top edges. Confirm Ladder → Climb Ladder infers direction, uses native traversal, rejects a destination blocked after menu creation, and never appears on decorative objects. Then check stacked levels, interruption, controller discovery, and a registered modded ladder property."},
    {id="multiplayer",title="Multiplayer authority",instruction="As a remote client repeat sorting and ladder checks, then inspect the console for B47ANCEDEssentials callback or command errors."},
}

local function localPlayer()
    return type(getPlayer)=="function" and getPlayer() or nil
end

local function state(create)
    -- Keep the serialized key so existing character test sessions survive the rename.
    local character=localPlayer()
    if not character or type(character.getModData)~="function" then return nil,nil end
    local data=character:getModData()
    if create and type(data.itjustWorksGuidedTest)~="table" then
        data.itjustWorksGuidedTest={current=1,results={},started=true,complete=false}
    end
    return data.itjustWorksGuidedTest,character
end

local function sync(character)
    if character and type(character.transmitModData)=="function" and type(isClient)=="function" and isClient() then
        pcall(character.transmitModData,character)
    end
end

local function safeNote(note)
    note=tostring(note or "")
    note=note:gsub("[\r\n]+"," ")
    return note
end

local function announce(message,character)
    print("[B47ANCEDEssentials][GuidedTest] "..message)
    if character and HaloTextHelper and type(HaloTextHelper.addText)=="function" then
        pcall(HaloTextHelper.addText,character,message)
    end
end

local function notifyComplete(session)
    if session.completionNotified then return end
    session.completionNotified=true
    local callbacks=B47ANCEDEssentials.guidedTestCompletionCallbacks
    B47ANCEDEssentials.guidedTestCompletionCallbacks={}
    for _,callback in ipairs(callbacks) do
        local ok,err=pcall(callback,session)
        if not ok then print("[B47ANCEDEssentials][GuidedTest] completion callback failed: "..tostring(err)) end
    end
end

function B47ANCEDEssentials.onGuidedTestComplete(callback)
    if type(callback)~="function" then return false end
    B47ANCEDEssentials.guidedTestCompletionCallbacks[#B47ANCEDEssentials.guidedTestCompletionCallbacks+1]=callback
    return true
end

function B47ANCEDEssentials.guidedTestCurrent()
    local session,character=state(false)
    if not session or not session.started then
        announce("No active session. Run B47ANCEDEssentialsTestStart(true).",character)
        return false
    end
    local step=steps[tonumber(session.current) or 1]
    if not step then
        session.complete=true
        announce("All steps recorded. Run B47ANCEDEssentialsTestReport().",character)
        return true
    end
    announce(string.format("STEP %d/%d [%s] %s",session.current,#steps,step.id,step.title),character)
    print("[B47ANCEDEssentials][GuidedTest] ACTION "..step.instruction)
    print('[B47ANCEDEssentials][GuidedTest] Record with B47ANCEDEssentialsTestPass(), B47ANCEDEssentialsTestFail("issue"), or B47ANCEDEssentialsTestSkip("reason").')
    return step.id
end

function B47ANCEDEssentials.guidedTestStart(grantKit,reset)
    local session,character=state(true)
    if not session then print("[B47ANCEDEssentials][GuidedTest] No local player available"); return false end
    if reset==true or session.complete then
        local data=character:getModData()
        data.itjustWorksGuidedTest={current=1,results={},started=true,complete=false}
        session=data.itjustWorksGuidedTest
    end
    if grantKit==true and type(B47ANCEDEssentials.testKit)=="function" then B47ANCEDEssentials.testKit(false) end
    sync(character)
    announce("Session started; progress is stored on this character.",character)
    return B47ANCEDEssentials.guidedTestCurrent()
end

local function record(status,note)
    local session,character=state(false)
    if not session or not session.started then announce("No active session. Run B47ANCEDEssentialsTestStart(true).",character); return false end
    local index=tonumber(session.current) or 1
    local step=steps[index]
    if not step then return B47ANCEDEssentials.guidedTestCurrent() end
    session.results=session.results or {}
    session.results[step.id]={status=status,note=safeNote(note),step=index}
    print(string.format("[B47ANCEDEssentials][GuidedTest] RESULT id=%s status=%s note=%s",step.id,status,safeNote(note)))
    session.current=index+1
    session.complete=session.current>#steps
    sync(character)
    if session.complete then
        announce("Complete. Run B47ANCEDEssentialsTestReport() for the summary.",character)
        notifyComplete(session)
        return true
    end
    return B47ANCEDEssentials.guidedTestCurrent()
end

function B47ANCEDEssentials.guidedTestReport()
    local session=state(false)
    if not session then print("[B47ANCEDEssentials][GuidedTest] No session data"); return false end
    local counts={PASS=0,FAIL=0,SKIP=0,PENDING=0}
    print("[B47ANCEDEssentials][GuidedTest] REPORT BEGIN")
    for index,step in ipairs(steps) do
        local result=session.results and session.results[step.id]
        local status=result and result.status or "PENDING"
        local note=result and safeNote(result.note) or ""
        counts[status]=(counts[status] or 0)+1
        print(string.format("[B47ANCEDEssentials][GuidedTest] RESULT id=%s status=%s note=%s",step.id,status,note))
    end
    print(string.format("[B47ANCEDEssentials][GuidedTest] SUMMARY pass=%d fail=%d skip=%d pending=%d",counts.PASS,counts.FAIL,counts.SKIP,counts.PENDING))
    print("[B47ANCEDEssentials][GuidedTest] REPORT END")
    return counts.FAIL==0 and counts.PENDING==0
end

B47ANCEDEssentialsTestStart=function(grantKit,reset) return B47ANCEDEssentials.guidedTestStart(grantKit,reset) end
B47ANCEDEssentialsTestCurrent=function() return B47ANCEDEssentials.guidedTestCurrent() end
B47ANCEDEssentialsTestPass=function(note) return record("PASS",note) end
B47ANCEDEssentialsTestFail=function(note) return record("FAIL",note) end
B47ANCEDEssentialsTestSkip=function(note) return record("SKIP",note) end
B47ANCEDEssentialsTestReport=function() return B47ANCEDEssentials.guidedTestReport() end
B47ANCEDEssentialsOnTestComplete=function(callback) return B47ANCEDEssentials.onGuidedTestComplete(callback) end

print("[B47ANCEDEssentials][GuidedTest] Ready: B47ANCEDEssentialsTestStart(true)")
return B47ANCEDEssentials
