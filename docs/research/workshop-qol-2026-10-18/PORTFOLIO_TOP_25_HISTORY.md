> HISTORICAL PORTFOLIO PLAN: superseded for Essentials by [the Essentials-only top 25](TOP_25_PLAN.md). This preserves the prior cross-project scope and scores; it is not the current Essentials implementation backlog.

# Top 25 after the complete vanilla recheck

[Portfolio ownership audit](PORTFOLIO_OWNERSHIP.md) corrects project assignments and distinguishes coverage outside Essentials. NEW still means absent from Essentials, not absent from our portfolio. Scores and the top-25 membership are unchanged.

This plan includes existing Essentials features as requested. Fully native-covered proposals and unproven additions are not candidates. Read [all 116 dispositions](VANILLA_RECHECK.md) for removals and evidence limits. No gameplay implementation is performed by this research update.

## Shared gates and delivery order

1. Preserve native controls, information/knowledge limits, duration, capacity and authority. Implement only the remaining scope below. A local-source comparison is not runtime proof; reproduce the specific gap in a vanilla-only test before implementing any new slice.
2. Validate current Essentials behavior first: nearby/equipped views, selection, sorting, magazines, media, output routing, hotbar, key filing and map defaults. Keep foundations labeled as foundations; a classifier is not dual-wield combat and heavy-object orchestration is not physics.
3. Develop protected-item/read-model adapters, then explicit transfer/quantity previews. Use current stable references and authoritative committed-result handling; do not introduce a second inventory engine.
4. Add bounded reading or mechanics planners one native-action adapter at a time; validate Auto Clean's existing selected-area cleaner instead of rebuilding it. Vanilla already has timed-action queues; no new generic queue engine is needed.
5. State shared-state ownership, execution side, synchronization, persistence, join/reconnect and restart behavior. Reuse verified native synchronization. New shared mutations require safe server validation; stop if the model is unresolved. Local presentation uses no custom gameplay networking.
6. Every meaningful behavior needs reviewed sandbox policy with stable/localized identifiers, bounds and old-save defaults. Native local UI preferences own style/layout. Proposed keys are design candidates only, not implemented configuration. Record each future target SemVer and keep its mirrors synchronized.
7. Independent implementation uses only neutral requirements and verified vanilla APIs. No third-party algorithms, distinctive architecture, taxonomies, assets, strings or translations. Independent clean-room signoff remains PENDING.
8. Add targeted offline tests and SP evidence. Shared gameplay needs dedicated two-client G7 evidence before stable G8; existing offline checks and this review prove neither. No game, server, deploy, package or publish is authorized here.

S/M/L are relative slice sizes, not calendar estimates. Ranking is estimated impact; delivery order follows dependencies. Other project owners are proposed and must be checked in their own fresh repositories before edits.

## 1. One view for reachable nearby loot

Impact **96**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep the admitted-root nearby projection. Quartermaster can inspect multiple storage targets, but that is not a replacement loot pane. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla discovers individual reachable loot containers and exposes their buttons.

**Retained scope.** Retain Essentials' admitted-root aggregate; do not replace native discovery or expand reach.

**First slice.** Retain the current aggregator. Review source admission, refresh invalidation and coexistence with standalone inventory mods; add only missing source labels and failure explanations after runtime reproduction.

**Ownership and lifecycle.** Pure read projection of currently admitted vanilla loot buttons. Preserve true source containers and item identity. Do not persist projected contents or synchronize a second inventory.

**Settings and existing saves.** Retain existing proximity master, scan and safety settings. No new search-radius slider that exceeds native loot admission. Any optional label is a presentation choice.

**Acceptance scenarios.** Walk across admission boundaries, close a door, stream a vehicle out, change corpse state and reconnect. Each real item appears once; locked or removed roots disappear. Compare with standalone Proximity Inventory enabled and disabled.

**Risk and dependency gates.** Medium: admitted-root lifecycle and replacement-pane interoperability. Dependencies: native/current implementation first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native groups: inventory in [the source comparison](VANILLA_RECHECK.md).

## 2. Safe bulk transfer between selected containers

Impact **94**; Essentials **FOUNDATION**; owner **Essentials + Quartermaster**; effort **L**.

**Portfolio ownership.** Essentials retains its reference/transaction service. Quartermaster already owns a separate logistics executor. A general explicit preview remains unfinished; do not merge executors or introduce a dependency without a reviewed contract. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla already transfers selected items, all items and matching types with timed actions.

**Retained scope.** Retain the existing reference/replay/authority foundation; proposed UI is only an explicit multi-source transaction preview and result workflow, not a new Transfer All button.

**First slice.** Expose the existing transfer foundation through an explicit preview and finite confirmation workflow. First support player-selected carried and ordinary world-container items; extend vehicle and corpse domains only after dedicated tests.

**Ownership and lifecycle.** Client supplies intent and stable references. Server re-resolves actor, source, destination, ownership, access, capacity and item restrictions for every move. Use the existing replay binding and committed-result snapshots; never persist live Lua item pointers.

