package.path="Contents/mods/B47ANCEDEssentials/42/media/lua/shared/?.lua;Contents/mods/B47ANCEDEssentials/42/media/lua/shared/?/?.lua;"..package.path

local function item(id,child) return {id=id,child=child} end
local function container(id,items) return {id=id,items=items or {}} end
local leaf=container("c",{item("i3")})
local middle=container("b",{item("i2",leaf)})
local root=container("a",{item("i1",middle),item("cycle",nil)})
root.items[2].child=root
local hidden=container("hidden",{item("secret")})

dofile("Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTraversal.lua")
local traversal=assert(B47ANCEDEssentials.InventoryTraversal)
local options={
    getItems=function(value) return value.items end,
    getChildContainer=function(value) return value.child end,
    getContainerId=function(value) return value.id end,
    getItemId=function(value) return value.id end,
    canView=function(_,value) return value.id~="hidden" end,
    canTransfer=function(_,value) return value.id=="a" end,
}
local result=traversal.traverse({}, {hidden,root,root},options)
assert(#result.containers==3 and #result.items==4,"accessible recursive graph should be traversed once")
assert(result.containers[1].id=="a" and result.containers[2].id=="b","stable IDs should determine traversal order")
assert(result.containers[1].transferable==true and result.containers[2].transferable==false,"permissions must remain distinct")
assert(result.diagnostics.cycles==1 and result.diagnostics.duplicateRoots==1,"cycles and duplicate roots should be reported")
assert(result.diagnostics.inaccessible==1,"inaccessible roots must not expose contents")

local shallow=traversal.traverse({}, {root},setmetatable({maxDepth=0},{__index=options}))
assert(#shallow.containers==1 and shallow.diagnostics.depthLimit,"depth budget must stop child traversal")
local limited=traversal.traverse({}, {root},setmetatable({maxItems=1},{__index=options}))
assert(#limited.items==1 and limited.diagnostics.itemLimit,"item budget must stop traversal")
local unstable=traversal.traverse({}, {{items={item("ok")}}},options)
assert(#unstable.containers==0 and unstable.diagnostics.unstableContainers==1,"containers without stable identity must fail closed")
local duplicateItems=traversal.traverse({}, {container("dupes",{item("same"),item("same")})},options)
assert(#duplicateItems.items==1 and duplicateItems.diagnostics.duplicateItems==1,"duplicate item identities must be suppressed")
local noProof=traversal.traverse({}, {root},{getItems=options.getItems,getChildContainer=options.getChildContainer,
    getContainerId=options.getContainerId,getItemId=options.getItemId})
assert(#noProof.containers==0 and noProof.diagnostics.inaccessible==1,"default access must fail closed without actor proof")
print("test_inventory_traversal.lua: PASS")
