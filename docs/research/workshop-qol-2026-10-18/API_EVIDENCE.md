# Vanilla API evidence for the QoL plan

Installed Steam build **25485521**, full engine version **UNKNOWN**. All observations are read-only source evidence, with **runtime NOT TESTED**. No custom Java implementation is permitted. Re-audit on build/hash changes and verify exact receiver, side, binding, synchronization and lifecycle before writing gameplay code.

## Complete vanilla recheck

The subsequent [requirement-by-requirement review](VANILLA_RECHECK.md) covers all 116 prior/baseline entries against 63 distinct vanilla Lua files in 26 groups. Its portable source fingerprints, scopes and anchors are in vanilla-review.json. It removes native-covered proposals and keeps uncertain additions out of the ranking. Three reusable native UI observations (recipe filters, map centering and medical-consent prompt) were recorded in the unmanaged local API audit library. The earlier 26-record/11-observation evidence below remains source-only historical support; it is not an exhaustive baseline audit.

## Important native overlap

The project owner corrected inventory search/filtering as vanilla baseline on 2026-10-18. Its proposed implementation was removed. The focused installed-Lua check located the native inventory filter/weight-order menu; it did not independently establish the full-text-search binding. That distinction is recorded in vanilla-baseline.json rather than claiming unsupported source proof.

Native crafting already declares search/filter controls, including output filtering. Native inventory already renders condition ratios. Build 42 also has some native item-return behavior, so the tool-return slice must begin with a reproduced gap. A publisher feature list does not justify duplicating these systems.

## Direct source observations

| Group | Vanilla source | Lines | Observation |
|---|---|---|---|
| inventory | `media/lua/client/ISUI/ISInventoryPane.lua` | 2659 | Native inventory row code already renders a condition ratio. Verify an actual display gap before adding a second indicator. |
| inventory | `media/lua/client/ISUI/ISInventoryPane.lua` | 451 | Native selection/transfer-related inventory code checks favorite state. This observation does not prove server protection for a new operation. |
| craft | `media/lua/client/Entity/ISUI/CraftRecipe/ISWidgetRecipeFilterPanel.lua` | 123 | The native crafting UI already has search/filter widgets; a new adapter must demonstrate missing behavior rather than duplicate the whole panel. |
| craft | `media/lua/client/Entity/ISUI/CraftRecipe/ISWidgetRecipeFilterPanel.lua` | 344 | Native filtering declares an output-item filter capability. Runtime availability and exact input coverage still need comparison. |
| building | `media/lua/client/Entity/ISUI/BuildRecipe/ISBuildPanel.lua` | 131 | Building has a separate native recipe-panel path. Crafting-hook correctness does not prove construction correctness. |
| health | `media/lua/client/XpSystem/ISUI/ISHealthPanel.lua` | 633 | Native health presentation gates some wound details by doctor skill or cheat state. Preserve the ordinary player visibility path. |
| status | `media/lua/client/XpSystem/ISUI/ISHealthPanel.lua` | 467 | A native panel reads the current pain moodle; nearby numeric health/stat displays also have privilege gates and cannot be reused as unrestricted HUD data. |
| food | `media/lua/shared/TimedActions/ISEatFoodAction.lua` | 173 | Native eating has a completion phase. New assistance must delegate to the validated action lifecycle rather than mutate nutrition from a background UI callback. |
| magazine | `media/lua/shared/TimedActions/ISLoadBulletsInMagazine.lua` | 162 | A native magazine loading action is present; inspect its exact constructor, validity and complete path before extending queues. |
| input | `media/lua/shared/keyBinding.lua` | 3 | Native keybinding declarations exist; a shortcut adapter still needs exact registration and focus/controller verification. |
| media | `media/lua/client/ISUI/ISInventoryPaneContextMenu.lua` | 162 | A native inventory context path accesses recorded-media data; knowledge checks must be audited separately. |

## Curated evidence recheck

