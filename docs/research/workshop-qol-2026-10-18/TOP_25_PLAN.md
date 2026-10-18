# Top 25 clean room implementation plans

These plans cover the top 25 overall, including existing features. Impact order differs from implementation order: validate the foundations before exposing dependent workflows. No feature implementation, deployment or publication is part of this audit.

## Shared entry gates

1. Inventory search and filtering are vanilla baseline and are not implementation work. Reproduce a concrete gap against the installed vanilla build and current owning-project implementation. Native search, condition displays and Build 42 auto-return already cover parts of these requirements. If no gap exists, record native coverage and add no duplicate feature.
2. A fresh implementer receives only neutral requirements, permitted metadata references and verified vanilla evidence. Keep private lexical/raw-description research outside the implementation context. No external Lua, algorithms, private tables, architecture, assets, translations or distinctive UI text are an implementation source. The current audit author has seen metadata, module/interface names and declarations; this is a separation workflow, not a claim of legally certified isolation.
3. Audit the exact vanilla receiver, signature, execution side and source hash for the selected slice. [API evidence](API_EVIDENCE.md) is a starting point, not a finished authority proof. Stop gameplay work if a safe Lua-only authority model cannot be established.
4. Record the next development SemVer before implementation. This documentation stays tied to 0.19.2 and does not authorize a version bump in another project. Preserve canonical VERSION and mirrors through each later iteration.
5. Use feature-specific sandbox policy for meaningful behavior and native local preferences for presentation. New keys below are proposed design reservations in the existing namespace, not implemented options. Reuse existing options where present; do not add protocol or UI-coordinate micro-settings. Local presentation must never override shared policy. All option names/tooltips need original localization, reviewed bounds/steps and explicit old-save defaults.
6. Review exact state ownership, access, persistence, join/reconnect, restart and duplicate-operation behavior. Reuse native synchronization when proven. Do not add custom networking to read-only local presentation.
7. Each slice gets targeted offline tests and SP verification. Shared gameplay requires dedicated two-client tests before G7 can PASS; stable G8 stays BLOCKED without required evidence. Proven local-only changes may be G7 N/A only after documenting that no shared state is touched.
8. Every research-related PR requires an independent clean-room reviewer signoff. Current status is PENDING. Unknown rights block copying, while original independent design remains available.

## Delivery sequence

- Phase A: audit existing coverage and native overlap: nearby view, selection, equipment, media, magazines and current sorting. Add no replacement engines.
- Phase B: protection and read models: item exclusions, nested inspection, capacity and condition; then local health/food/status presentation through their owners.
- Phase C: expose explicit transfer/quantity previews, finish authoritative result handling, then storage integration. The foundation must pass its mutation gates before dependent UI ships.
- Phase D: one cancellable native-action adapter, then source return and optional food assistance. Each adapter has independent authority and interruption gates.
- Phase E: SPXTRM recipe/building improvements, shortcuts and storage labels after focused native-gap audits. Do not bundle broad UI replacement or shared ownership changes into Essentials.

Effort S = one bounded adapter/review slice; M = several related slices; L = authority or cross-project work. These are relative scope estimates, not calendar promises. Source paths below identify current Essentials evidence; future production files must be chosen after inspecting the owning repository.

## 1. One view for reachable nearby loot

Impact **96**; coverage **IMPLEMENTED**; proposed owner **Essentials**; effort **S**.

**Behavioral contract.** Aggregate only containers admitted by the vanilla loot window; retain real ownership, reach and permissions.

**First independent slice.** Retain the current aggregator. Review source admission, refresh invalidation and coexistence with standalone inventory mods; add only missing source labels and failure explanations after runtime reproduction.

**Ownership and lifecycle.** Pure read projection of currently admitted vanilla loot buttons. Preserve true source containers and item identity. Do not persist projected contents or synchronize a second inventory.

**Configuration and saves.** Retain existing proximity master, scan and safety settings. No new search-radius slider that exceeds native loot admission. Any optional label is a presentation choice.

**Acceptance scenarios.** Walk across admission boundaries, close a door, stream a vehicle out, change corpse state and reconnect. Each real item appears once; locked or removed roots disappear. Compare with standalone Proximity Inventory enabled and disabled.

