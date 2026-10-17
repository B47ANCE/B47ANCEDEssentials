local sourcePath=arg[1]
local added={}
local inventory={AddItem=function(_,kind) added[#added+1]=kind; return {kind=kind} end}
local data={itjustWorksTestKitGranted=true}
local character={getInventory=function() return inventory end,getModData=function() return data end}
getPlayer=function() return character end
SandboxVars={B47ANCEDEssentials={}}
isClient=function() return false end
local B47ANCEDEssentials=dofile(sourcePath)
assert(B47ANCEDEssentialsTestKit()==false and #added==0,"existing grant flag must prevent duplicate kits after rename")
data.itjustWorksTestKitGranted=nil
assert(B47ANCEDEssentialsTestKit()==true and #added==72,"test kit should grant the verified item set")
assert(B47ANCEDEssentialsTestKit()==false and #added==72,"test kit should avoid accidental duplicates")
assert(B47ANCEDEssentialsTestKit(true)==true and #added==144,"forced test kit should grant another set")
assert(B47ANCEDEssentialsTestStatus()==true,"status command should remain callable")
print("B47ANCEDEssentials test-kit checks passed")