26 relevant records were rechecked against installed vanilla Lua evidence; every recorded source hash matched. Exact signatures, receivers, execution sides, line ranges and SHA-256 values are in api-evidence.json. Observed call forms do not define all overloads or prove a new use is safe.

| Receiver | Symbol or call | Side | Source status |
|---|---|---|---|
| zombie.entity.components.crafting.recipe.CraftRecipeData | `logic:getRecipeData():getAllInputItems()` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.entity.components.crafting.recipe.CraftRecipeData | `self.logic:getRecipeData():luaCallOnCreate(self.character)` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.entity.components.crafting.recipe.CraftRecipeData | `self.logic:getRecipeData():processDestroyAndUsedItems(self.character)` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.inventory.ItemContainer | `lootContainer:hasRoomFor(self.playerObj, totalWeight + weight)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.inventory.ItemContainer | `targetContainer:isItemAllowed(itemObj)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.inventory.InventoryItem | `testItem:getMediaData()` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.inventory.InventoryItem | `item:getFluidContainer()` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.entity.components.fluids.FluidContainer | `self.container:getCapacity()` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| zombie.entity.components.fluids.FluidContainer | `item:getFluidContainer():getAmount()` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| recipe data returned by self.logic:getRecipeData() | `self.logic:getRecipeData():luaCallOnCreate(self.character)` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| recipe data returned by self.logic:getRecipeData() | `self.logic:getRecipeData():processDestroyAndUsedItems(self.character)` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| Events.OnFillWorldObjectContextMenu | `Events.OnFillWorldObjectContextMenu.Add(callback)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| Events.OnFillInventoryObjectContextMenu | `Events.OnFillInventoryObjectContextMenu.Add(callback)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISContextMenu | `ISContextMenu:addOption(name, target, onSelect, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISContextMenu | `ISContextMenu:addSubMenu(option, menu)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISContextMenu | `ISContextMenu:addActionsOption(text, getActionsFunction, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISBaseTimedAction | `ISBaseTimedAction:isValid()` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISBaseTimedAction | `ISBaseTimedAction:start()` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISBaseTimedAction | `ISBaseTimedAction:stop()` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISBaseTimedAction | `ISBaseTimedAction:perform()` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISBaseTimedAction | `ISBaseTimedAction:getDuration()` | shared | VERIFIED; source hash MATCH; runtime NOT TESTED |
| SGlobalObjectSystem | `SGlobalObjectSystem:new(name)` | server | VERIFIED; source hash MATCH; runtime NOT TESTED |
| CGlobalObjectSystem | `CGlobalObjectSystem:new(name)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISTimedActionQueue | `ISTimedActionQueue.addAfter(previousAction, action)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISTimedActionQueue | `ISTimedActionQueue.queueActions(character, addActionsFunction, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |
| ISInventoryTransferAction | `ISInventoryTransferAction:new(character, item, srcContainer, destContainer, time)` | client | VERIFIED; source hash MATCH; runtime NOT TESTED |

## Open implementation gates

- `inventory`: native access, capacity and item eligibility calls exist; each custom transfer still needs current authoritative ownership and access validation.
- `craft` and `building`: native UI and recipe data exist; a supported adapter point and all knowledge/alternative/station rules need focused proof.
- `actions`, `food` and `magazine`: native action lifecycles exist; each adapter must prove authority, interruption, replay and conservation. UI queuing alone does not prove MP safety.
- `health`, `food` and `status`: native readable values may be skill- or privilege-gated. Nearby cheat/debug calls must not become public HUD data.
- `media`: data access exists; completion and knowledge are per character, not an inferred global learned registry.
- `input` and `context`: native declarations and menus exist; exact registration, focus, controller and compatibility behavior remain runtime gates.
- `fluid`: select APIs by receiver. Component `getAmount()` is not a blanket replacement for a world-object fluid method.
- Native/internal descriptors, camera and audio leads do not establish a permitted reversible Lua hook. Stop blocked slices instead of introducing Java.