**Cost and blockers.** Medium: admitted-root lifecycle and replacement-pane interoperability. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [2847184718](https://steamcommunity.com/sharedfiles/filedetails/?id=2847184718), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562).

## 2. Safe bulk transfer between selected containers

Impact **94**; coverage **FOUNDATION**; proposed owner **Essentials + Quartermaster**; effort **L**.

**Behavioral contract.** Preview a finite set of moves, protect excluded items, then execute ordinary authorized transfers with partial results.

**First independent slice.** Expose the existing transfer foundation through an explicit preview and finite confirmation workflow. First support player-selected carried and ordinary world-container items; extend vehicle and corpse domains only after dedicated tests.

**Ownership and lifecycle.** Client supplies intent and stable references. Server re-resolves actor, source, destination, ownership, access, capacity and item restrictions for every move. Use the existing replay binding and committed-result snapshots; never persist live Lua item pointers.

**Configuration and saves.** Reuse current operation and traversal limits. Propose EnableBatchTransfer=false until runtime gates pass; protect favorites and equipped items by default. Avoid configurable retry/protocol internals.

**Acceptance scenarios.** Test two clients moving the same item, duplicate and reordered requests, disconnect after commit, full destination, removed container, invalid source and partial completion. Inventory totals and unique ownership must remain conserved after restart.

**Cost and blockers.** High: duplication, replay handling and authority. A preview alone is not authorization. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection, selection.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryTransferServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/InventoryTransferServer.lua); [InventoryTransferClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryTransferClient.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Vanilla groups: inventory, actions in [API evidence](API_EVIDENCE.md). Discovery: [3422220305](https://steamcommunity.com/sharedfiles/filedetails/?id=3422220305), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3761216758](https://steamcommunity.com/sharedfiles/filedetails/?id=3761216758).

## 3. Queue repeated ordinary actions with cancellation

Impact **92**; coverage **NEW**; proposed owner **Essentials orchestrator + domain owners**; effort **L**.

**Behavioral contract.** Queue a finite selection of valid native actions, show progress and stop cleanly when danger or prerequisites change.

**First independent slice.** Design a small original finite action coordinator with progress and cancel. First adapter: a selected set of ordinary dismantling actions. Domain projects own cooking, medical, farming and vehicle adapters; no universal action monkey-patch.

**Ownership and lifecycle.** Client sequences ordinary native timed actions; each action retains its vanilla authority path. Shared effects must be revalidated on authority at execution. Persist no active queue initially; reconnect discards pending client intent and re-reads authoritative results.

**Configuration and saves.** Propose EnableActionQueues=false, QueueStopOnThreat=true and a bounded MaxQueuedActions setting (default 25, supported 1â€“100). Tools, XP, duration and combat restrictions remain native. Use localized reasons for skipped tasks.

**Acceptance scenarios.** Cancel before start and between actions; remove a tool or target, become encumbered, take damage, disconnect and restart. No automatic restart, XP farming loop, duration reduction or duplicate reward is permitted.

**Cost and blockers.** High: each adapter needs its own authority and interruption proof. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection.

**Evidence.** [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Vanilla groups: actions, context in [API evidence](API_EVIDENCE.md). Discovery: [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [3761218629](https://steamcommunity.com/sharedfiles/filedetails/?id=3761218629), [3776658529](https://steamcommunity.com/sharedfiles/filedetails/?id=3776658529), [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745).

## 4. Put loot into designated or seeded storage

Impact **92**; coverage **PARTIAL**; proposed owner **Quartermaster + Essentials**; effort **M**.

**Behavioral contract.** Offer explicit destination rules or existing-content matches with capacity, access and favorite safeguards.

**First independent slice.** Keep Essentials' bounded seeded-container behavior and make its exclusions and partial results visible. Route richer category designations to Quartermaster via a reviewed optional contract; do not introduce a second competing taxonomy or storage authority.

**Ownership and lifecycle.** The existing server sorting and transfer core owns mutations. Quartermaster would own shared destination rules and validate edits. Resolve storage identity on authority; replicate committed changes and read canonical rules on join.

**Configuration and saves.** Retain existing exact-type preference, category fallback, favorite protection and bounded range settings. Future designation policy belongs to Quartermaster's authoritative sandbox; client presentation never overrides it.

**Acceptance scenarios.** Test seeded ties, no eligible destination, stacked and nested containers, capacity changes mid-sort, safehouse access, two clients sorting concurrently, reconnect and restart. Confirm each moved item has one owner and native timing is retained where required.

**Cost and blockers.** High: shared ownership and cross-project policy overlap. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection, batch-transfer.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [SortingServer.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/server/B47ANCEDEssentials/SortingServer.lua); [SortingClient.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/SortingClient.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua). Vanilla groups: inventory, actions in [API evidence](API_EVIDENCE.md). Discovery: [3761216758](https://steamcommunity.com/sharedfiles/filedetails/?id=3761216758), [3807217050](https://steamcommunity.com/sharedfiles/filedetails/?id=3807217050), [3290232938](https://steamcommunity.com/sharedfiles/filedetails/?id=3290232938).

## 5. Find crafting recipes by inputs and outputs

Impact **91**; coverage **NEW**; proposed owner **SPXTRM**; effort **M**.

**Behavioral contract.** Search and filter known recipe entries by name, required item and result while retaining skill and station requirements.

**First independent slice.** Have SPXTRM add an original search/filter adapter to the native known-recipe list. Start with name, input and output matching and preserve native recipe selection; do not replace the entire crafting engine.

**Ownership and lifecycle.** Local indexes contain only currently available recipe metadata. Rebuild on recipe registry, character knowledge or source changes. Selecting a result opens the ordinary native recipe workflow.

**Configuration and saves.** Use a server-visible enable policy and optional local remember-filter preference in the owning UI project. Default to native knowledge restrictions and empty search on character changes. Confirm existing SPXTRM identifiers before defining keys.

**Acceptance scenarios.** Test unknown recipes, skill gates, stations, alternative ingredients, mod removal, controller navigation and thousands of recipes. Search must not make an uncraftable recipe craftable or conceal a native failure reason.

**Cost and blockers.** Medium: Build 42 recipe UI contracts need a focused adapter audit. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: craft in [API evidence](API_EVIDENCE.md). Discovery: [3502080466](https://steamcommunity.com/sharedfiles/filedetails/?id=3502080466), [3390169945](https://steamcommunity.com/sharedfiles/filedetails/?id=3390169945).

## 6. Explain missing ingredients tools and stations

Impact **89**; coverage **NEW**; proposed owner **SPXTRM + Essentials**; effort **M**.

**Behavioral contract.** Present alternatives, quantities, tool roles and station requirements from current recipe data without granting knowledge.

**First independent slice.** Add an original requirements view for the selected recipe using native recipe data and admitted inventory snapshots. Distinguish consumed material, reusable tool, alternative ingredient, knowledge and workstation requirements.

**Ownership and lifecycle.** Local presentation only. The native craft transaction chooses and consumes inputs. A displayed estimate never authorizes consumption or substitutes a client count for authoritative ingredients.

**Configuration and saves.** Owning UI project exposes an enable policy and local expanded-details preference. Retain native ingredient selection and skill gates. No new ingredient reach or automatic substitutions by default.

**Acceptance scenarios.** Test alternative ingredients with different amounts, fluid components, reusable tools, favorites, missing station and recipe removal. A stale preview must refresh or fail without consuming an unintended item.

**Cost and blockers.** Medium: multiple recipe systems and fluid receiver differences. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** craft-search, item-protection.

**Evidence.** [InventoryTraversal.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTraversal.lua). Vanilla groups: craft, inventory, fluid in [API evidence](API_EVIDENCE.md). Discovery: [3502080466](https://steamcommunity.com/sharedfiles/filedetails/?id=3502080466), [3540503606](https://steamcommunity.com/sharedfiles/filedetails/?id=3540503606), [3536052310](https://steamcommunity.com/sharedfiles/filedetails/?id=3536052310).

## 7. Keep inventory selection through refreshes

Impact **89**; coverage **IMPLEMENTED**; proposed owner **Essentials**; effort **S**.

**Behavioral contract.** Preserve still-valid selected item identities when rows rebuild; remove stale selections and retain controller focus.

**First independent slice.** Retain the current selection repair and review edge cases around filtered, nested and virtual views. Add stable focus restoration only where native controller behavior leaves a reproducible gap.

**Ownership and lifecycle.** Local selection and focus only. Preserve identity for surviving visible items; remove destroyed or inaccessible items. No gameplay persistence or network commands.

**Configuration and saves.** Use existing selection feature toggle. Any optional focus preference remains local and must not change which items a bulk gameplay action is permitted to move.

**Acceptance scenarios.** Test sorting, stack expansion, item removal, pane switch, search changes, controller selection and split-screen. A removed item must never remain an actionable hidden selection.

**Cost and blockers.** Low to medium: native row rebuilding and replacement UI hooks. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [3782920935](https://steamcommunity.com/sharedfiles/filedetails/?id=3782920935), [3773985930](https://steamcommunity.com/sharedfiles/filedetails/?id=3773985930).

## 8. Protect favorites and reserved equipment from bulk actions

Impact **88**; coverage **PARTIAL**; proposed owner **Essentials + Quartermaster**; effort **M**.

**Behavioral contract.** Explain and consistently apply protected-item exclusions before transfer, dismantling, consumption or crafting helpers.

**First independent slice.** Document one original eligibility policy across existing key filing, sorting and magazine helpers before exposing new bulk operations. Add an explicit protected-item explanation; do not silently override the native favorite flag.

**Ownership and lifecycle.** For shared mutations the server checks authoritative protection and equipment state at execution. Client marks are advisory unless a validated server policy stores them. Avoid inventing persistent item flags until their native lifecycle is verified.

**Configuration and saves.** Retain existing favorite protection. Propose ProtectEquippedItems=true and an explicit per-operation opt-in override only where server policy allows it. Confirm existing keys to avoid conflicting mirrors.

**Acceptance scenarios.** Mark an item favorite or equip it after preview, retry the request, change character and reconnect. Protected items stay untouched; manual native actions remain available with clear scope.

**Cost and blockers.** High: a client-only exclusion is insufficient for a shared transaction. Native favorite visibility/replication is UNKNOWN until audited; do not label a client preference as an authoritative reservation. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [SortingCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/SortingCore.lua); [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [AutoKeyRing.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/AutoKeyRing.lua); [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3795435563](https://steamcommunity.com/sharedfiles/filedetails/?id=3795435563).

## 9. Make context actions easier to find

Impact **87**; coverage **PARTIAL**; proposed owner **Essentials**; effort **S**.

**Behavioral contract.** Group related actions and retain native callback objects, disabled reasons, tooltips and controller navigation.

**First independent slice.** Retain device and developer grouping. Extend only demonstrably crowded families with an original grouping policy, localized labels and preserved option objects; coordinate overlapping menu providers.

**Ownership and lifecycle.** Local presentation; callbacks and permissions remain the original owners' responsibility. The grouping layer never recreates, elevates or executes callbacks automatically.

**Configuration and saves.** Keep existing menu toggles. Propose one opt-in group policy per meaningful family, not individual option micro-settings. Technical ordering and UI geometry remain internal.

**Acceptance scenarios.** Compare callback target and arguments before and after grouping; test disabled options, nested submenus, tooltip ownership, controller back navigation and duplicate providers.

**Cost and blockers.** Medium: compatibility with mods that mutate the same option objects. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [ContextMenuCleanup.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/ContextMenuCleanup.lua); [DevicePowerMenu.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/DevicePowerMenu.lua); [InventoryActionGrouping.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryActionGrouping.lua). Vanilla groups: context in [API evidence](API_EVIDENCE.md). Discovery: [3780688809](https://steamcommunity.com/sharedfiles/filedetails/?id=3780688809), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [2875848298](https://steamcommunity.com/sharedfiles/filedetails/?id=2875848298), [3554048011](https://steamcommunity.com/sharedfiles/filedetails/?id=3554048011).

## 10. Show container and magazine fill at a glance

Impact **85**; coverage **NEW**; proposed owner **SPXTRM + Essentials**; effort **S**.

**Behavioral contract.** Display capacity and loading state as text plus optional bars without changing weight, capacity or ammunition.

**First independent slice.** Prototype original text plus compact optional fill indicators on native container buttons and magazine rows. Share the read model with SPXTRM; reuse no external art, thresholds or color scheme.

**Ownership and lifecycle.** Local display of already visible weight/capacity and current magazine state. Do not set item or container fields, synchronize an extra count or reveal inaccessible bag contents.

**Configuration and saves.** Propose EnableCapacityIndicators=true, with local text/bar and contrast preferences. A magazine indicator can be toggled as a presentation choice. Never make actual capacity configurable through this feature.

**Acceptance scenarios.** Test zero or unknown capacity, nested bags, weight reduction, overfull containers, empty and mixed magazines, UI scale and color-blind readability. Verify gameplay state is unchanged.

**Cost and blockers.** Low: receiver-specific capacity semantics and overlapping overlays. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [3789660055](https://steamcommunity.com/sharedfiles/filedetails/?id=3789660055), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [3437629766](https://steamcommunity.com/sharedfiles/filedetails/?id=3437629766).

## 11. Show item condition where it is used

Impact **85**; coverage **NEW**; proposed owner **SPXTRM + Essentials**; effort **S**.

**Behavioral contract.** Add readable condition indicators to native item and equipment views using actual visible condition data.

**First independent slice.** Show an original optional numeric or non-color condition cue beside native equipped and inventory entries. Use current visible condition and maximum condition; add a low-condition hint only after thresholds are reviewed.

**Ownership and lifecycle.** Local read model, invalidated by actual item changes. Do not expose hidden mechanical state, modify durability or predict future breakage as a fact.

**Configuration and saves.** Propose EnableConditionIndicators=true; keep display style local. If a meaningful low-condition warning is added, expose a bounded threshold and localized tooltip rather than copying another mod's values.

**Acceptance scenarios.** Test broken, unconditioned, renamed and modded items, hotbar swaps, equipment changes, UI scaling and another overlay mod. Maximum-condition zero and missing APIs must safely hide the cue.

**Cost and blockers.** Low: overlay overlap and different item receiver types. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [HotbarReordering.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/HotbarReordering.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [2852309899](https://steamcommunity.com/sharedfiles/filedetails/?id=2852309899), [3641048285](https://steamcommunity.com/sharedfiles/filedetails/?id=3641048285), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462).

## 12. Inspect nested bags without unpacking

Impact **85**; coverage **FOUNDATION**; proposed owner **Essentials + SPXTRM**; effort **M**.

**Behavioral contract.** Expose accessible nested contents with bounded traversal, source breadcrumbs and cycle protection.

**First independent slice.** Render the existing bounded traversal and stable reference foundation as native-compatible nested inspection with breadcrumbs. First slice remains read-only; transfers use a separately reviewed action path.

**Ownership and lifecycle.** No projected-container ownership or saved contents. Every nested result retains an admitted root and exact path; root removal or failed resolution hides it. Join rebuilds from current game state.

**Configuration and saves.** Reuse traversal depth and item/container budgets. Propose EnableNestedInspection=false until UI and runtime checks pass. No option may bypass locks or make remote roots visible.

**Acceptance scenarios.** Test deep nesting, cycles, duplicate roots, bag removal, permission change, streamed-out vehicle, zero items and budget exhaustion. Explain truncation instead of silently implying full coverage.

**Cost and blockers.** Medium: nested access rules and virtual-pane compatibility. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventoryTraversal.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTraversal.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua); [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [3410947298](https://steamcommunity.com/sharedfiles/filedetails/?id=3410947298), [3465040406](https://steamcommunity.com/sharedfiles/filedetails/?id=3465040406), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562).

## 13. Transfer an exact quantity from a stack

Impact **83**; coverage **NEW**; proposed owner **Essentials**; effort **M**.

**Behavioral contract.** Let a player choose a bounded count and preview eligible real items while vanilla performs each transfer.

**First independent slice.** Add an original bounded count prompt for a selected real-item stack, with an eligible-item preview. Distinguish item count from fluid amount and food portions; the first slice supports whole items only.

**Ownership and lifecycle.** Resolve a finite list of actual item identities; native transfer actions own moves. Shared transfer extensions require the existing authoritative reference service. Never split an item by cloning its fields.

**Configuration and saves.** Propose EnableQuantityTransfer=true; reuse batch limits. Count defaults to one and is bounded by eligible items and server policy. UI step controls remain local.

**Acceptance scenarios.** Test zero/negative/malformed count, mixed items in one displayed stack, favorites, disappearing items, partial capacity, controller entry and another client taking one item mid-queue.

**Cost and blockers.** Medium: displayed stacks are not necessarily homogeneous item objects. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection, batch-transfer.

**Evidence.** [InventoryTransfers.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryTransfers.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Vanilla groups: inventory, actions, context in [API evidence](API_EVIDENCE.md). Discovery: [3422220305](https://steamcommunity.com/sharedfiles/filedetails/?id=3422220305), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462).

## 14. Make food freshness safety and nutrition readable

Impact **82**; coverage **NEW**; proposed owner **Provisions + SPXTRM**; effort **M**.

**Behavioral contract.** Expose only character-permitted freshness, cooking, contamination and nutrition information in native views.

**First independent slice.** Provisions and SPXTRM should supply an original permitted-food read model and small native tooltip/row adapter. Start with vanilla freshness and cooking state; nutrition and contamination require explicit knowledge-policy proof.

**Ownership and lifecycle.** Local display only, reading authoritative native item state already available to this character. No eating, spoilage changes, ingredient transformation or client-owned safety verdict used to bypass server rules.

**Configuration and saves.** Use owning-project sandbox enable policy and local display preferences. Preserve nutrition-related traits and hidden-poison rules. Default to native visibility rather than universal numeric disclosure.

**Acceptance scenarios.** Compare two characters with different knowledge, uncooked-dangerous food, unknown poison, frozen food, modded food and stale network state. Test icons with text fallback and native tooltip parity.

**Cost and blockers.** High: hidden information and food-component semantics. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: food, fluid in [API evidence](API_EVIDENCE.md). Discovery: [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [3490188370](https://steamcommunity.com/sharedfiles/filedetails/?id=3490188370), [3723726293](https://steamcommunity.com/sharedfiles/filedetails/?id=3723726293).

## 15. Separate equipped items from carried clutter

Impact **81**; coverage **IMPLEMENTED**; proposed owner **Essentials + SPXTRM**; effort **S**.

**Behavioral contract.** Present worn held and attached items once while retaining native equip actions and ownership.

**First independent slice.** Retain the current worn/held/attached projection and deferral to compatible standalone providers. Improve missing labels or controller behavior only after inspecting actual conflicts; keep a paper-doll redesign in SPXTRM.

**Ownership and lifecycle.** Read-only local view of native equipment. A worn-and-held item appears once; drag and equip continue through native actions. No new equipment slots or independent-hand combat behavior.

**Configuration and saves.** Keep current Equipped view and carried-filter toggles. Retain safe native fallback if another mod owns the view. UI layout preferences remain local.

**Acceptance scenarios.** Test key rings, two-handed items, holsters, bags, rapid equip changes, split-screen and standalone O.C.D. Inventory. Selection must survive without hiding an actionable equipped item from both views.

**Cost and blockers.** Medium: equipment classifier and replacement-pane compatibility. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** selection.

**Evidence.** [InventoryViews.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventoryViews.lua); [InventorySelectionRepair.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/InventorySelectionRepair.lua); [IndependentHandClassifier.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/IndependentHandClassifier.lua). Vanilla groups: inventory in [API evidence](API_EVIDENCE.md). Discovery: [3773985930](https://steamcommunity.com/sharedfiles/filedetails/?id=3773985930), [3790656296](https://steamcommunity.com/sharedfiles/filedetails/?id=3790656296), [2950902979](https://steamcommunity.com/sharedfiles/filedetails/?id=2950902979), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562).

## 16. Show read watched and useful-media progress

Impact **81**; coverage **IMPLEMENTED**; proposed owner **Essentials**; effort **S**.

**Behavioral contract.** Show native per-character completion and recipe or skill benefits; distinguish carried duplicates from known content.

**First independent slice.** Retain existing literature/media tracking, then verify partial completion, nested carried duplicates and modded reward data. Present original concise text and do not maintain a second knowledge registry.

**Ownership and lifecycle.** Read native per-character pages, known recipes and recorded-media lines. Cache only bounded derived data, invalidating on character and inventory changes. Never mark media learned merely because it is carried.

**Configuration and saves.** Retain existing literature master, duplicate and scan-limit settings. Keep knowledge-respecting defaults; reward-detail display is optional. Existing saves derive progress from vanilla state.

**Acceptance scenarios.** Test partially read books, differently named copies, media with multiple lessons, no reward metadata, nested bags, character switch, reconnect and standalone tracker coexistence.

**Cost and blockers.** Medium: recorded-media identity and knowledge leaks. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [LiteratureCore.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/LiteratureCore.lua); [LiteratureTracking.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/LiteratureTracking.lua). Vanilla groups: media, inventory in [API evidence](API_EVIDENCE.md). Discovery: [2544353492](https://steamcommunity.com/sharedfiles/filedetails/?id=2544353492), [3777800131](https://steamcommunity.com/sharedfiles/filedetails/?id=3777800131), [3716522633](https://steamcommunity.com/sharedfiles/filedetails/?id=3716522633), [3739168410](https://steamcommunity.com/sharedfiles/filedetails/?id=3739168410), [2732294885](https://steamcommunity.com/sharedfiles/filedetails/?id=2732294885).

## 17. Make existing health information easier to inspect

Impact **80**; coverage **NEW**; proposed owner **Health Care + Medical Checks + SPXTRM**; effort **M**.

**Behavioral contract.** Present revealed injuries, bandages and treatment needs without revealing hidden diagnoses or other players' private health.

**First independent slice.** Health Care should own permitted clinical facts, Medical Checks retains examination consent, and SPXTRM owns optional compact presentation. Begin with the local player's already revealed wounds and native treatment availability, not diagnosis through bandages. Verify the current contracts in each repository first.

**Ownership and lifecycle.** Local presentation of permitted personal facts. Inspecting another character requires that project's authoritative authorization and privacy contract. Treatment remains a distinct server-validated native action.

**Configuration and saves.** Owning medical project sets shared visibility policy and any skill threshold. Personal size, contrast and collapse choices remain local. Confirm actual project option identifiers before implementation.

**Acceptance scenarios.** Compare uncovered, covered and undiagnosed injuries across skill levels; test split-screen privacy, medical-check permission denial, reconnect, healing updates and no stale urgent warnings.

**Cost and blockers.** High: medical privacy and skill-gated hidden state. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: health in [API evidence](API_EVIDENCE.md). Discovery: [2866258937](https://steamcommunity.com/sharedfiles/filedetails/?id=2866258937), [3779405481](https://steamcommunity.com/sharedfiles/filedetails/?id=3779405481), [3723726293](https://steamcommunity.com/sharedfiles/filedetails/?id=3723726293).

## 18. Readable configurable survival status and moodles

Impact **80**; coverage **NEW**; proposed owner **SPXTRM**; effort **M**.

**Behavioral contract.** Use optional legible gauges and original explanations for already available personal status; avoid hidden-stat disclosure and replace external dashboards with a Lua-only in-game option.

**First independent slice.** SPXTRM should extend native status and moodle presentation with original explanations and accessible optional gauges. First retain native information granularity; expose additional numeric values only after a visibility-policy decision.

**Ownership and lifecycle.** Local personal status only; no other-player tracking, gameplay mutation or new networking. Clear caches at character changes and rebuild from current native values.

**Configuration and saves.** Owning UI project provides enable policy and local layout, font, contrast and non-color preferences. Do not bypass traits or native uncertainty by default.

**Acceptance scenarios.** Test resolution changes, controller operation, split-screen, disappearing moodles, traits that alter visible information and compatibility with another HUD. Compare shared state before and after use.

**Cost and blockers.** Medium: hidden numeric data and broad HUD replacement overlap. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: status in [API evidence](API_EVIDENCE.md). Discovery: [2867431511](https://steamcommunity.com/sharedfiles/filedetails/?id=2867431511), [3399432867](https://steamcommunity.com/sharedfiles/filedetails/?id=3399432867), [3451167732](https://steamcommunity.com/sharedfiles/filedetails/?id=3451167732), [3776182375](https://steamcommunity.com/sharedfiles/filedetails/?id=3776182375), [3389003300](https://steamcommunity.com/sharedfiles/filedetails/?id=3389003300), [3674800555](https://steamcommunity.com/sharedfiles/filedetails/?id=3674800555), [3395171770](https://steamcommunity.com/sharedfiles/filedetails/?id=3395171770), [3753700423](https://steamcommunity.com/sharedfiles/filedetails/?id=3753700423).

## 19. Return borrowed tools and magazines to their source

Impact **80**; coverage **NEW**; proposed owner **Essentials**; effort **M**.

**Behavioral contract.** Remember an action's temporary source and restore items only when access and ownership still permit it.

**First independent slice.** First audit native Build 42 auto-return coverage and add only a reproduced gap, such as a specific magazine workflow. Store a short-lived origin reference at action start and offer safe return after successful completion.

**Ownership and lifecycle.** Ordinary native transfer paths own movement. Re-resolve original source after the action; if inaccessible, destroyed or full, leave the real item safely carried and report it. No persisted return queue or forced teleport.

**Configuration and saves.** Propose EnableToolReturn=false, ReturnMagazines=true and ReturnTools=true only for verified supported adapters. Protect player-directed equipment changes; no setting forces return into inaccessible storage.

**Acceptance scenarios.** Test interruption, swapped tool, destroyed source, full bag, item consumed or transformed, transfer by another client and reconnect. Never return a replacement item by name or override a manual equip choice.

**Cost and blockers.** High: native auto-return overlap and stale origin references. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection.

**Evidence.** [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua); [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Vanilla groups: actions, inventory in [API evidence](API_EVIDENCE.md). Discovery: [2769706949](https://steamcommunity.com/sharedfiles/filedetails/?id=2769706949), [3793171582](https://steamcommunity.com/sharedfiles/filedetails/?id=3793171582), [2366717227](https://steamcommunity.com/sharedfiles/filedetails/?id=2366717227).

## 20. Search and explain available construction recipes

Impact **78**; coverage **NEW**; proposed owner **SPXTRM + building owners**; effort **M**.

**Behavioral contract.** Search known building choices and explain missing skill, materials and placement constraints without adding structures.

**First independent slice.** Reuse the original query presentation from crafting but audit the native building registry separately. Start with known existing construction entries; retain native placement previews and add no buildable entity definitions.

**Ownership and lifecycle.** Local recipe browsing only. Building placement and material consumption remain on the verified native authority path. No world state is stored by the search feature.

**Configuration and saves.** Owning UI project provides enable policy and local remembered browse options. Knowledge, station, materials, safehouse and construction rules remain authoritative and unchanged.

**Acceptance scenarios.** Test unavailable skills, missing material, blocked placement, floor orientation, mod removal and controller navigation. Removing the UI adapter must leave placed constructions untouched.

**Cost and blockers.** Medium: separate construction registries and third-party buildable variants. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** craft-search, craft-requirements.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: building, craft in [API evidence](API_EVIDENCE.md). Discovery: [3536052310](https://steamcommunity.com/sharedfiles/filedetails/?id=3536052310), [3540503606](https://steamcommunity.com/sharedfiles/filedetails/?id=3540503606).

## 21. Load and unload matching magazines in batches

Impact **78**; coverage **IMPLEMENTED**; proposed owner **Essentials**; effort **S**.

**Behavioral contract.** Queue ordinary magazine actions with finite ammunition reservation and interruption-safe item handling.

**First independent slice.** Retain current native batch loading/unloading and audit ammunition reservation, nested sources and interrupt handling. Add a preview or optional return adapter only after the existing workflow passes dedicated scenarios.

**Ownership and lifecycle.** Native timed actions own ammunition changes. Reserve unique real rounds within a finite client plan, then rely on current execution validation; never set ammo counts directly. Reconnect discards pending work and reads actual magazine state.

**Configuration and saves.** Retain current magazine master, nesting and operation limits. Keep matching restrictions and normal load duration. Any source-return option follows the separately validated tool-return policy.

**Acceptance scenarios.** Test mixed ammunition, partial magazines, nested bags, two clients sharing rounds, interruption during transfer/load, missing magazine and repeated command. Total rounds must be conserved apart from ordinary firing.

**Cost and blockers.** High until native multiplayer action behavior is exercised. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection.

**Evidence.** [BulkMagazines.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/BulkMagazines.lua). Vanilla groups: actions, inventory, magazine in [API evidence](API_EVIDENCE.md). Discovery: [2920899878](https://steamcommunity.com/sharedfiles/filedetails/?id=2920899878), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [3750253491](https://steamcommunity.com/sharedfiles/filedetails/?id=3750253491), [2875848298](https://steamcommunity.com/sharedfiles/filedetails/?id=2875848298).

## 22. Rebindable shortcuts for ordinary item and recipe actions

Impact **78**; coverage **NEW**; proposed owner **SPXTRM + Essentials**; effort **M**.

**Behavioral contract.** Bind explicit native actions to configurable slots and keys, with controller alternatives and no fabricated items.

**First independent slice.** SPXTRM should supply original configurable action slots using native keybinding and controller conventions. First support a small documented set of native item actions; defer automatic build/craft activation until their adapters exist.

**Ownership and lifecycle.** Persist local identifiers and preference data only, never serialized item objects or executable callbacks. Resolve a permitted current item/action on use and delegate gameplay effects to ordinary authority paths.

**Configuration and saves.** Owning UI project provides enable policy, rebindable keys and local slot count within layout limits. Default bindings must avoid native and existing team conflicts; provide a reset action.

**Acceptance scenarios.** Test missing item, duplicate type, removed recipe, key conflict, controller, text entry focus, reconnect and mod removal. An empty slot may display a preference but must never create an item.

**Cost and blockers.** Medium: input conflicts and selecting an unintended same-type item. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** item-protection.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: input, actions, context in [API evidence](API_EVIDENCE.md). Discovery: [3470659758](https://steamcommunity.com/sharedfiles/filedetails/?id=3470659758), [3786918614](https://steamcommunity.com/sharedfiles/filedetails/?id=3786918614).

## 23. Opt-in safe-food reminders and native consumption assistance

Impact **76**; coverage **NEW**; proposed owner **Provisions + Essentials**; effort **L**.

**Behavioral contract.** Offer an eligible carried food and queue a normal eating action only under explicit player policy; preserve knowledge, duration and interruption rules.

**First independent slice.** Provisions owns an original safe-food eligibility read model. Start with a reminder and one explicit native Eat action on a chosen carried item; consider opt-in queuing only after knowledge and server authority are proven. Do not reproduce background instant consumption.

**Ownership and lifecycle.** The native timed eating action owns item depletion and nutrition effects on its established authority path. Recheck item identity, known safety, access, favorite and interruption before execution. Persist preferences only, never a pending consumption instruction or a second nutrition model.

**Configuration and saves.** Owning Provisions project provides server enable policy; default automatic assistance off, protected favorites on, and dangerous or uncertain food excluded. Local reminder visibility is separate from authoritative eligibility. Any trigger threshold must have documented bounds and existing-save defaults.

**Acceptance scenarios.** Test unknown poison, uncooked hazards, frozen and rotten food, interrupted eating, favorite changes, item removal, reconnect and two clients contesting the same item. No action-free eating, unsafe safety inference, duplicate depletion or altered portion arithmetic.

**Cost and blockers.** High: hidden safety information, food effects and accidental action bypass. If knowledge-safe food eligibility cannot be proven, ship reminders and an explicit player-chosen native action only; automated selection remains blocked. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** food-state, item-protection.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: food, actions, inventory in [API evidence](API_EVIDENCE.md). Discovery: [3795435563](https://steamcommunity.com/sharedfiles/filedetails/?id=3795435563).

## 24. Name order and recognize storage containers

Impact **76**; coverage **NEW**; proposed owner **Quartermaster + SPXTRM**; effort **M**.

**Behavioral contract.** Offer original text and icon choices for storage identification and ordering, preserving container identity.

**First independent slice.** Quartermaster and SPXTRM should distinguish local button ordering from shared storage labels. First implement local order and labels over stable identities; separately design authorized shared designation edits with original icons.

**Ownership and lifecycle.** Local presentation order has no custom networking. Shared names/designations need server-owned validation, safehouse checks, persistence and canonical snapshots on join; do not overload an item name with a hidden storage rule.

**Configuration and saves.** Owning storage project sets shared-label edit policy; local order and visual choices use native preferences. Defaults preserve native labels, and reset removes only feature-owned presentation data.

**Acceptance scenarios.** Test two same-name containers, relocation, destruction, rename conflicts, object replacement, save/load, reconnect and another container-order mod. No stale label may target a newly created object at the same coordinates.

**Cost and blockers.** High for shared labels; low to medium for local ordering. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** No new catalog dependency; validate native/current project behavior first.

**Evidence.** [InventoryReferences.lua](../../../Contents/mods/B47ANCEDEssentials/42/media/lua/shared/B47ANCEDEssentials/InventoryReferences.lua). Vanilla groups: inventory, context in [API evidence](API_EVIDENCE.md). Discovery: [3290232938](https://steamcommunity.com/sharedfiles/filedetails/?id=3290232938), [2901962885](https://steamcommunity.com/sharedfiles/filedetails/?id=2901962885), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [2867163008](https://steamcommunity.com/sharedfiles/filedetails/?id=2867163008), [3437629766](https://steamcommunity.com/sharedfiles/filedetails/?id=3437629766).

## 25. Trace recipe dependencies and useful item applications

Impact **76**; coverage **NEW**; proposed owner **SPXTRM**; effort **M**.

**Behavioral contract.** Link known input and output recipes into a bounded navigable reference without auto-crafting or granting recipes.

**First independent slice.** Add an original read-only dependency browser after recipe search is stable. Follow known input/output relationships with explicit alternatives and cycle markers; do not choose or auto-execute a crafting plan.

**Ownership and lifecycle.** Local derived metadata graph only. Knowledge changes and mod removal invalidate nodes. Never cache live item ownership or grant a hidden recipe because a known recipe depends on it.

**Configuration and saves.** Owning UI project offers enable policy and local expansion preference. Keep traversal/node limits internal technical safeguards and show a truncation message rather than promising a complete graph.

**Acceptance scenarios.** Test recipe cycles, multiple producers, fluid requirements, reusable tools, unknown intermediates, mod removal and large registries. Back navigation preserves selection and every craft action still uses the native workflow.

**Cost and blockers.** Medium: recipe graphs can be cyclic, ambiguous and knowledge-sensitive. Dedicated and performance evidence remain open; all shared entry gates apply.

**Dependencies.** craft-search, craft-requirements.

**Evidence.** No implementation claimed in Essentials; inspect the proposed owning repository before creating production files. Vanilla groups: craft in [API evidence](API_EVIDENCE.md). Discovery: [3502080466](https://steamcommunity.com/sharedfiles/filedetails/?id=3502080466).
