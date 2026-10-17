# In-Game Testing

## Current 0.19.0 rename

Run `python scripts/check_versions.py`, `python scripts/check_identity.py`, and
`python scripts/run_host_tests.py` from the project root. The host runner needs
development-only `lupa` and uses Lua 5.1 plus `table.unpack = table.unpack or unpack`.
The legacy ecosystem PowerShell wrappers are absent from this standalone tree.
The historical feature notes below do not constitute current PZ runtime proof.

Verify new Mod ID activation, the localized sandbox page, menus and native
requires, changed client/server command channels, and integrations updated to
the new public namespace. Use disposable existing-save fixtures to check
preserved operation history, guided progress and kit flags on reload/reconnect
and dedicated restart. No automatic configuration migration is implemented.
SP NOT TESTED; dedicated G7 BLOCKED / NOT TESTED; stable-release G8 BLOCKED.

## Historical feature checks

Version 0.9.1 corrects the literature helper's handling of legitimate `false`
returns. Host coverage verifies that a non-empty learned-recipe list whose
recipes are all known is reported as read. In game, verify one unread recipe
magazine, learn every listed recipe through another source, and confirm the
tracker marks the magazine read without requiring page progress.

The same patch preserves explicit `false` results from container-access checks
on both sorting sides. Host coverage proves an inaccessible destination cannot
receive an item or emit replication. In game, confirm locked or otherwise
inaccessible storage is absent from sorting choices and is never mutated by a
forged or stale request.

Version 0.9.0 adds host-tested independent-hand equipment classification only.
It covers all four ordered pair types, broken/two-handed/unknown rejection,
duplicate-item rejection, third-party providers, and callback isolation. There
is no in-game combat behavior to validate for this slice.

Use a disposable debug save first. Run `B47ANCEDEssentialsTestStart(true, true)` in the Lua debug console to grant the portable kit and begin a fresh guided session. After each displayed step use `B47ANCEDEssentialsTestPass()`, `B47ANCEDEssentialsTestFail("short issue")`, or `B47ANCEDEssentialsTestSkip("reason")`; progress persists on the character. `B47ANCEDEssentialsTestCurrent()` repeats the current instruction and `B47ANCEDEssentialsTestReport()` prints a console-ready report. For an unguided run, `B47ANCEDEssentialsTestKit()` grants the kit and `B47ANCEDEssentialsTestStatus()` prints feature toggles.

When started through `theWorksMassTest(true)`, completing the final B47ANCEDEssentials step automatically begins the Project Nightfall guided session.

1. Right-click powered lights and confirm battery actions work under the light's submenu.
2. Equip mechanical, digital, and military watches; verify exact minutes and their intended information sets.
3. Enable both inventory-view settings. Confirm Nearby combines only reachable loot containers, rejects locked/inaccessible storage, and preserves each item's real source for transfers and context actions.
4. Confirm Equipped appears beside character inventory/bags; worn, held, and attached items appear only there, update after equip/unequip, and retain selection during refresh/drag. Confirm carried key rings remain in ordinary inventory unless actually equipped.
5. Select stacked and individual inventory rows, refresh/transfer, and confirm valid selection remains.
6. Carry loose keys plus key rings in root and nested inventory; wait one in-game minute and verify queued filing, favorites, and limits.
7. Seed nearby crates with distinct item types. Sort an intake container and verify exact matches, full/inaccessible containers, favorites, unmatched items, radius, and optional category fallback.
8. Carry two or more matching magazines and loose ammunition in root/nested bags. Test load all, unload all, interruption, and insufficient rounds.
9. Saw logs/large branches at normal and near-full capacity. Verify planks appear on the character's square and unrelated recipes stay unchanged by default.
10. Move hotbar slots both ways, equip/activate items, change clothing, save/reload, and verify order persists.
11. Change the map default scale, place symbols/notes, then use vanilla's per-symbol slider.
12. Right-click unread, partial, completed, recipe, and duplicate literature plus watched/unwatched skill VHS tapes in nested bags; verify progress and reward hints.
13. In debug/admin mode, verify developer actions are grouped and every original submenu/callback works.
14. Right-click west, north, east, and south ladders from below and aligned top edges. Confirm `Ladder → Climb Ladder` infers direction, routes through native traversal, rejects a destination blocked after menu creation, and stays absent from decorative objects. Test stacked levels, mouse/controller interaction, interruption, and a registered modded ladder property.
15. Repeat sorting and ladder checks as a remote multiplayer client; inspect `console.txt` for `B47ANCEDEssentials`, callback, or command errors.

Historical host wrapper: `tools/Run-HostTests.ps1` (not present here; use the current command above).

The sorting-server regression also injects successful native no-op removal and
destination-add calls plus a throw-after-removal outcome. Each must preserve
single-container ownership, report zero committed moves, and emit no transfer
replication until both observable ownership postconditions succeed.

Version 0.13.0 host coverage resolves an exact schema-versioned world-container
reference and item ID, rejects fractional/stale references, isolates custom
provider authority, and verifies sorting emits the canonical reference schema.
In game, item-ID stability, object-index changes during streaming, and remote
client/server resolution still require explicit validation before general batch
transfer transport is exposed.

The transport regression additionally proves identical per-player retries do
not execute twice, changed payloads conflict, empty batches fail at ingress,
valid requests use the canonical command, and inspected client results cannot
mutate the cache. This remains host evidence only; repeat valid, stale, duplicate,
disconnect/reconnect, and streamed-container requests on hosted and dedicated
servers before a consumer enables transfer controls.

Version 0.14.0 host coverage verifies actor-root resolution, rejects unsupported
nested actor descriptors, and resolves exact item IDs from the actor inventory.
In game, verify uiWorks lists the local carried inventory, equipped facts update,
and save/reload or hosted-client identity changes do not leave stale references.

Version 0.15.0 additionally verifies nested actor paths, exact items inside the
resolved child, stale-link rejection, and path bounds. In game, move a bag and
its contents between nested and root inventory before executing a queued action;
the old path must fail rather than selecting an identically positioned item.

Version 0.16.0 verifies that nearby-root discovery deduplicates vanilla buttons
and excludes locked storage. Native testing must cover button rebuilds and the
ordinary world containers that can be described canonically.

Version 0.17.0 verifies exact vehicle/part resolution, descriptor generation,
and streamed-out vehicle rejection. Native tests must cover trunk access,
vehicle movement, part removal, streaming, and hosted/dedicated ID agreement.

Version 0.18.0 verifies exact corpse ID resolution, descriptor generation, and
stale-ID rejection. Native corpse creation, movement, decay/removal, save/reload,
streaming, and hosted/dedicated ID agreement remain mandatory tests.

The legacy ecosystem console analyzer is absent. During authorized runtime tests,
inspect the current console for `B47ANCEDEssentials` commands and callback errors.
