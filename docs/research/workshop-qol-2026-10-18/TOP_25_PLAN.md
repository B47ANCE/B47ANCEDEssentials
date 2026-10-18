# Essentials-only top 25

This replaces the cross-project top 25. **All 20 existing Essentials source/partial/foundation entries are retained**, representing all 21 original identifiers (`container-open` is merged into `nested-view`). Five slots go to the highest-scored new Essentials workflows. The 29 eligible entries and every excluded proposal are recorded in [the ranking](ESSENTIALS_RANKING.md) and [decision ledger](essentials-only.json).

The retained set is sorted by estimated impact, with stable-ID tie ordering. Because existing features must stay included, this is a preservation-constrained selection: four eligible new ideas remain outside the top 25, even where they outscore a retained foundation. No new idea was invented or split into extra entries to reach 25. Scores remain ordinal estimates from the reviewed scoped requirements, not measured benefits or implementation readiness.

Existing means source is present, Partial means narrower behavior, and Foundation means supporting contracts without the complete workflow. **NEW is unimplemented. No entry is runtime-verified by this research.** Existing adapters are retained under the user exception; that does not authorize duplicating their providers' gameplay systems.

## Selection

| Rank | Essentials feature | Coverage | Impact |
|---:|---|---|---:|
| 1 | [Reachable nearby-loot view](#nearby-view) | IMPLEMENTED | 96 |
| 2 | [Validated bulk-transfer preview and execution](#batch-transfer) | FOUNDATION | 94 |
| 3 | [Sort into nearby seeded containers](#storage-sort) | PARTIAL | 92 |
| 4 | [Preserve inventory selection through refreshes](#selection) | IMPLEMENTED | 89 |
| 5 | [Protect items during Essentials bulk actions](#item-protection) | PARTIAL | 88 |
| 6 | [Group related context-menu actions](#context) | PARTIAL | 87 |
| 7 | [Inspect nested bags without unpacking](#nested-view) | FOUNDATION | 85 |
| 8 | [Choose an exact whole-item transfer quantity](#take-quantity) | NEW | 83 |
| 9 | [Separate equipped items from carried inventory](#equipment-view) | IMPLEMENTED | 81 |
| 10 | [Show native reading/media progress and carried duplicates](#media-progress) | IMPLEMENTED | 81 |
| 11 | [Load or unload matching magazines in batches](#magazine-batch) | IMPLEMENTED | 78 |
| 12 | [Item and recipe action shortcuts](#shortcuts) | NEW | 78 |
| 13 | [Route bulky native crafting output safely](#craft-output) | IMPLEMENTED | 74 |
| 14 | [Reorder existing hotbar slots](#hotbar) | IMPLEMENTED | 74 |
| 15 | [Remember the default map-symbol scale](#map-annotation) | PARTIAL | 72 |
| 16 | [Group battery actions under their device](#device-menus) | IMPLEMENTED | 71 |
| 17 | [Queue selected vanilla vehicle-part services](#maintenance-queue) | NEW | 71 |
| 18 | [Queue selected eligible native books](#reading-queue) | NEW | 70 |
| 19 | [Automatically file keys into carried key rings](#key-filing) | IMPLEMENTED | 69 |
| 20 | [Explain Essentials partial-transfer outcomes](#transfer-feedback) | FOUNDATION | 68 |
| 21 | [Mark an owned book or media item for later](#personal-marks) | NEW | 63 |
| 22 | [Independent-hand compatibility classifier](#equipment-swap) | PARTIAL | 62 |
| 23 | [Display permitted watch time to the minute](#clock) | IMPLEMENTED | 59 |
| 24 | [Heavy-object provider lifecycle foundation](#heavy-movement) | FOUNDATION | 51 |
| 25 | [Expose valid tagged-ladder interactions](#ladder) | IMPLEMENTED | 49 |

## Shared implementation gates

1. Retain current behavior before expanding it. Source/foundation labels must not become claims of working dual wield, physics, complete nested browsing or a finished bulk-transfer interface.
2. Use original Lua-only code and verified vanilla APIs; no third-party code, algorithms, architecture, assets, text or taxonomies are imported. Provenance stays in the broader census. Independent clean-room signoff remains PENDING.
3. Preserve native time, skill, tools, resources, knowledge, capacity and access. Each new workflow needs a reproduced non-native gap and exact installed-build API evidence before implementation. Do not revive native search or the other vanilla removals.
4. Clients supply intent. Authority revalidates shared mutations and persists/synchronizes results using verified native behavior where possible. Reconnect/restart, replay, competing actors and uncertain completion remain explicit acceptance gates. Pure local presentation requires no custom gameplay networking.
5. Reuse current sandbox settings. Meaningful new shared behavior needs server-authoritative localized settings, stable identifiers, bounds/defaults and existing-save policy; identifiers below are proposals until implementation review. Technical safety limits remain internal. Local appearance preferences do not override gameplay policy.
6. Do not add dependencies or move code through this plan. UI may supply controls; Power owns energy, Knowledge & Wisdom owns custom knowledge, Quartermaster owns designated storage/logistics, and domain providers own their state. Known legacy Power adapter incompatibility remains open.
7. This is documentation at Essentials 0.19.2. Record a target SemVer before any future implementation. Offline tests do not prove native SP or dedicated G7; gameplay stable G8 remains blocked without the required dedicated evidence. No build, deploy, upload or launch is part of this update.

## Feature breakdown and implementation slices

<a id="nearby-view"></a>
## 1. Reachable nearby-loot view

Impact **96**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Combine only real containers already admitted by vanilla. Keep true item sources and native access; no Quartermaster storage scanner.

**Native baseline.** Vanilla discovers individual reachable loot containers and exposes their buttons.

**Next Essentials slice.** Retain the current aggregator. Review source admission, refresh invalidation and coexistence with standalone inventory mods; add only missing source labels and failure explanations after runtime reproduction.

**Authority and lifecycle.** Pure read projection of currently admitted vanilla loot buttons. Preserve true source containers and item identity. Do not persist projected contents or synchronize a second inventory.

**Settings / existing saves.** Retain existing proximity master, scan and safety settings. No new search-radius slider that exceeds native loot admission. Any optional label is a presentation choice.

**Acceptance.** Walk across admission boundaries, close a door, stream a vehicle out, change corpse state and reconnect. Each real item appears once; locked or removed roots disappear. Compare with standalone Proximity Inventory enabled and disabled.

**Risk and dependencies.** Medium: admitted-root lifecycle and replacement-pane interoperability. Dependencies: native/current implementation first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native evidence groups: inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="batch-transfer"></a>
## 2. Validated bulk-transfer preview and execution

Impact **94**; coverage **FOUNDATION**; owner **Essentials**; effort **L**.

**What it does / Essentials boundary.** Retain Essentials stable references, replay binding and transfer core; finish its own explicit preview/result workflow only. Quartermaster keeps its logistics executor and rules.

**Native baseline.** Vanilla already transfers selected items, all items and matching types with timed actions.

**Next Essentials slice.** Complete only Essentials' explicit selected-item preview and committed-result workflow over its existing exact-reference/transfer service. Do not merge in Quartermaster executors or designation policy.

**Authority and lifecycle.** Client supplies intent and stable references. Server re-resolves actor, source, destination, ownership, access, capacity and item restrictions for every move. Use the existing replay binding and committed-result snapshots; never persist live Lua item pointers.

**Settings / existing saves.** Reuse current operation and traversal limits. Propose EnableBatchTransfer=false until runtime gates pass; protect favorites and equipped items by default. Avoid configurable retry/protocol internals.

**Acceptance.** Test two clients moving the same item, duplicate and reordered requests, disconnect after commit, full destination, removed container, invalid source and partial completion. Inventory totals and unique ownership must remain conserved after restart.

**Risk and dependencies.** High: duplication, replay handling and authority. A preview alone is not authorization. Dependencies: item-protection, selection.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryTransferServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/InventoryTransferServer.lua); [InventoryTransferClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryTransferClient.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="storage-sort"></a>
## 3. Sort into nearby seeded containers

Impact **92**; coverage **PARTIAL**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Retain current bounded seeded matching only. Category designations, storage presets, room allocations and building logistics remain Quartermaster work.

**Native baseline.** Native transfers choose a destination; container discovery is not category/seed destination planning.

**Next Essentials slice.** Retain seeded-container matching and clarify eligible/skipped destinations/results. Do not implement designated category storage, presets, quotas, room/building logistics or a new taxonomy.

**Authority and lifecycle.** The existing server sorting and transfer core owns mutations. Quartermaster would own shared destination rules and validate edits. Resolve storage identity on authority; replicate committed changes and read canonical rules on join.

**Settings / existing saves.** Retain existing exact-type preference, category fallback, favorite protection and bounded range settings. Future designation policy belongs to Quartermaster's authoritative sandbox; client presentation never overrides it.

**Acceptance.** Test seeded ties, no eligible destination, stacked and nested containers, capacity changes mid-sort, safehouse access, two clients sorting concurrently, reconnect and restart. Confirm each moved item has one owner and native timing is retained where required.

**Risk and dependencies.** High: shared ownership and cross-project policy overlap. Dependencies: item-protection, batch-transfer.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [SortingServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/SortingServer.lua); [SortingClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/SortingClient.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="selection"></a>
## 4. Preserve inventory selection through refreshes

Impact **89**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Repair local native-pane selection by surviving item identity. Do not build a replacement inventory interface.

**Native baseline.** Native pane rebuilds and transfer actions maintain their own row/selection state.

**Next Essentials slice.** Retain the current selection repair and review edge cases around filtered, nested and virtual views. Add stable focus restoration only where native controller behavior leaves a reproducible gap.

**Authority and lifecycle.** Local selection and focus only. Preserve identity for surviving visible items; remove destroyed or inaccessible items. No gameplay persistence or network commands.

**Settings / existing saves.** Use existing selection feature toggle. Any optional focus preference remains local and must not change which items a bulk gameplay action is permitted to move.

**Acceptance.** Test sorting, stack expansion, item removal, pane switch, search changes, controller selection and split-screen. A removed item must never remain an actionable hidden selection.

**Risk and dependencies.** Low to medium: native row rebuilding and replacement UI hooks. Dependencies: native/current implementation first.

**Evidence.** [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Native evidence groups: inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="item-protection"></a>
## 5. Protect items during Essentials bulk actions

Impact **88**; coverage **PARTIAL**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Apply favorite/equipped/crafting/reservation checks to Essentials-owned operations where verified. Do not create a global Dibs, reservation or protection engine for other mods.

**Native baseline.** Native favorite checks already protect ordinary bulk transfers and some destructive operations.

**Next Essentials slice.** Audit and consistently apply protection to Essentials-owned transfer/sorting/queue entry points. Revalidate at execution; leave Quartermaster Dibs and cross-mod reservation authority with their owners.

**Authority and lifecycle.** For shared mutations the server checks authoritative protection and equipment state at execution. Client marks are advisory unless a validated server policy stores them. Avoid inventing persistent item flags until their native lifecycle is verified.

**Settings / existing saves.** Retain existing favorite protection. Propose ProtectEquippedItems=true and an explicit per-operation opt-in override only where server policy allows it. Confirm existing keys to avoid conflicting mirrors.

**Acceptance.** Mark an item favorite or equip it after preview, retry the request, change character and reconnect. Protected items stay untouched; manual native actions remain available with clear scope.

**Risk and dependencies.** High: a client-only exclusion is insufficient for a shared transaction. Native favorite visibility/replication is UNKNOWN until audited; do not label a client preference as an authoritative reservation. Dependencies: native/current implementation first.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [AutoKeyRing.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/AutoKeyRing.lua); [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="context"></a>
## 6. Group related context-menu actions

Impact **87**; coverage **PARTIAL**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current native-menu grouping and preserved callbacks. Domain actions retain their own authorization; no shared-UI overhaul.

**Native baseline.** Vanilla has submenus, disabled reasons and native option callbacks.

**Next Essentials slice.** Retain device and developer grouping. Extend only demonstrably crowded families with an original grouping policy, localized labels and preserved option objects; coordinate overlapping menu providers.

**Authority and lifecycle.** Local presentation; callbacks and permissions remain the original owners' responsibility. The grouping layer never recreates, elevates or executes callbacks automatically.

**Settings / existing saves.** Keep existing menu toggles. Propose one opt-in group policy per meaningful family, not individual option micro-settings. Technical ordering and UI geometry remain internal.

**Acceptance.** Compare callback target and arguments before and after grouping; test disabled options, nested submenus, tooltip ownership, controller back navigation and duplicate providers.

**Risk and dependencies.** Medium: compatibility with mods that mutate the same option objects. Dependencies: native/current implementation first.

**Evidence.** [ContextMenuCleanup.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/ContextMenuCleanup.lua); [DevicePowerMenu.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/DevicePowerMenu.lua); [InventoryActionGrouping.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryActionGrouping.lua). Native evidence groups: inventory, world, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="nested-view"></a>
## 7. Inspect nested bags without unpacking

Impact **85**; coverage **FOUNDATION**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Retain traversal/reference foundation and complete an Essentials inventory workflow over authorized roots. UI may render generic controls, but does not own this inventory behavior.

**Native baseline.** Vanilla exposes equipped carried bags and bags in admitted vehicle/world roots; native recursive queries are not a recursive browsing UI.

**Next Essentials slice.** Render the existing bounded traversal and stable reference foundation as native-compatible nested inspection with breadcrumbs. First slice remains read-only; transfers use a separately reviewed action path.

**Authority and lifecycle.** No projected-container ownership or saved contents. Every nested result retains an admitted root and exact path; root removal or failed resolution hides it. Join rebuilds from current game state.

**Settings / existing saves.** Reuse traversal depth and item/container budgets. Propose EnableNestedInspection=false until UI and runtime checks pass. No option may bypass locks or make remote roots visible.

**Acceptance.** Test deep nesting, cycles, duplicate roots, bag removal, permission change, streamed-out vehicle, zero items and budget exhaustion. Explain truncation instead of silently implying full coverage.

**Risk and dependencies.** Medium: nested access rules and virtual-pane compatibility. Dependencies: native/current implementation first.

**Evidence.** [InventoryTraversal.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTraversal.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Native evidence groups: inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="take-quantity"></a>
## 8. Choose an exact whole-item transfer quantity

Impact **83**; coverage **NEW**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Add an explicit count for a finite native transfer of whole items. Do not duplicate native one/half/all choices or Quartermaster shopping targets.

**Native baseline.** The reviewed grab menu offers one, half and all for a selected stack.

**Next Essentials slice.** Add an original bounded count prompt for a selected real-item stack, with an eligible-item preview. Distinguish item count from fluid amount and food portions; the first slice supports whole items only.

**Authority and lifecycle.** Resolve a finite list of actual item identities; native transfer actions own moves. Shared transfer extensions require the existing authoritative reference service. Never split an item by cloning its fields.

**Settings / existing saves.** Propose EnableQuantityTransfer=true; reuse batch limits. Count defaults to one and is bounded by eligible items and server policy. UI step controls remain local.

**Acceptance.** Test zero/negative/malformed count, mixed items in one displayed stack, favorites, disappearing items, partial capacity, controller entry and another client taking one item mid-queue.

**Risk and dependencies.** Medium: displayed stacks are not necessarily homogeneous item objects. Dependencies: item-protection, batch-transfer.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="equipment-view"></a>
## 9. Separate equipped items from carried inventory

Impact **81**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current worn/held/attached projection in Essentials. No new equipment state, lighting-attachment ownership or broad UI framework.

**Native baseline.** Vanilla marks equipped rows and exposes equipment controls.

**Next Essentials slice.** Retain the current worn/held/attached projection and deferral to compatible standalone providers. Improve missing labels or controller behavior only after inspecting actual conflicts; keep a paper-doll redesign in SPXTRM.

**Authority and lifecycle.** Read-only local view of native equipment. A worn-and-held item appears once; drag and equip continue through native actions. No new equipment slots or independent-hand combat behavior.

**Settings / existing saves.** Keep current Equipped view and carried-filter toggles. Retain safe native fallback if another mod owns the view. UI layout preferences remain local.

**Acceptance.** Test key rings, two-handed items, holsters, bags, rapid equip changes, split-screen and standalone O.C.D. Inventory. Selection must survive without hiding an actionable equipped item from both views.

**Risk and dependencies.** Medium: equipment classifier and replacement-pane compatibility. Dependencies: selection.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [IndependentHandClassifier.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/IndependentHandClassifier.lua). Native evidence groups: inventory, hotbar in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="media-progress"></a>
## 10. Show native reading/media progress and carried duplicates

Impact **81**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep existing native progress, carried-copy counts and data-driven hints. Knowledge & Wisdom retains custom knowledge, research and progression; no duplicate ledger or knowledge grant.

**Native baseline.** Native inventory already tests read literature and stores per-character page/media progress.

**Next Essentials slice.** Retain existing literature/media tracking, then verify partial completion, nested carried duplicates and modded reward data. Present original concise text and do not maintain a second knowledge registry.

**Authority and lifecycle.** Read native per-character pages, known recipes and recorded-media lines. Cache only bounded derived data, invalidating on character and inventory changes. Never mark media learned merely because it is carried.

**Settings / existing saves.** Retain existing literature master, duplicate and scan-limit settings. Keep knowledge-respecting defaults; reward-detail display is optional. Existing saves derive progress from vanilla state.

**Acceptance.** Test partially read books, differently named copies, media with multiple lessons, no reward metadata, nested bags, character switch, reconnect and standalone tracker coexistence.

**Risk and dependencies.** Medium: recorded-media identity and knowledge leaks. Dependencies: native/current implementation first.

**Evidence.** [LiteratureCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/LiteratureCore.lua); [LiteratureTracking.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LiteratureTracking.lua). Native evidence groups: inventory, media in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="magazine-batch"></a>
## 11. Load or unload matching magazines in batches

Impact **78**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current native magazine action orchestration, ammunition reservations, timing and interruption behavior.

**Native baseline.** Native magazine menu loads/unloads the selected magazine through native timed actions.

**Next Essentials slice.** Retain current native batch loading/unloading and audit ammunition reservation, nested sources and interrupt handling. Add a preview or optional return adapter only after the existing workflow passes dedicated scenarios.

**Authority and lifecycle.** Native timed actions own ammunition changes. Reserve unique real rounds within a finite client plan, then rely on current execution validation; never set ammo counts directly. Reconnect discards pending work and reads actual magazine state.

**Settings / existing saves.** Retain current magazine master, nesting and operation limits. Keep matching restrictions and normal load duration. Any source-return option follows the separately validated tool-return policy.

**Acceptance.** Test mixed ammunition, partial magazines, nested bags, two clients sharing rounds, interruption during transfer/load, missing magazine and repeated command. Total rounds must be conserved apart from ordinary firing.

**Risk and dependencies.** High until native multiplayer action behavior is exercised. Dependencies: item-protection.

**Evidence.** [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="shortcuts"></a>
## 12. Item and recipe action shortcuts

Impact **78**; coverage **NEW**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Own the workflow that invokes a known native item/recipe action. Generic UI controls may be optional helpers; exclude a general hotbar replacement, theme/layout engine and PC app host.

**Native baseline.** Native hotbar/keybindings expose equipment and predefined actions.

**Next Essentials slice.** Add a small configurable set of item/known-native-recipe invocation slots. Resolve a valid native action on use and preserve requirements/time; UI may supply controls without transferring this workflow or introducing a presentation framework.

**Authority and lifecycle.** Persist local identifiers and preference data only, never serialized item objects or executable callbacks. Resolve a permitted current item/action on use and delegate gameplay effects to ordinary authority paths.

**Settings / existing saves.** Owning UI project provides enable policy, rebindable keys and local slot count within layout limits. Default bindings must avoid native and existing team conflicts; provide a reset action.

**Acceptance.** Test missing item, duplicate type, removed recipe, key conflict, controller, text entry focus, reconnect and mod removal. An empty slot may display a preference but must never create an item.

**Risk and dependencies.** Medium: input conflicts and selecting an unintended same-type item. Dependencies: item-protection.

**Evidence.** No implementation claimed; production paths are chosen only after the API/authority spike. Native evidence groups: options, hotbar, craft in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="craft-output"></a>
## 13. Route bulky native crafting output safely

Impact **74**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current authoritative native crafting-output routing and provider predicates. Junk Drawer salvage outcomes and Provisions process transactions remain their own.

**Native baseline.** Vanilla crafting owns output creation and item consumption.

**Next Essentials slice.** Keep the existing authoritative output adapter. Recheck the approved plank rule and heavy-output option against native creation, and fix only reproduced routing defects.

**Authority and lifecycle.** Native crafting owns consumption and output creation; the existing scoped adapter chooses an allowed output destination. Clients never create results or mutate yield. No independent output registry is introduced.

**Settings / existing saves.** Reuse current output-routing master, approved rules and heavy threshold. No new output count or capacity setting. Existing saves continue using native item ownership.

**Acceptance.** Test sawed planks, disallowed recipes, full ground capacity, heavy outputs, interrupted crafting, hook restoration, concurrent crafting and reconnect; inputs and outputs must remain conserved.

**Risk and dependencies.** High until current native completion and dedicated replication are exercised. Dependencies: native/current implementation first.

**Evidence.** [CraftOutputRouting.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/CraftOutputRouting.lua). Native evidence groups: craft, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="hotbar"></a>
## 14. Reorder existing hotbar slots

Impact **74**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current left/right reorder with native attachment indexes. New condition overlays and general hotbar presentation belong to UI.

**Native baseline.** Native hotbar supports attaching, removing and activating equipment slots.

**Next Essentials slice.** Keep Essentials' existing left/right slot swaps and controller menu. Compare against native attach/remove/activate behavior; add no replacement hotbar or automatic equipment swap.

**Authority and lifecycle.** Local slot order and matching native attachment indices stay paired. Native equipment actions retain mutation ownership. Rebuild from actual equipment after reconnect or item removal.

**Settings / existing saves.** Reuse the existing hotbar reorder toggle. Layout limits stay internal; no new equipment-slot or combat setting.

**Acceptance.** Test empty and occupied swaps, incompatible attachment types, missing items, rapid equipment changes, save/reload and controller focus. Saved slot order must not detach or duplicate equipment.

**Risk and dependencies.** Medium: attachment index persistence and hotbar replacement conflicts. Dependencies: native/current implementation first.

**Evidence.** [HotbarReordering.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HotbarReordering.lua). Native evidence groups: hotbar in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="map-annotation"></a>
## 15. Remember the default map-symbol scale

Impact **72**; coverage **PARTIAL**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Retain the current default-scale behavior while preserving the native symbol editor. Do not add Rooms designation editing or replace map UI.

**Native baseline.** Native maps already have notes, symbols, sharing and scale controls.

**Next Essentials slice.** Retain only the existing configured default symbol-scale adapter. Vanilla already supplies notes, symbols, per-symbol resizing and sharing; do not rebuild those tools.

**Authority and lifecycle.** Local default presentation preference; native map symbols and synchronization own saved notes. Changing the default does not resize existing annotations or add a second map store.

**Settings / existing saves.** Reuse the current map-symbol default and existing supported bounds. Do not add a second scale slider or symbol pack.

**Acceptance.** Test a new symbol, a previously edited symbol, notes, map reopening, character changes, native sharing and another map UI. Only new-symbol defaults should change.

**Risk and dependencies.** Low to medium: defaults must not overwrite per-symbol choices. Dependencies: native/current implementation first.

**Evidence.** [MapSymbolDefaults.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/MapSymbolDefaults.lua). Native evidence groups: maps in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="device-menus"></a>
## 16. Group battery actions under their device

Impact **71**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current Essentials presentation adapter, including a future repair for the renamed Power API. Power owns compatibility, energy and battery actions; SPXTRM owns lighting service.

**Native baseline.** Native devices already have battery, power and media actions.

**Next Essentials slice.** Retain the existing device-owned action grouping and optional-provider duplicate suppression. Native radio and item menus already supply power, battery and media actions.

**Authority and lifecycle.** Client rearranges existing option objects; native actions or the verified optional power provider own mutations. Never infer current Power compatibility from the old powerWorks namespace.

**Settings / existing saves.** Reuse current device-menu options. Optional provider detection fails safely to native menus; no new electricity model or battery rates.

**Acceptance.** Compare callback identity and arguments; test provider absent/present/error, installed cells, ordinary cells, radio/media controls, disabled reasons and controller navigation.

**Risk and dependencies.** Medium: optional provider identity and duplicated menu ownership. Dependencies: native/current implementation first.

**Evidence.** [DevicePowerMenu.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/DevicePowerMenu.lua). Native evidence groups: radio, inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="maintenance-queue"></a>
## 17. Queue selected vanilla vehicle-part services

Impact **71**; coverage **NEW**; owner **Essentials**; effort **L**.

**What it does / Essentials boundary.** Coordinate a finite player-selected native mechanics itinerary only. No general vehicle simulation, CAT qualification system, clothing-maintenance system or changed service requirements.

**Native baseline.** Native mechanics offers part-specific servicing and ordinary queued actions.

**Next Essentials slice.** Start with an explicit reviewed list of eligible vehicle parts and one supported ordinary service action per part. Present a finite itinerary with skip reasons. Do not add a generic queue engine, clothing repair replacement or XP training loop.

**Authority and lifecycle.** Native mechanics actions own servicing, parts, wear and experience. Revalidate part identity, tools, skill, access and vehicle state at each step. Pending intent is discarded on disconnect; shared results remain native.

**Settings / existing saves.** Owning vehicle project supplies a server enable policy, default off, protected-item handling and a meaningful finite part limit. UI preferences remain local; no duration/XP multiplier.

**Acceptance.** Test tool loss, failed native repair, vehicle movement, another player servicing the same part, full inventory, cancel, reconnect and restart. No repeated training cycle or automatic restart.

**Risk and dependencies.** High: each native mechanics action needs independent authority and interruption evidence. Dependencies: item-protection.

**Evidence.** No implementation claimed; production paths are chosen only after the API/authority spike. Native evidence groups: vehicle, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="reading-queue"></a>
## 18. Queue selected eligible native books

Impact **70**; coverage **NEW**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Coordinate a finite native-book reading list. Exclude custom study, research, progression, journal recovery and recorded-media playback/device scheduling. Knowledge & Wisdom retains those domain contracts.

**Native baseline.** Native reading processes one selected book and tracks pages.

**Next Essentials slice.** Offer an explicit finite list of eligible native books, with a skip preview and native reading actions. Exclude recorded-media playback, custom research/study or knowledge-provider actions from this slice.

**Authority and lifecycle.** Native reading owns pages, recipe unlocks and knowledge. Essentials coordinates selected eligible books only, uses no custom progression store and clears pending intent on reconnect. No bypass of Knowledge & Wisdom MP guards or invocation of its blocked mutation APIs.

**Settings / existing saves.** Propose a server-visible reading-playlist enable, default off, with favorite protection and a bounded list size. Preserve reading speed, skill eligibility, light and interruption rules. Exact identifiers must be reviewed before implementation.

**Acceptance.** Test partial books, already learned recipes, books above skill level, darkness, missing or moved books, source removal, interruption and character switch. Never reread forever or grant media completion from carrying an item.

**Risk and dependencies.** Native reading sequencing and source restoration require verified action adapters and runtime acceptance. Custom provider research and recorded-media playback are excluded. Dependencies: media-progress, item-protection.

**Evidence.** [LiteratureCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/LiteratureCore.lua); [LiteratureTracking.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LiteratureTracking.lua). Native evidence groups: media, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="key-filing"></a>
## 19. Automatically file keys into carried key rings

Impact **69**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current recognition predicates and bounded native transfers into accessible carried rings. No global storage policy.

**Native baseline.** Native menus already transfer keys into recognized key rings.

**Next Essentials slice.** Retain the existing automatic bounded filing helper. Native menus already provide manual transfers into key rings; the retained behavior is explicit-policy automatic filing through those native actions.

**Authority and lifecycle.** Native transfer actions own item movement. Search only authorized carried roots and recognized rings; revalidate access and protection before moving. No custom key registry or remote key storage.

**Settings / existing saves.** Reuse existing key-filing settings and recognition predicates. Preserve favorite protection, limits and safe defaults for existing saves.

**Acceptance.** Test nested bags, multiple rings, full rings, protected keys, predicate errors, item removal mid-queue, reconnect and manual destination changes. Each real key retains one owner.

**Risk and dependencies.** Medium until current native transfer replication is exercised in dedicated multiplayer. Dependencies: item-protection.

**Evidence.** [AutoKeyRing.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/AutoKeyRing.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="transfer-feedback"></a>
## 20. Explain Essentials partial-transfer outcomes

Impact **68**; coverage **FOUNDATION**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Retain current read-only transaction results and add explanations for this executor only. Quartermaster retains its own logistics progress/results; no universal notifications framework.

**Native baseline.** Native transfers perform valid moves and handle access/capacity failures.

**Next Essentials slice.** Retain inspectReferencedTransferResult and its bounded read-only snapshots. Add a compact explanation of committed, skipped, stale and rejected moves to Essentials-owned confirmation/results; do not retry automatically.

**Authority and lifecycle.** Only authority receipts establish completion. Local text must not recalculate ownership or infer success from a closed pane. Reconnect requires current state rather than replaying stale client intent.

**Settings / existing saves.** Reuse current operation/result bounds and feature policy; presentation verbosity can remain local. No retry/protocol micro-settings.

**Acceptance.** Exercise partial capacity failures, disappeared containers, inaccessible items, duplicate/reordered replies, missing result, disconnect after commit and operation-ID mismatch. Never present unknown ownership as success.

**Risk and dependencies.** Result presentation is incomplete; native receipt/replication behavior remains a runtime gate. Dependencies: batch-transfer.

**Evidence.** [InventoryTransferClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryTransferClient.lua); [InventoryTransferServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/InventoryTransferServer.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua). Native evidence groups: inventory, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="personal-marks"></a>
## 21. Mark an owned book or media item for later

Impact **63**; coverage **NEW**; owner **Essentials**; effort **M**.

**What it does / Essentials boundary.** Local, explicitly chosen seen-for-later mark on an accessible item. Do not grant read state, reveal hidden titles, create a research/study ledger, add shopping demands or duplicate Dibs lists.

**Native baseline.** Native favorites and native learned/read state already exist.

**Next Essentials slice.** Prototype a local explicit read-later mark for an exact accessible item. Resolve native identity and a supported local persistence route before shipping; if identity cannot survive reload safely, keep it session-only and label that limit.

**Authority and lifecycle.** Personal note only, never a favorite/read/learned setter. Do not expose inaccessible item names or sync another player's notes. Removed or replaced items must not inherit a stale mark.

**Settings / existing saves.** Propose a meaningful enable policy; mark display and confirmation are local preferences. Choose actual identifiers and old-save defaults in the future implementation version. No custom knowledge or shopping configuration.

**Acceptance.** Test not-yet-readable books, known/unknown media titles, nested items, split/merge, transfer, destruction, reconnect, save/reload and character replacement. A bookmark grants no recipe, page progress, title knowledge or demand.

**Risk and dependencies.** Stable local item identity/persistence and native title-reveal policy need verification; no implementation claimed. Dependencies: media-progress.

**Evidence.** No implementation claimed; production paths are chosen only after the API/authority spike. Native evidence groups: inventory, media in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="equipment-swap"></a>
## 22. Independent-hand compatibility classifier

Impact **62**; coverage **PARTIAL**; owner **Essentials**; effort **Validation first**.

**What it does / Essentials boundary.** Keep the existing fail-closed pairing classifier and bounded providers only. No working dual-wield combat, input, reload or animation system is claimed by this entry.

**Native baseline.** Vanilla already equips primary/secondary items and switches attached equipment.

**Next Essentials slice.** Retain and validate the current independent-hand classifier/provider registry. Audit pair changes and provider errors; defer any attack, input, swapping or animation implementation to a separate proven Lua-only slice.

**Authority and lifecycle.** Read-only classification of real current hand equipment. No ammunition, damage, animation or equipment mutation is provided by this foundation.

**Settings / existing saves.** Retain current classifier/provider configuration; no hypothetical combat balance settings are implemented by this plan.

**Acceptance.** Test one/two-handed, broken, duplicate and unknown weapons, reversed pairs, missing actors, provider failure/removal and repeated registration. Unsupported equipment must fail closed.

**Risk and dependencies.** Classifier source is not dual-wield feasibility or dedicated combat proof. Dependencies: native/current implementation first.

**Evidence.** [IndependentHandClassifier.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/IndependentHandClassifier.lua). Native evidence groups: hotbar, inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="clock"></a>
## 23. Display permitted watch time to the minute

Impact **59**; coverage **IMPLEMENTED**; owner **Essentials**; effort **S**.

**What it does / Essentials boundary.** Keep current clock formatting and device information limits. Power retains powered-watch behavior; the legacy adapter mismatch is an unresolved compatibility gate.

**Native baseline.** Native watch display supplies device-dependent time information.

**Next Essentials slice.** Retain exact-minute formatting and current native device precision limits. Separately repair the legacy Power contract only after checking the renamed provider in its own current source; no new watch simulation.

**Authority and lifecycle.** Local formatting of permitted time/device facts. Power owns battery/charge and mechanical/digital behavior. No extra information for a device that cannot supply it.

**Settings / existing saves.** Retain EnableExactMinuteClock and native clock-size/12/24-hour preferences. Keep energy/service policy in Power.

**Acceptance.** Check minute rollover, midnight/noon, 12/24-hour, mechanical/digital clocks, unavailable or unpowered devices, UI scale and split-screen. Test renamed-Power present/absent without claiming adapter compatibility before proof.

**Risk and dependencies.** Legacy powerWorks watch probe is incompatible/unverified against renamed Power; native layout and device behavior remain runtime gates. Dependencies: native/current implementation first.

**Evidence.** [ExactWatchClock.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/ExactWatchClock.lua). Native evidence groups: options, inventory in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="heavy-movement"></a>
## 24. Heavy-object provider lifecycle foundation

Impact **51**; coverage **FOUNDATION**; owner **Essentials**; effort **Validation first**.

**What it does / Essentials boundary.** Keep existing capability and reserve/start/complete/cancel contracts. Domain providers own all physics/object/terrain state; Quartermaster keeps hauling logistics. No production physics provider is claimed.

**Native baseline.** Vanilla moveable/placement systems own supported movement and collision.

**Next Essentials slice.** Retain the bounded provider query and authoritative lifecycle/recovery foundation. Validate contracts with disposable offline providers; do not add physics, wheelbarrow or logistics implementations to fill this entry.

**Authority and lifecycle.** Provider owns actual object mutation and simulation. Essentials validates operation identity and lifecycle; clients submit intent. Uncertain commits stay quarantined and replay must not repeat mutation.

**Settings / existing saves.** Preserve current enable/policy settings and technical limits. A later gameplay provider must define its own meaningful server sandbox policy, supported persistence and old-save behavior.

**Acceptance.** Test missing/failed provider, changed actor/target, denied reach, duplicate requests, reserve/start/complete/cancel ordering, uncertain completion, reload and restart. Dedicated evidence with a real safe provider is required before production claims.

**Risk and dependencies.** No production physics provider; native authority, synchronization and recovery are not established by mocks. Dependencies: native/current implementation first.

**Evidence.** [HeavyObjects.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/HeavyObjects.lua); [HeavyObjectServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/HeavyObjectServer.lua); [HeavyObjectClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HeavyObjectClient.lua). Native evidence groups: placement, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).

<a id="ladder"></a>
## 25. Expose valid tagged-ladder interactions

Impact **49**; coverage **IMPLEMENTED**; owner **Essentials**; effort **Validation first**.

**What it does / Essentials boundary.** Keep the current property-based native-transition adapter and access/landing checks. No teleportation, terrain simulation, Fences catalog or new traversal engine.

**Native baseline.** Native traversal states support climbing; their presence is not an automatic property-based ladder context adapter.

**Next Essentials slice.** Retain property-driven ladder context actions and verify the existing native rope-state adapter on valid orientations. No new automatic input/traversal or terrain system.

**Authority and lifecycle.** Native transition states own movement. Admit only valid tagged loaded tiles with legal access and safe landing; no teleport or global scan.

**Settings / existing saves.** Reuse existing ladder master/safety settings and bounded property registration. No speed boost or physics setting.

**Acceptance.** Test four orientations, blocked/missing landing, multi-floor edges, actor death/incapacitation, streamed tiles, modded tags, controller selection and two-client observation. Native transition/replication remains untested until actual PZ evidence.

**Risk and dependencies.** Source adapter does not prove runtime collision, animation or dedicated movement correctness. Dependencies: native/current implementation first.

**Evidence.** [LadderInteraction.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LadderInteraction.lua). Native evidence groups: world, actions in [the complete vanilla recheck](VANILLA_RECHECK.md).