**Settings and existing saves.** Reuse current operation and traversal limits. Propose EnableBatchTransfer=false until runtime gates pass; protect favorites and equipped items by default. Avoid configurable retry/protocol internals.

**Acceptance scenarios.** Test two clients moving the same item, duplicate and reordered requests, disconnect after commit, full destination, removed container, invalid source and partial completion. Inventory totals and unique ownership must remain conserved after restart.

**Risk and dependency gates.** High: duplication, replay handling and authority. A preview alone is not authorization. Dependencies: item-protection, selection.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryTransferServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/InventoryTransferServer.lua); [InventoryTransferClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryTransferClient.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 3. Put loot into designated or seeded storage

Impact **92**; Essentials **PARTIAL**; owner **Quartermaster + Essentials**; effort **M**.

**Portfolio ownership.** Quartermaster already supplies designated category/item rules, priorities and sorting. Keep current Essentials seeded sorting for standalone use; do not rebuild designation policy. Prevent competing menu actions/plans when both are enabled. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native transfers choose a destination; container discovery is not category/seed destination planning.

**Retained scope.** Retain bounded Essentials seeded sorting; richer shared designation rules remain Quartermaster work.

**First slice.** Keep Essentials' bounded seeded-container behavior and make its exclusions and partial results visible. Route richer category designations to Quartermaster via a reviewed optional contract; do not introduce a second competing taxonomy or storage authority.

**Ownership and lifecycle.** The existing server sorting and transfer core owns mutations. Quartermaster would own shared destination rules and validate edits. Resolve storage identity on authority; replicate committed changes and read canonical rules on join.

**Settings and existing saves.** Retain existing exact-type preference, category fallback, favorite protection and bounded range settings. Future designation policy belongs to Quartermaster's authoritative sandbox; client presentation never overrides it.

**Acceptance scenarios.** Test seeded ties, no eligible destination, stacked and nested containers, capacity changes mid-sort, safehouse access, two clients sorting concurrently, reconnect and restart. Confirm each moved item has one owner and native timing is retained where required.

**Risk and dependency gates.** High: shared ownership and cross-project policy overlap. Dependencies: item-protection, batch-transfer.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [SortingServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/SortingServer.lua); [SortingClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/SortingClient.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 4. Keep inventory selection through refreshes

Impact **89**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep native inventory selection repair here. The UI library has focus helpers, not this inventory integration. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native pane rebuilds and transfer actions maintain their own row/selection state.

**Retained scope.** Retain Essentials' stable-item selection repair and verify regressions against the native rebuild lifecycle.

**First slice.** Retain the current selection repair and review edge cases around filtered, nested and virtual views. Add stable focus restoration only where native controller behavior leaves a reproducible gap.

**Ownership and lifecycle.** Local selection and focus only. Preserve identity for surviving visible items; remove destroyed or inaccessible items. No gameplay persistence or network commands.

**Settings and existing saves.** Use existing selection feature toggle. Any optional focus preference remains local and must not change which items a bulk gameplay action is permitted to move.

**Acceptance scenarios.** Test sorting, stack expansion, item removal, pane switch, search changes, controller selection and split-screen. A removed item must never remain an actionable hidden selection.

**Risk and dependency gates.** Low to medium: native row rebuilding and replacement UI hooks. Dependencies: native/current implementation first.

**Evidence.** [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Native groups: inventory in [the source comparison](VANILLA_RECHECK.md).

## 5. Protect favorites and reserved equipment from bulk actions

Impact **88**; Essentials **PARTIAL**; owner **Essentials + Quartermaster**; effort **M**.

**Portfolio ownership.** Both executors already check some protected states. Quartermaster SupplyAPI checks favorites, equipped/attached and crafting-consumed items. Define interoperability for active reservations; no portfolio-wide protection API is established. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native favorite checks already protect ordinary bulk transfers and some destructive operations.

**Retained scope.** Retain only consistency and protected-equipment checks in Essentials-owned workflows; do not add a second Favorite feature.

**First slice.** Document one original eligibility policy across existing key filing, sorting and magazine helpers before exposing new bulk operations. Add an explicit protected-item explanation; do not silently override the native favorite flag.

**Ownership and lifecycle.** For shared mutations the server checks authoritative protection and equipment state at execution. Client marks are advisory unless a validated server policy stores them. Avoid inventing persistent item flags until their native lifecycle is verified.

**Settings and existing saves.** Retain existing favorite protection. Propose ProtectEquippedItems=true and an explicit per-operation opt-in override only where server policy allows it. Confirm existing keys to avoid conflicting mirrors.

**Acceptance scenarios.** Mark an item favorite or equip it after preview, retry the request, change character and reconnect. Protected items stay untouched; manual native actions remain available with clear scope.

**Risk and dependency gates.** High: a client-only exclusion is insufficient for a shared transaction. Native favorite visibility/replication is UNKNOWN until audited; do not label a client preference as an authoritative reservation. Dependencies: native/current implementation first.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [AutoKeyRing.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/AutoKeyRing.lua); [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 6. Make context actions easier to find

Impact **87**; Essentials **PARTIAL**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep native context grouping here. Domain callbacks and validation remain with their owning mods; UI may supply reusable controls. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla has submenus, disabled reasons and native option callbacks.

**Retained scope.** Retain Essentials device/developer grouping; no wholesale context-menu replacement.

**First slice.** Retain device and developer grouping. Extend only demonstrably crowded families with an original grouping policy, localized labels and preserved option objects; coordinate overlapping menu providers.

**Ownership and lifecycle.** Local presentation; callbacks and permissions remain the original owners' responsibility. The grouping layer never recreates, elevates or executes callbacks automatically.

**Settings and existing saves.** Keep existing menu toggles. Propose one opt-in group policy per meaningful family, not individual option micro-settings. Technical ordering and UI geometry remain internal.

**Acceptance scenarios.** Compare callback target and arguments before and after grouping; test disabled options, nested submenus, tooltip ownership, controller back navigation and duplicate providers.

**Risk and dependency gates.** Medium: compatibility with mods that mutate the same option objects. Dependencies: native/current implementation first.

**Evidence.** [ContextMenuCleanup.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/ContextMenuCleanup.lua); [DevicePowerMenu.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/DevicePowerMenu.lua); [InventoryActionGrouping.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryActionGrouping.lua). Native groups: inventory, world, actions in [the source comparison](VANILLA_RECHECK.md).

## 7. Inspect nested bags without unpacking

Impact **85**; Essentials **FOUNDATION**; owner **Essentials + UI**; effort **M**.

**Portfolio ownership.** Essentials has traversal and nested stable references, while Quartermaster has selected nested-bag logistics. Neither establishes the proposed finished nested browser. Keep the read model in Essentials; UI may render controls. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla exposes equipped carried bags and bags in admitted vehicle/world roots; native recursive queries are not a recursive browsing UI.

**Retained scope.** Retain bounded stable-reference traversal foundation; a future UI is limited to deeper accessible nested inspection with breadcrumbs.

**First slice.** Render the existing bounded traversal and stable reference foundation as native-compatible nested inspection with breadcrumbs. First slice remains read-only; transfers use a separately reviewed action path.

**Ownership and lifecycle.** No projected-container ownership or saved contents. Every nested result retains an admitted root and exact path; root removal or failed resolution hides it. Join rebuilds from current game state.

**Settings and existing saves.** Reuse traversal depth and item/container budgets. Propose EnableNestedInspection=false until UI and runtime checks pass. No option may bypass locks or make remote roots visible.

**Acceptance scenarios.** Test deep nesting, cycles, duplicate roots, bag removal, permission change, streamed-out vehicle, zero items and budget exhaustion. Explain truncation instead of silently implying full coverage.

**Risk and dependency gates.** Medium: nested access rules and virtual-pane compatibility. Dependencies: native/current implementation first.

**Evidence.** [InventoryTraversal.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTraversal.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Native groups: inventory in [the source comparison](VANILLA_RECHECK.md).

## 8. Choose an exact whole-item transfer count

Impact **83**; Essentials **NEW**; owner **Essentials**; effort **M**.

**Portfolio ownership.** Exact whole-item count selection belongs with inventory workflows. Quartermaster shopping target quantities are not the same native inventory transfer dialog. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** The reviewed grab menu offers one, half and all for a selected stack.

**Retained scope.** Keep a whole-item exact-count prompt, excluding existing one/half/all choices and fluid portions.

**First slice.** Add an original bounded count prompt for a selected real-item stack, with an eligible-item preview. Distinguish item count from fluid amount and food portions; the first slice supports whole items only.

**Ownership and lifecycle.** Resolve a finite list of actual item identities; native transfer actions own moves. Shared transfer extensions require the existing authoritative reference service. Never split an item by cloning its fields.

**Settings and existing saves.** Propose EnableQuantityTransfer=true; reuse batch limits. Count defaults to one and is bounded by eligible items and server policy. UI step controls remain local.

**Acceptance scenarios.** Test zero/negative/malformed count, mixed items in one displayed stack, favorites, disappearing items, partial capacity, controller entry and another client taking one item mid-queue.

**Risk and dependency gates.** Medium: displayed stacks are not necessarily homogeneous item objects. Dependencies: item-protection, batch-transfer.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 9. Separate equipped items from carried clutter

Impact **81**; Essentials **IMPLEMENTED**; owner **Essentials + UI**; effort **S**.

**Portfolio ownership.** The Equipped view is already in Essentials. UI can provide presentation helpers; SPXTRM owns light attachments only and must not own this inventory pane. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla marks equipped rows and exposes equipment controls.

**Retained scope.** Retain Essentials' separate worn/held/attached projection and general-list filtering; no new equipment slots.

**First slice.** Retain the current worn/held/attached projection and deferral to compatible standalone providers. Improve missing labels or controller behavior only after inspecting actual conflicts; keep a paper-doll redesign in SPXTRM.

**Ownership and lifecycle.** Read-only local view of native equipment. A worn-and-held item appears once; drag and equip continue through native actions. No new equipment slots or independent-hand combat behavior.

**Settings and existing saves.** Keep current Equipped view and carried-filter toggles. Retain safe native fallback if another mod owns the view. UI layout preferences remain local.

**Acceptance scenarios.** Test key rings, two-handed items, holsters, bags, rapid equip changes, split-screen and standalone O.C.D. Inventory. Selection must survive without hiding an actionable equipped item from both views.

**Risk and dependency gates.** Medium: equipment classifier and replacement-pane compatibility. Dependencies: selection.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [IndependentHandClassifier.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/IndependentHandClassifier.lua). Native groups: inventory, hotbar in [the source comparison](VANILLA_RECHECK.md).

## 10. Show read watched and useful-media progress

Impact **81**; Essentials **IMPLEMENTED**; owner **Essentials + Knowledge & Wisdom**; effort **S**.

**Portfolio ownership.** Keep existing menu progress and carried-duplicate hints in Essentials. Knowledge & Wisdom already supplies bounded recorded-media inspection and owns custom knowledge/research. Do not create a second knowledge ledger; any optional adapter remains unimplemented. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native inventory already tests read literature and stores per-character page/media progress.

**Retained scope.** Retain Essentials' carried-duplicate and reward context integration; existing source remains included even where native indicators overlap.

**First slice.** Retain existing literature/media tracking, then verify partial completion, nested carried duplicates and modded reward data. Present original concise text and do not maintain a second knowledge registry.

**Ownership and lifecycle.** Read native per-character pages, known recipes and recorded-media lines. Cache only bounded derived data, invalidating on character and inventory changes. Never mark media learned merely because it is carried.

**Settings and existing saves.** Retain existing literature master, duplicate and scan-limit settings. Keep knowledge-respecting defaults; reward-detail display is optional. Existing saves derive progress from vanilla state.

**Acceptance scenarios.** Test partially read books, differently named copies, media with multiple lessons, no reward metadata, nested bags, character switch, reconnect and standalone tracker coexistence.

**Risk and dependency gates.** Medium: recorded-media identity and knowledge leaks. Dependencies: native/current implementation first.

**Evidence.** [LiteratureCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/LiteratureCore.lua); [LiteratureTracking.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LiteratureTracking.lua). Native groups: inventory, media in [the source comparison](VANILLA_RECHECK.md).

## 11. Compare fill across container buttons and magazine entries

Impact **80**; Essentials **NEW**; owner **UI**; effort **S**.

**Portfolio ownership.** Simultaneous container-button and magazine fill cues fit planned vanilla presentation adapters. UI has reusable controls but no implemented overlay. Essentials can supply permitted inventory views. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** The selected inventory header already shows weight/capacity; magazine counts are available through native interactions.

**Retained scope.** Only simultaneous fill cues on container buttons and detachable-magazine entries remain; no new capacity or ammo information is claimed.

**First slice.** Add simultaneous compact fill cues to native container buttons and detachable-magazine entries only. Native header weight/capacity and ordinary ammo information remain the source.

**Ownership and lifecycle.** Local display of already visible weight/capacity and current magazine state. Do not set item or container fields, synchronize an extra count or reveal inaccessible bag contents.

**Settings and existing saves.** Propose EnableCapacityIndicators=true, with local text/bar and contrast preferences. A magazine indicator can be toggled as a presentation choice. Never make actual capacity configurable through this feature.

**Acceptance scenarios.** Test zero or unknown capacity, nested bags, weight reduction, overfull containers, empty and mixed magazines, UI scale and color-blind readability. Verify gameplay state is unchanged.

**Risk and dependency gates.** Low: receiver-specific capacity semantics and overlapping overlays. Dependencies: native/current implementation first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Native groups: inventory, hotbar in [the source comparison](VANILLA_RECHECK.md).

## 12. Compact local injury summary outside the health panel

Impact **80**; Essentials **NEW**; owner **Health Care + UI**; effort **M**.

**Portfolio ownership.** Health Care has examination reports and an examiner/patient-scoped five-minute snapshot, not a live injury HUD. Put medical visibility/meaning there and rendering in UI. Medical Checks supplies no enforcing consent service today. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla already has body-part injuries, bandage details and treatment handlers in the health panel.

**Retained scope.** Only an optional compact local injury summary outside the full panel remains; no new diagnosis, hidden wound or other-player detail.

**First slice.** Create an optional compact local injury summary outside the full native health panel. Render only already revealed facts; native diagnosis, treatment and examination consent are baseline.

**Ownership and lifecycle.** Local personal presentation only; no other-player inspection or custom consent/network protocol. Native health state owns all facts. Treatment remains outside this first display slice.

**Settings and existing saves.** Owning medical project sets shared visibility policy and any skill threshold. Personal size, contrast and collapse choices remain local. Confirm actual project option identifiers before implementation.

**Acceptance scenarios.** Compare uncovered, covered and undiagnosed injuries across skill levels; test split-screen privacy, medical-check permission denial, reconnect, healing updates and no stale urgent warnings.

**Risk and dependency gates.** High: medical privacy and skill-gated hidden state. Dependencies: native/current implementation first.

**Evidence.** No implementation claimed in Essentials; inspect the owning repository before choosing production files. Native groups: health in [the source comparison](VANILLA_RECHECK.md).

## 13. Load and unload matching magazines in batches

Impact **78**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep existing matching-magazine native action orchestration. Power and SPXTRM do not own firearm ammunition. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native magazine menu loads/unloads the selected magazine through native timed actions.

**Retained scope.** Retain existing matching-magazine batching and reservation checks; no direct ammunition setters.

**First slice.** Retain current native batch loading/unloading and audit ammunition reservation, nested sources and interrupt handling. Add a preview or optional return adapter only after the existing workflow passes dedicated scenarios.

**Ownership and lifecycle.** Native timed actions own ammunition changes. Reserve unique real rounds within a finite client plan, then rely on current execution validation; never set ammo counts directly. Reconnect discards pending work and reads actual magazine state.

**Settings and existing saves.** Retain current magazine master, nesting and operation limits. Keep matching restrictions and normal load duration. Any source-return option follows the separately validated tool-return policy.

**Acceptance scenarios.** Test mixed ammunition, partial magazines, nested bags, two clients sharing rounds, interruption during transfer/load, missing magazine and repeated command. Total rounds must be conserved apart from ordinary firing.

**Risk and dependency gates.** High until native multiplayer action behavior is exercised. Dependencies: item-protection.

**Evidence.** [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 14. Configurable non-equipment item and recipe action slots

Impact **78**; Essentials **NEW**; owner **Essentials + UI**; effort **M**.

**Portfolio ownership.** Essentials owns ordinary item/recipe invocation and validation; UI can render/configure slots. PC Framework apps are world-computer applications, not global survivor action shortcuts. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native hotbar/keybindings expose equipment and predefined actions.

**Retained scope.** Only configurable item-action and known-recipe shortcut slots beyond native equipment hotkeys remain.

**First slice.** SPXTRM should supply original configurable action slots using native keybinding and controller conventions. First support a small documented set of native item actions; defer automatic build/craft activation until their adapters exist.

**Ownership and lifecycle.** Persist local identifiers and preference data only, never serialized item objects or executable callbacks. Resolve a permitted current item/action on use and delegate gameplay effects to ordinary authority paths.

**Settings and existing saves.** Owning UI project provides enable policy, rebindable keys and local slot count within layout limits. Default bindings must avoid native and existing team conflicts; provide a reset action.

**Acceptance scenarios.** Test missing item, duplicate type, removed recipe, key conflict, controller, text entry focus, reconnect and mod removal. An empty slot may display a preference but must never create an item.

**Risk and dependency gates.** Medium: input conflicts and selecting an unintended same-type item. Dependencies: item-protection.

**Evidence.** No implementation claimed in Essentials; inspect the owning repository before choosing production files. Native groups: options, hotbar, craft in [the source comparison](VANILLA_RECHECK.md).

## 15. Customize local world-container button presets and order

Impact **76**; Essentials **NEW**; owner **UI**; effort **M**.

**Portfolio ownership.** Local button label/icon/order presets belong to UI presentation. Quartermaster storage presets/rules and Rooms room names already exist but are different data. Displaying a label must not create a designation or edit shared names. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla names bag buttons from items, selects built-in container icons and persists ordinary window layout.

**Retained scope.** Only local world-container button label/icon/order presets remain; remove ordinary bag renaming and native window persistence.

**First slice.** Start with local world-container button label/icon/order presets over stable identities. Native bag renaming and window persistence are excluded. Shared storage designation rules belong to the separately reviewed sorting owner.

**Ownership and lifecycle.** Local presentation order has no custom networking. Shared names/designations need server-owned validation, safehouse checks, persistence and canonical snapshots on join; do not overload an item name with a hidden storage rule.

**Settings and existing saves.** Owning storage project sets shared-label edit policy; local order and visual choices use native preferences. Defaults preserve native labels, and reset removes only feature-owned presentation data.

**Acceptance scenarios.** Test two same-name containers, relocation, destruction, rename conflicts, object replacement, save/load, reconnect and another container-order mod. No stale label may target a newly created object at the same coordinates.

**Risk and dependency gates.** High for shared labels; low to medium for local ordering. Dependencies: native/current implementation first.

**Evidence.** [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Native groups: inventory, layout in [the source comparison](VANILLA_RECHECK.md).

## 16. Choose a safe destination for bulky crafting output

Impact **74**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep existing native craft-output routing. Junk Drawer owns salvage outcomes and Provisions owns food-process outcomes; do not intercept or redirect their custom transactions without an explicit provider contract. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla crafting owns output creation and item consumption.

**Retained scope.** Retain the current approved plank/heavy-output routing adapter, subject to authoritative output and capacity rules.

**First slice.** Keep the existing authoritative output adapter. Recheck the approved plank rule and heavy-output option against native creation, and fix only reproduced routing defects.

**Ownership and lifecycle.** Native crafting owns consumption and output creation; the existing scoped adapter chooses an allowed output destination. Clients never create results or mutate yield. No independent output registry is introduced.

**Settings and existing saves.** Reuse current output-routing master, approved rules and heavy threshold. No new output count or capacity setting. Existing saves continue using native item ownership.

**Acceptance scenarios.** Test sawed planks, disallowed recipes, full ground capacity, heavy outputs, interrupted crafting, hook restoration, concurrent crafting and reconnect; inputs and outputs must remain conserved.

**Risk and dependency gates.** High until current native completion and dedicated replication are exercised. Dependencies: native/current implementation first.

**Evidence.** [CraftOutputRouting.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/CraftOutputRouting.lua). Native groups: craft, actions in [the source comparison](VANILLA_RECHECK.md).

## 17. Arrange hotbar slots without reattaching items

Impact **74**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep current slot reordering and saved attachment-index handling. Shared styling can use UI. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native hotbar supports attaching, removing and activating equipment slots.

**Retained scope.** Retain Essentials' slot-order swaps preserving attached-item indices.

**First slice.** Keep Essentials' existing left/right slot swaps and controller menu. Compare against native attach/remove/activate behavior; add no replacement hotbar or automatic equipment swap.

**Ownership and lifecycle.** Local slot order and matching native attachment indices stay paired. Native equipment actions retain mutation ownership. Rebuild from actual equipment after reconnect or item removal.

**Settings and existing saves.** Reuse the existing hotbar reorder toggle. Layout limits stay internal; no new equipment-slot or combat setting.

**Acceptance scenarios.** Test empty and occupied swaps, incompatible attachment types, missing items, rapid equipment changes, save/reload and controller focus. Saved slot order must not detach or duplicate equipment.

**Risk and dependency gates.** Medium: attachment index persistence and hotbar replacement conflicts. Dependencies: native/current implementation first.

**Evidence.** [HotbarReordering.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HotbarReordering.lua). Native groups: hotbar in [the source comparison](VANILLA_RECHECK.md).

## 18. Show condition directly on hotbar slots

Impact **73**; Essentials **NEW**; owner **UI**; effort **S**.

**Portfolio ownership.** Hotbar-only condition display is a planned vanilla UI adapter. Eyewear already displays its own retainer durability, which does not cover general hotbar condition. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native inventory details already draw weapon-condition bars. The reviewed hotbar render draws slots, textures and equipped marks without a condition cue.

**Retained scope.** Keep only an optional hotbar-slot condition cue. Remove duplicate inventory condition rendering.

**First slice.** Add only an original optional condition cue to native hotbar slots; inventory condition rendering is already vanilla and is excluded.

**Ownership and lifecycle.** Local read model, invalidated by actual item changes. Do not expose hidden mechanical state, modify durability or predict future breakage as a fact.

**Settings and existing saves.** Propose a hotbar-only enable policy and local accessible text/bar style. No duplicate inventory indicator, durability mutation or new low-condition gameplay threshold.

**Acceptance scenarios.** Test broken, unconditioned, renamed and modded items, hotbar swaps, equipment changes, UI scaling and another overlay mod. Maximum-condition zero and missing APIs must safely hide the cue.

**Risk and dependency gates.** Low: overlay overlap and different item receiver types. Dependencies: native/current implementation first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [HotbarReordering.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HotbarReordering.lua). Native groups: inventory, hotbar in [the source comparison](VANILLA_RECHECK.md).

## 19. Preserve a configured default map-symbol scale

Impact **72**; Essentials **PARTIAL**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep the current default-symbol-scale behavior. Rooms designation editing and SPXTRM optical rendering are different systems. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native maps already have notes, symbols, sharing and scale controls.

**Retained scope.** Retain only Essentials' configured default symbol scale; no new notes/symbol editor or copied symbol pack.

**First slice.** Retain only the existing configured default symbol-scale adapter. Vanilla already supplies notes, symbols, per-symbol resizing and sharing; do not rebuild those tools.

**Ownership and lifecycle.** Local default presentation preference; native map symbols and synchronization own saved notes. Changing the default does not resize existing annotations or add a second map store.

**Settings and existing saves.** Reuse the current map-symbol default and existing supported bounds. Do not add a second scale slider or symbol pack.

**Acceptance scenarios.** Test a new symbol, a previously edited symbol, notes, map reopening, character changes, native sharing and another map UI. Only new-symbol defaults should change.

**Risk and dependency gates.** Low to medium: defaults must not overwrite per-symbol choices. Dependencies: native/current implementation first.

**Evidence.** [MapSymbolDefaults.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/MapSymbolDefaults.lua). Native groups: maps in [the source comparison](VANILLA_RECHECK.md).

## 20. Keep device power actions attached to the device

Impact **71**; Essentials **IMPLEMENTED**; owner **Essentials + Power**; effort **S**.

**Portfolio ownership.** Keep grouping in Essentials and battery transactions in Power; light-specific servicing belongs to SPXTRM. Essentials still probes legacy powerWorks globals/imports, while renamed Power has no legacy aliases: current pairing requires a compatibility repair and tests. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native devices already have battery, power and media actions.

**Retained scope.** Retain current device-owned grouping and optional-provider duplicate suppression, not new electricity/device ownership.

**First slice.** Retain the existing device-owned action grouping and optional-provider duplicate suppression. Native radio and item menus already supply power, battery and media actions.

**Ownership and lifecycle.** Client rearranges existing option objects; native actions or the verified optional power provider own mutations. Never infer current Power compatibility from the old powerWorks namespace.

**Settings and existing saves.** Reuse current device-menu options. Optional provider detection fails safely to native menus; no new electricity model or battery rates.

**Acceptance scenarios.** Compare callback identity and arguments; test provider absent/present/error, installed cells, ordinary cells, radio/media controls, disabled reasons and controller navigation.

**Risk and dependency gates.** Medium: optional provider identity and duplicated menu ownership. Dependencies: native/current implementation first.

**Evidence.** [DevicePowerMenu.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/DevicePowerMenu.lua). Native groups: radio, inventory in [the source comparison](VANILLA_RECHECK.md).

## 21. Plan a finite vehicle-part service itinerary

Impact **71**; Essentials **NEW**; owner **Essentials**; effort **L**.

**Portfolio ownership.** No general vehicle-service owner was identified. A finite vanilla vehicle-part itinerary fits Essentials. CAT construction machinery qualification and Eyewear retainers do not cover ordinary mechanics. Scope excludes clothing queues. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native mechanics offers part-specific servicing and ordinary queued actions.

**Retained scope.** Keep an explicit finite vehicle-part service itinerary with skip reasons and tool return; exclude generic repair menus and repeated XP-training loops.

**First slice.** Start with an explicit reviewed list of eligible vehicle parts and one supported ordinary service action per part. Present a finite itinerary with skip reasons. Do not add a generic queue engine, clothing repair replacement or XP training loop.

**Ownership and lifecycle.** Native mechanics actions own servicing, parts, wear and experience. Revalidate part identity, tools, skill, access and vehicle state at each step. Pending intent is discarded on disconnect; shared results remain native.

**Settings and existing saves.** Owning vehicle project supplies a server enable policy, default off, protected-item handling and a meaningful finite part limit. UI preferences remain local; no duration/XP multiplier.

**Acceptance scenarios.** Test tool loss, failed native repair, vehicle movement, another player servicing the same part, full inventory, cancel, reconnect and restart. No repeated training cycle or automatic restart.

**Risk and dependency gates.** High: each native mechanics action needs independent authority and interruption evidence. Dependencies: item-protection.

**Evidence.** No implementation claimed in Essentials; inspect the owning repository before choosing production files. Native groups: vehicle, actions in [the source comparison](VANILLA_RECHECK.md).

## 22. Queue a chosen eligible unread-book and media playlist

Impact **70**; Essentials **NEW**; owner **Essentials + Knowledge & Wisdom**; effort **M**.

**Portfolio ownership.** Essentials may orchestrate native reading; Knowledge & Wisdom owns provider documents, completion and knowledge requirements. A finished reading/media playlist was not found. Preserve its MP authority guard; start only with a proven native reading slice. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native reading processes one selected book and tracks pages.

**Retained scope.** Keep an explicitly selected eligible unread-book/media playlist with return and interruption; no new reading/progress engine.

**First slice.** First offer a player-selected finite list of eligible unread books with ordinary native reading actions and a clear skip preview. Add recorded-media playback only after the powered-player/media lifecycle is separately proven.

**Ownership and lifecycle.** Native reading/media systems own pages and knowledge. The client only coordinates chosen actions and optional source return; no learned-content registry or knowledge grant. Reconnect clears pending intent and reads actual progress.

**Settings and existing saves.** Propose a server-visible reading-playlist enable, default off, with favorite protection and a bounded list size. Preserve reading speed, skill eligibility, light and interruption rules. Exact identifiers must be reviewed before implementation.

**Acceptance scenarios.** Test partial books, already learned recipes, books above skill level, darkness, missing or moved books, source removal, interruption and character switch. Never reread forever or grant media completion from carrying an item.

**Risk and dependency gates.** Medium to high: source restoration and media device sequencing are separate action adapters. Dependencies: media-progress, item-protection.

**Evidence.** [LiteratureCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/LiteratureCore.lua); [LiteratureTracking.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LiteratureTracking.lua). Native groups: media, actions in [the source comparison](VANILLA_RECHECK.md).

## 23. File keys into an eligible carried key ring

Impact **69**; Essentials **IMPLEMENTED**; owner **Essentials**; effort **S**.

**Portfolio ownership.** Keep current key/ring predicates and native transfers. Quartermaster storage/shopping rules are not a key-ring replacement. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native menus already transfer keys into recognized key rings.

**Retained scope.** Retain Essentials' bounded automatic filing via native transfers, not another manual Move To Ring menu.

**First slice.** Retain the existing automatic bounded filing helper. Native menus already provide manual transfers into key rings; the retained behavior is explicit-policy automatic filing through those native actions.

**Ownership and lifecycle.** Native transfer actions own item movement. Search only authorized carried roots and recognized rings; revalidate access and protection before moving. No custom key registry or remote key storage.

**Settings and existing saves.** Reuse existing key-filing settings and recognition predicates. Preserve favorite protection, limits and safe defaults for existing saves.

**Acceptance scenarios.** Test nested bags, multiple rings, full rings, protected keys, predicate errors, item removal mid-queue, reconnect and manual destination changes. Each real key retains one owner.

**Risk and dependency gates.** Medium until current native transfer replication is exercised in dedicated multiplayer. Dependencies: item-protection.

**Evidence.** [AutoKeyRing.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/AutoKeyRing.lua). Native groups: inventory, actions in [the source comparison](VANILLA_RECHECK.md).

## 24. Preview and queue cleanup across a chosen rectangle

Impact **68**; Essentials **NEW**; owner **Auto Clean**; effort **Validation first**.

**Portfolio ownership.** Already covered by Auto Clean rectangle/paint/erase/floor selection, confirmation, building cleanup, guarded actions and tool returns. Remove duplicate implementation work from Essentials. Validate or improve the existing Auto Clean workflow in its own repository. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Vanilla provides target-specific cleanup actions and some area-affecting actions.

**Retained scope.** Keep a player-drawn bounded cleanup target plan, eligible-target preview and finite itinerary across that selection; no global scan or speed boost.

**First slice.** Do not implement another area cleaner in Essentials. Auto Clean already provides confirmed rectangle/paint/erase/floor selection, native cleanup and supply return. Review that existing workflow and its runtime acceptance matrix; implement only a reproduced missing behavior in Auto Clean after its own freshness gate.

**Ownership and lifecycle.** Native timed actions own cleanup mutations and supplies. Selected targets are intent, never authority; revalidate loaded target identity, access, distance, tool and resources at execution. Cancel clears pending work and reconnect does not restart it.

**Settings and existing saves.** Reuse current Auto Clean, Rooms cleaning-scope and Quartermaster supply settings. Do not invent a second Essentials cleaning enable switch, selection policy or supply store.

**Acceptance scenarios.** Test rectangle edges, targets removed by another player, safehouses, exhausted tools, resource depletion, cancel, danger, disconnect and server restart. No target outside the selection or unloaded-world scan is admitted.

**Risk and dependency gates.** High: selected-area planning differs from an action merely affecting neighboring tiles; each cleanup adapter needs authority proof. Dependencies: item-protection.

**Evidence.** No implementation claimed in Essentials; inspect the owning repository before choosing production files. Native groups: world, actions in [the source comparison](VANILLA_RECHECK.md).

## 25. Estimate remaining generator runtime from inspected load

Impact **68**; Essentials **NEW**; owner **Power + UI**; effort **M**.

**Portfolio ownership.** Power already reports loaded generator fuel, condition, activation, connection and native consumption. A remaining-runtime estimate is not implemented in that adapter; keep calculation/units with Power and optional presentation with UI. Electrical output capacity remains unknown. See [project evidence](PORTFOLIO_OWNERSHIP.md).

**Already vanilla.** Native generator info already shows fuel, condition, powered items and total draw.

**Retained scope.** Only a clearly labeled remaining-runtime estimate under current measured load remains; remove duplicate fuel/load/device lists and unproven range rendering.

**First slice.** Extend only the inspected generator panel with an original remaining-runtime estimate from currently inspected fuel and actual load. Native fuel, condition, powered-item and consumption lists remain unchanged. Do not add an unproven power-range overlay.

**Ownership and lifecycle.** Local derived presentation only; generator fuel, load and consumption remain native authoritative state. Show units and assumptions, invalidate when inspected load/fuel changes and label estimates rather than predicting unknown devices or future operation.

**Settings and existing saves.** Propose an estimate-display enable policy with local formatting preferences. No new fuel consumption, generator range, capacity or electricity setting. Calculation limits and zero-load safety stay internal.

**Acceptance scenarios.** Test generator off/on, zero or changing load, empty fuel, native consumption units, sandbox time/fuel modifiers, inspection ending, stream-out and reconnect. Unsupported or uncertain unit conversions must display unavailable rather than a fabricated duration.

**Risk and dependency gates.** Medium: exact native units and changing loads need verified Lua receiver contracts and runtime comparison before any estimate is shipped. Dependencies: native/current implementation first.

**Evidence.** No implementation claimed in Essentials; inspect the owning repository before choosing production files. Native groups: generator in [the source comparison](VANILLA_RECHECK.md).
