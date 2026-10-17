local modData={itjustWorksGuidedTest={current=2,results={},started=true,complete=false}}
local player={
    getModData=function() return modData end,
    transmitModData=function() end,
}
getPlayer=function() return player end
isClient=function() return false end
HaloTextHelper={addText=function() end}
B47ANCEDEssentials={testKit=function() return true end}

dofile(arg[1])
assert(B47ANCEDEssentialsTestCurrent()=="watch_clock","existing character progress must survive the rename")
local completed=0
assert(B47ANCEDEssentialsOnTestComplete(function() completed=completed+1 end)==true)
assert(B47ANCEDEssentialsTestStart(true,true)=="device_menu","session should start at first step")
assert(modData.itjustWorksGuidedTest.current==1,"current step should persist")
assert(B47ANCEDEssentialsTestPass("ok")=="watch_clock","pass should advance")
assert(modData.itjustWorksGuidedTest.results.device_menu.status=="PASS","pass should record")
assert(B47ANCEDEssentialsTestFail("white light")=="proximity_inventory","failure should advance")
assert(modData.itjustWorksGuidedTest.results.watch_clock.note=="white light","failure note should persist")
assert(B47ANCEDEssentialsTestSkip("needs MP")=="equipped_inventory","skip should advance")
assert(modData.itjustWorksGuidedTest.results.proximity_inventory.status=="SKIP","skip should record")
assert(B47ANCEDEssentialsTestReport()==false,"partial report must not pass")
for index=4,15 do assert(B47ANCEDEssentialsTestPass("ok")~=false) end
assert(completed==1,"completion callback must fire exactly once")
assert(B47ANCEDEssentialsTestCurrent()==true)
assert(completed==1,"completed-session reads must not refire callback")
print("PASS guided test session")
