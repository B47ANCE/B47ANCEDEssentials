# Vanilla-filtered quality of life ranking

[Portfolio ownership audit](PORTFOLIO_OWNERSHIP.md) corrects project assignments and distinguishes coverage outside Essentials. NEW still means absent from Essentials, not absent from our portfolio. Scores and the top-25 membership are unchanged.

Only current Essentials entries and scoped additions survive this ranking. Native-covered and unproven proposals are removed from it; every prior item is accounted for in [the complete vanilla comparison](VANILLA_RECHECK.md). Scores estimate remaining workflow benefit and are ordinal judgments, not measurements. Equal scores are ties.

| Rank | Remaining workflow | Impact / 100 | Essentials coverage | Native comparison | Owner |
|---:|---|---:|---|---|---|
| 1 | [One view for reachable nearby loot](#nearby-view) | 96 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 2 | [Safe bulk transfer between selected containers](#batch-transfer) | 94 | FOUNDATION | KEEP_EXISTING | Essentials + Quartermaster |
| 3 | [Put loot into designated or seeded storage](#storage-sort) | 92 | PARTIAL | KEEP_EXISTING | Quartermaster + Essentials |
| 4 | [Keep inventory selection through refreshes](#selection) | 89 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 5 | [Protect favorites and reserved equipment from bulk actions](#item-protection) | 88 | PARTIAL | KEEP_EXISTING | Essentials + Quartermaster |
| 6 | [Make context actions easier to find](#context) | 87 | PARTIAL | KEEP_EXISTING | Essentials |
| 7 | [Inspect nested bags without unpacking](#nested-view) | 85 | FOUNDATION | KEEP_EXISTING | Essentials + UI |
| 8 | [Choose an exact whole-item transfer count](#take-quantity) | 83 | NEW | RETAIN_DELTA | Essentials |
| 9 | [Separate equipped items from carried clutter](#equipment-view) | 81 | IMPLEMENTED | KEEP_EXISTING | Essentials + UI |
| 10 | [Show read watched and useful-media progress](#media-progress) | 81 | IMPLEMENTED | KEEP_EXISTING | Essentials + Knowledge & Wisdom |
| 11 | [Compare fill across container buttons and magazine entries](#capacity) | 80 | NEW | RETAIN_DELTA | UI |
| 12 | [Compact local injury summary outside the health panel](#health-readability) | 80 | NEW | RETAIN_DELTA | Health Care + UI |
| 13 | [Load and unload matching magazines in batches](#magazine-batch) | 78 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 14 | [Configurable non-equipment item and recipe action slots](#shortcuts) | 78 | NEW | RETAIN_DELTA | Essentials + UI |
| 15 | [Customize local world-container button presets and order](#container-labels) | 76 | NEW | RETAIN_DELTA | UI |
| 16 | [Choose a safe destination for bulky crafting output](#craft-output) | 74 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 17 | [Arrange hotbar slots without reattaching items](#hotbar) | 74 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 18 | [Show condition directly on hotbar slots](#condition) | 73 | NEW | RETAIN_DELTA | UI |
| 19 | [Preserve a configured default map-symbol scale](#map-annotation) | 72 | PARTIAL | KEEP_EXISTING | Essentials |
| 20 | [Keep device power actions attached to the device](#device-menus) | 71 | IMPLEMENTED | KEEP_EXISTING | Essentials + Power |
| 21 | [Plan a finite vehicle-part service itinerary](#maintenance-queue) | 71 | NEW | RETAIN_DELTA | Essentials |
| 22 | [Queue a chosen eligible unread-book and media playlist](#reading-queue) | 70 | NEW | RETAIN_DELTA | Essentials + Knowledge & Wisdom |
| 23 | [File keys into an eligible carried key ring](#key-filing) | 69 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 24 | [Preview and queue cleanup across a chosen rectangle](#area-clean) | 68 | NEW | RETAIN_DELTA | Auto Clean |
| 25 | [Estimate remaining generator runtime from inspected load](#generator-info) | 68 | NEW | RETAIN_DELTA | Power + UI |
| 26 | [Make partial transfer failures understandable](#transfer-feedback) | 68 | FOUNDATION | KEEP_EXISTING | Essentials + Quartermaster |
| 27 | [Replace an eligible bandage with one request](#bandage-queue) | 66 | NEW | RETAIN_DELTA | Health Care |
| 28 | [Compare revealed care needs across animals in one table](#livestock-table) | 64 | NEW | RETAIN_DELTA | Animal owner TBD + UI |
| 29 | [Mark not-yet-readable media for later without granting knowledge](#personal-marks) | 63 | NEW | RETAIN_DELTA | Essentials |
| 30 | [Independent-hand compatibility classifier foundation](#equipment-swap) | 62 | PARTIAL | KEEP_EXISTING | Essentials |
| 31 | [Restore magazines to their source after native loading](#tool-return) | 62 | NEW | RETAIN_DELTA | Essentials |
| 32 | [Compare per-item and stack weights in a dedicated column](#weight-column) | 62 | NEW | RETAIN_DELTA | UI |
| 33 | [Display available watch time more precisely](#clock) | 59 | IMPLEMENTED | KEEP_EXISTING | Essentials + Power |
| 34 | [Plan treatment over already revealed eligible wounds](#treatment-queue) | 59 | NEW | RETAIN_DELTA | Health Care |
| 35 | [Optional fridge and freezer off control](#device-off) | 56 | NEW | RETAIN_DELTA | Power |
| 36 | [Mark only player-observed locations automatically](#map-automark) | 54 | NEW | RETAIN_DELTA | Essentials |
| 37 | [Queue a chosen multi-window curtain or barricade itinerary](#building-maintenance) | 53 | NEW | RETAIN_DELTA | Essentials + Rooms |
| 38 | [Plan selected-area corpse handling to one destination](#corpse-haul) | 53 | NEW | RETAIN_DELTA | Auto Clean |
| 39 | [Queue native firearm and magazine unloading in one request](#weapon-ammo) | 52 | NEW | RETAIN_DELTA | Essentials |
| 40 | [Queue work over player-selected eligible plots](#crop-queue) | 51 | NEW | RETAIN_DELTA | Harvest |
| 41 | [Heavy-object provider lifecycle foundation](#heavy-movement) | 51 | FOUNDATION | KEEP_EXISTING | Essentials + domain providers |
| 42 | [Queue native care over a player-selected herd list](#animal-queue) | 49 | NEW | RETAIN_DELTA | Animal owner TBD |
| 43 | [Expose valid native ladder interactions](#ladder) | 49 | IMPLEMENTED | KEEP_EXISTING | Essentials |
| 44 | [Optional nonblocking recap at session start](#session-briefing) | 48 | NEW | RETAIN_DELTA | UI |

<a id="nearby-view"></a>
## 1. One view for reachable nearby loot

**Native baseline.** Vanilla discovers individual reachable loot containers and exposes their buttons.

**Remaining scope.** Retain Essentials' admitted-root aggregate; do not replace native discovery or expand reach.

Impact **96/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=5, reach=5, friction=5, error_prevention=4, accessibility=4.

Discovery: [2847184718](https://steamcommunity.com/sharedfiles/filedetails/?id=2847184718), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562). Native comparison groups: inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="batch-transfer"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep the admitted-root nearby projection. Quartermaster can inspect multiple storage targets, but that is not a replacement loot pane.

## 2. Safe bulk transfer between selected containers

**Native baseline.** Vanilla already transfers selected items, all items and matching types with timed actions.

**Remaining scope.** Retain the existing reference/replay/authority foundation; proposed UI is only an explicit multi-source transaction preview and result workflow, not a new Transfer All button.

Impact **94/100**; owner Essentials + Quartermaster; Essentials coverage **FOUNDATION**. Dimensions: frequency=5, reach=5, friction=5, error_prevention=4, accessibility=3.

Discovery: [3422220305](https://steamcommunity.com/sharedfiles/filedetails/?id=3422220305), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3761216758](https://steamcommunity.com/sharedfiles/filedetails/?id=3761216758). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="storage-sort"></a>
**Portfolio coverage.** RELATED_SOURCE. Essentials retains its reference/transaction service. Quartermaster already owns a separate logistics executor. A general explicit preview remains unfinished; do not merge executors or introduce a dependency without a reviewed contract.

## 3. Put loot into designated or seeded storage

**Native baseline.** Native transfers choose a destination; container discovery is not category/seed destination planning.

**Remaining scope.** Retain bounded Essentials seeded sorting; richer shared designation rules remain Quartermaster work.

Impact **92/100**; owner Quartermaster + Essentials; Essentials coverage **PARTIAL**. Dimensions: frequency=5, reach=5, friction=5, error_prevention=4, accessibility=2.

Discovery: [3761216758](https://steamcommunity.com/sharedfiles/filedetails/?id=3761216758), [3807217050](https://steamcommunity.com/sharedfiles/filedetails/?id=3807217050), [3290232938](https://steamcommunity.com/sharedfiles/filedetails/?id=3290232938). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="selection"></a>
**Portfolio coverage.** RELATED_SOURCE. Quartermaster already supplies designated category/item rules, priorities and sorting. Keep current Essentials seeded sorting for standalone use; do not rebuild designation policy. Prevent competing menu actions/plans when both are enabled.

## 4. Keep inventory selection through refreshes

**Native baseline.** Native pane rebuilds and transfer actions maintain their own row/selection state.

**Remaining scope.** Retain Essentials' stable-item selection repair and verify regressions against the native rebuild lifecycle.

Impact **89/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=5, reach=5, friction=4, error_prevention=3, accessibility=4.

Discovery: [3782920935](https://steamcommunity.com/sharedfiles/filedetails/?id=3782920935), [3773985930](https://steamcommunity.com/sharedfiles/filedetails/?id=3773985930). Native comparison groups: inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="item-protection"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep native inventory selection repair here. The UI library has focus helpers, not this inventory integration.

## 5. Protect favorites and reserved equipment from bulk actions

**Native baseline.** Native favorite checks already protect ordinary bulk transfers and some destructive operations.

**Remaining scope.** Retain only consistency and protected-equipment checks in Essentials-owned workflows; do not add a second Favorite feature.

Impact **88/100**; owner Essentials + Quartermaster; Essentials coverage **PARTIAL**. Dimensions: frequency=5, reach=5, friction=3, error_prevention=5, accessibility=4.

Discovery: [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3795435563](https://steamcommunity.com/sharedfiles/filedetails/?id=3795435563). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="context"></a>
**Portfolio coverage.** RELATED_SOURCE. Both executors already check some protected states. Quartermaster SupplyAPI checks favorites, equipped/attached and crafting-consumed items. Define interoperability for active reservations; no portfolio-wide protection API is established.

## 6. Make context actions easier to find

**Native baseline.** Vanilla has submenus, disabled reasons and native option callbacks.

**Remaining scope.** Retain Essentials device/developer grouping; no wholesale context-menu replacement.

Impact **87/100**; owner Essentials; Essentials coverage **PARTIAL**. Dimensions: frequency=5, reach=5, friction=4, error_prevention=3, accessibility=3.

Discovery: [3780688809](https://steamcommunity.com/sharedfiles/filedetails/?id=3780688809), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [2875848298](https://steamcommunity.com/sharedfiles/filedetails/?id=2875848298), [3554048011](https://steamcommunity.com/sharedfiles/filedetails/?id=3554048011). Native comparison groups: inventory, world, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="nested-view"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep native context grouping here. Domain callbacks and validation remain with their owning mods; UI may supply reusable controls.

## 7. Inspect nested bags without unpacking

**Native baseline.** Vanilla exposes equipped carried bags and bags in admitted vehicle/world roots; native recursive queries are not a recursive browsing UI.

**Remaining scope.** Retain bounded stable-reference traversal foundation; a future UI is limited to deeper accessible nested inspection with breadcrumbs.

Impact **85/100**; owner Essentials + UI; Essentials coverage **FOUNDATION**. Dimensions: frequency=5, reach=5, friction=4, error_prevention=3, accessibility=2.

Discovery: [3410947298](https://steamcommunity.com/sharedfiles/filedetails/?id=3410947298), [3465040406](https://steamcommunity.com/sharedfiles/filedetails/?id=3465040406), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562). Native comparison groups: inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="take-quantity"></a>
**Portfolio coverage.** RELATED_SOURCE. Essentials has traversal and nested stable references, while Quartermaster has selected nested-bag logistics. Neither establishes the proposed finished nested browser. Keep the read model in Essentials; UI may render controls.

## 8. Choose an exact whole-item transfer count

**Native baseline.** The reviewed grab menu offers one, half and all for a selected stack.

**Remaining scope.** Keep a whole-item exact-count prompt, excluding existing one/half/all choices and fluid portions.

Impact **83/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=4, reach=5, friction=4, error_prevention=4, accessibility=3.

Discovery: [3422220305](https://steamcommunity.com/sharedfiles/filedetails/?id=3422220305), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="equipment-view"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Exact whole-item count selection belongs with inventory workflows. Quartermaster shopping target quantities are not the same native inventory transfer dialog.

## 9. Separate equipped items from carried clutter

**Native baseline.** Vanilla marks equipped rows and exposes equipment controls.

**Remaining scope.** Retain Essentials' separate worn/held/attached projection and general-list filtering; no new equipment slots.

Impact **81/100**; owner Essentials + UI; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=5, friction=4, error_prevention=3, accessibility=3.

Discovery: [3773985930](https://steamcommunity.com/sharedfiles/filedetails/?id=3773985930), [3790656296](https://steamcommunity.com/sharedfiles/filedetails/?id=3790656296), [2950902979](https://steamcommunity.com/sharedfiles/filedetails/?id=2950902979), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562). Native comparison groups: inventory, hotbar. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="media-progress"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. The Equipped view is already in Essentials. UI can provide presentation helpers; SPXTRM owns light attachments only and must not own this inventory pane.

## 10. Show read watched and useful-media progress

**Native baseline.** Native inventory already tests read literature and stores per-character page/media progress.

**Remaining scope.** Retain Essentials' carried-duplicate and reward context integration; existing source remains included even where native indicators overlap.

Impact **81/100**; owner Essentials + Knowledge & Wisdom; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=5, friction=4, error_prevention=4, accessibility=2.

Discovery: [2544353492](https://steamcommunity.com/sharedfiles/filedetails/?id=2544353492), [3777800131](https://steamcommunity.com/sharedfiles/filedetails/?id=3777800131), [3716522633](https://steamcommunity.com/sharedfiles/filedetails/?id=3716522633), [3739168410](https://steamcommunity.com/sharedfiles/filedetails/?id=3739168410), [2732294885](https://steamcommunity.com/sharedfiles/filedetails/?id=2732294885). Native comparison groups: inventory, media. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="capacity"></a>
**Portfolio coverage.** RELATED_SOURCE. Keep existing menu progress and carried-duplicate hints in Essentials. Knowledge & Wisdom already supplies bounded recorded-media inspection and owns custom knowledge/research. Do not create a second knowledge ledger; any optional adapter remains unimplemented.

## 11. Compare fill across container buttons and magazine entries

**Native baseline.** The selected inventory header already shows weight/capacity; magazine counts are available through native interactions.

**Remaining scope.** Only simultaneous fill cues on container buttons and detachable-magazine entries remain; no new capacity or ammo information is claimed.

Impact **80/100**; owner UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=4, accessibility=4.

Discovery: [3789660055](https://steamcommunity.com/sharedfiles/filedetails/?id=3789660055), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [3437629766](https://steamcommunity.com/sharedfiles/filedetails/?id=3437629766). Native comparison groups: inventory, hotbar. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="health-readability"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Simultaneous container-button and magazine fill cues fit planned vanilla presentation adapters. UI has reusable controls but no implemented overlay. Essentials can supply permitted inventory views.

## 12. Compact local injury summary outside the health panel

**Native baseline.** Vanilla already has body-part injuries, bandage details and treatment handlers in the health panel.

**Remaining scope.** Only an optional compact local injury summary outside the full panel remains; no new diagnosis, hidden wound or other-player detail.

Impact **80/100**; owner Health Care + UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=4, accessibility=4.

Discovery: [2866258937](https://steamcommunity.com/sharedfiles/filedetails/?id=2866258937), [3779405481](https://steamcommunity.com/sharedfiles/filedetails/?id=3779405481), [3723726293](https://steamcommunity.com/sharedfiles/filedetails/?id=3723726293). Native comparison groups: health. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="magazine-batch"></a>
**Portfolio coverage.** RELATED_SOURCE. Health Care has examination reports and an examiner/patient-scoped five-minute snapshot, not a live injury HUD. Put medical visibility/meaning there and rendering in UI. Medical Checks supplies no enforcing consent service today.

## 13. Load and unload matching magazines in batches

**Native baseline.** Native magazine menu loads/unloads the selected magazine through native timed actions.

**Remaining scope.** Retain existing matching-magazine batching and reservation checks; no direct ammunition setters.

Impact **78/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=3, accessibility=4.

Discovery: [2920899878](https://steamcommunity.com/sharedfiles/filedetails/?id=2920899878), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [3750253491](https://steamcommunity.com/sharedfiles/filedetails/?id=3750253491), [2875848298](https://steamcommunity.com/sharedfiles/filedetails/?id=2875848298). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="shortcuts"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep existing matching-magazine native action orchestration. Power and SPXTRM do not own firearm ammunition.

## 14. Configurable non-equipment item and recipe action slots

**Native baseline.** Native hotbar/keybindings expose equipment and predefined actions.

**Remaining scope.** Only configurable item-action and known-recipe shortcut slots beyond native equipment hotkeys remain.

Impact **78/100**; owner Essentials + UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=2, accessibility=5.

Discovery: [3470659758](https://steamcommunity.com/sharedfiles/filedetails/?id=3470659758), [3786918614](https://steamcommunity.com/sharedfiles/filedetails/?id=3786918614). Native comparison groups: options, hotbar, craft. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="container-labels"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Essentials owns ordinary item/recipe invocation and validation; UI can render/configure slots. PC Framework apps are world-computer applications, not global survivor action shortcuts.

## 15. Customize local world-container button presets and order

**Native baseline.** Vanilla names bag buttons from items, selects built-in container icons and persists ordinary window layout.

**Remaining scope.** Only local world-container button label/icon/order presets remain; remove ordinary bag renaming and native window persistence.

Impact **76/100**; owner UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=2, accessibility=4.

Discovery: [3290232938](https://steamcommunity.com/sharedfiles/filedetails/?id=3290232938), [2901962885](https://steamcommunity.com/sharedfiles/filedetails/?id=2901962885), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [2867163008](https://steamcommunity.com/sharedfiles/filedetails/?id=2867163008), [3437629766](https://steamcommunity.com/sharedfiles/filedetails/?id=3437629766). Native comparison groups: inventory, layout. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="craft-output"></a>
**Portfolio coverage.** RELATED_SOURCE. Local button label/icon/order presets belong to UI presentation. Quartermaster storage presets/rules and Rooms room names already exist but are different data. Displaying a label must not create a designation or edit shared names.

## 16. Choose a safe destination for bulky crafting output

**Native baseline.** Vanilla crafting owns output creation and item consumption.

**Remaining scope.** Retain the current approved plank/heavy-output routing adapter, subject to authoritative output and capacity rules.

Impact **74/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=5, friction=3, error_prevention=2, accessibility=3.

Discovery: [3782291042](https://steamcommunity.com/sharedfiles/filedetails/?id=3782291042), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462). Native comparison groups: craft, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="hotbar"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep existing native craft-output routing. Junk Drawer owns salvage outcomes and Provisions owns food-process outcomes; do not intercept or redirect their custom transactions without an explicit provider contract.

## 17. Arrange hotbar slots without reattaching items

**Native baseline.** Native hotbar supports attaching, removing and activating equipment slots.

**Remaining scope.** Retain Essentials' slot-order swaps preserving attached-item indices.

Impact **74/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=4, friction=4, error_prevention=3, accessibility=2.

Discovery: [3663625294](https://steamcommunity.com/sharedfiles/filedetails/?id=3663625294), [2903771337](https://steamcommunity.com/sharedfiles/filedetails/?id=2903771337), [3461263912](https://steamcommunity.com/sharedfiles/filedetails/?id=3461263912). Native comparison groups: hotbar. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="condition"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep current slot reordering and saved attachment-index handling. Shared styling can use UI.

## 18. Show condition directly on hotbar slots

**Native baseline.** Native inventory details already draw weapon-condition bars. The reviewed hotbar render draws slots, textures and equipped marks without a condition cue.

**Remaining scope.** Keep only an optional hotbar-slot condition cue. Remove duplicate inventory condition rendering.

Impact **73/100**; owner UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=4, friction=3, error_prevention=4, accessibility=3.

Discovery: [2852309899](https://steamcommunity.com/sharedfiles/filedetails/?id=2852309899), [3641048285](https://steamcommunity.com/sharedfiles/filedetails/?id=3641048285), [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462). Native comparison groups: inventory, hotbar. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="map-annotation"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Hotbar-only condition display is a planned vanilla UI adapter. Eyewear already displays its own retainer durability, which does not cover general hotbar condition.

## 19. Preserve a configured default map-symbol scale

**Native baseline.** Native maps already have notes, symbols, sharing and scale controls.

**Remaining scope.** Retain only Essentials' configured default symbol scale; no new notes/symbol editor or copied symbol pack.

Impact **72/100**; owner Essentials; Essentials coverage **PARTIAL**. Dimensions: frequency=4, reach=4, friction=4, error_prevention=3, accessibility=1.

Discovery: [3020323164](https://steamcommunity.com/sharedfiles/filedetails/?id=3020323164), [3399645148](https://steamcommunity.com/sharedfiles/filedetails/?id=3399645148), [3395592779](https://steamcommunity.com/sharedfiles/filedetails/?id=3395592779), [2734705913](https://steamcommunity.com/sharedfiles/filedetails/?id=2734705913), [2804531012](https://steamcommunity.com/sharedfiles/filedetails/?id=2804531012). Native comparison groups: maps. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="device-menus"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep the current default-symbol-scale behavior. Rooms designation editing and SPXTRM optical rendering are different systems.

## 20. Keep device power actions attached to the device

**Native baseline.** Native devices already have battery, power and media actions.

**Remaining scope.** Retain current device-owned grouping and optional-provider duplicate suppression, not new electricity/device ownership.

Impact **71/100**; owner Essentials + Power; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=4, friction=3, error_prevention=3, accessibility=3.

Discovery: [3781012462](https://steamcommunity.com/sharedfiles/filedetails/?id=3781012462), [3420581050](https://steamcommunity.com/sharedfiles/filedetails/?id=3420581050). Native comparison groups: radio, inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="maintenance-queue"></a>
**Portfolio coverage.** RELATED_SOURCE. Keep grouping in Essentials and battery transactions in Power; light-specific servicing belongs to SPXTRM. Essentials still probes legacy powerWorks globals/imports, while renamed Power has no legacy aliases: current pairing requires a compatibility repair and tests.

## 21. Plan a finite vehicle-part service itinerary

**Native baseline.** Native mechanics offers part-specific servicing and ordinary queued actions.

**Remaining scope.** Keep an explicit finite vehicle-part service itinerary with skip reasons and tool return; exclude generic repair menus and repeated XP-training loops.

Impact **71/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=4, reach=4, friction=3, error_prevention=4, accessibility=2.

Discovery: [3387539308](https://steamcommunity.com/sharedfiles/filedetails/?id=3387539308), [3635856965](https://steamcommunity.com/sharedfiles/filedetails/?id=3635856965), [3388183573](https://steamcommunity.com/sharedfiles/filedetails/?id=3388183573), [3522680786](https://steamcommunity.com/sharedfiles/filedetails/?id=3522680786), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134). Native comparison groups: vehicle, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="reading-queue"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. No general vehicle-service owner was identified. A finite vanilla vehicle-part itinerary fits Essentials. CAT construction machinery qualification and Eyewear retainers do not cover ordinary mechanics. Scope excludes clothing queues.

## 22. Queue a chosen eligible unread-book and media playlist

**Native baseline.** Native reading processes one selected book and tracks pages.

**Remaining scope.** Keep an explicitly selected eligible unread-book/media playlist with return and interruption; no new reading/progress engine.

Impact **70/100**; owner Essentials + Knowledge & Wisdom; Essentials coverage **NEW**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=4, accessibility=4.

Discovery: [3393291384](https://steamcommunity.com/sharedfiles/filedetails/?id=3393291384), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [3777800131](https://steamcommunity.com/sharedfiles/filedetails/?id=3777800131). Native comparison groups: media, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="key-filing"></a>
**Portfolio coverage.** RELATED_SOURCE. Essentials may orchestrate native reading; Knowledge & Wisdom owns provider documents, completion and knowledge requirements. A finished reading/media playlist was not found. Preserve its MP authority guard; start only with a proven native reading slice.

## 23. File keys into an eligible carried key ring

**Native baseline.** Native menus already transfer keys into recognized key rings.

**Remaining scope.** Retain Essentials' bounded automatic filing via native transfers, not another manual Move To Ring menu.

Impact **69/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=4, friction=3, error_prevention=4, accessibility=1.

Discovery: [3765689485](https://steamcommunity.com/sharedfiles/filedetails/?id=3765689485). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="area-clean"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep current key/ring predicates and native transfers. Quartermaster storage/shopping rules are not a key-ring replacement.

## 24. Preview and queue cleanup across a chosen rectangle

**Native baseline.** Vanilla provides target-specific cleanup actions and some area-affecting actions.

**Remaining scope.** Keep a player-drawn bounded cleanup target plan, eligible-target preview and finite itinerary across that selection; no global scan or speed boost.

Impact **68/100**; owner Auto Clean; Essentials coverage **NEW**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=4, accessibility=3.

Discovery: [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [3820151540](https://steamcommunity.com/sharedfiles/filedetails/?id=3820151540). Native comparison groups: world, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="generator-info"></a>
**Portfolio coverage.** COVERED_SOURCE. Already covered by Auto Clean rectangle/paint/erase/floor selection, confirmation, building cleanup, guarded actions and tool returns. Remove duplicate implementation work from Essentials. Validate or improve the existing Auto Clean workflow in its own repository.

## 25. Estimate remaining generator runtime from inspected load

**Native baseline.** Native generator info already shows fuel, condition, powered items and total draw.

**Remaining scope.** Only a clearly labeled remaining-runtime estimate under current measured load remains; remove duplicate fuel/load/device lists and unproven range rendering.

Impact **68/100**; owner Power + UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=4, accessibility=3.

Discovery: [3576056135](https://steamcommunity.com/sharedfiles/filedetails/?id=3576056135), [2972289937](https://steamcommunity.com/sharedfiles/filedetails/?id=2972289937). Native comparison groups: generator. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="transfer-feedback"></a>
**Portfolio coverage.** FOUNDATION_ONLY. Power already reports loaded generator fuel, condition, activation, connection and native consumption. A remaining-runtime estimate is not implemented in that adapter; keep calculation/units with Power and optional presentation with UI. Electrical output capacity remains unknown.

## 26. Make partial transfer failures understandable

**Native baseline.** Native transfers perform valid moves and handle access/capacity failures.

**Remaining scope.** Retain the existing Essentials committed/skipped/stale transaction result foundation; no independent inventory ownership.

Impact **68/100**; owner Essentials + Quartermaster; Essentials coverage **FOUNDATION**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=3, accessibility=4.

Discovery: [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562), [3761216758](https://steamcommunity.com/sharedfiles/filedetails/?id=3761216758). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="bandage-queue"></a>
**Portfolio coverage.** RELATED_SOURCE. Essentials exposes committed result snapshots; Quartermaster has progress, rejection and partial-outcome presentation. Reuse each executor result contract. A common result vocabulary may be specified, but is not currently a shared implemented API.

## 27. Replace an eligible bandage with one request

**Native baseline.** Native health handlers remove and apply bandages as separate actions.

**Remaining scope.** Keep one explicit replace request chaining those actions with revalidation; no new treatment effect or hidden diagnosis.

Impact **66/100**; owner Health Care; Essentials coverage **NEW**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=3, accessibility=3.

Discovery: [2944344655](https://steamcommunity.com/sharedfiles/filedetails/?id=2944344655), [3750253491](https://steamcommunity.com/sharedfiles/filedetails/?id=3750253491), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134), [2875848298](https://steamcommunity.com/sharedfiles/filedetails/?id=2875848298). Native comparison groups: health, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="livestock-table"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. One-request replace-bandage sequencing belongs to medical procedure ownership, with native action guards. Medical Checks is a blocked consent scaffold, not a treatment engine.

## 28. Compare revealed care needs across animals in one table

**Native baseline.** Native zone panel lists animals and opens an individual animal info action.

**Remaining scope.** Only a sortable cross-animal care comparison table with the same revealed facts remains; no new animal knowledge or care mechanics.

Impact **64/100**; owner Animal owner TBD + UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=2, friction=4, error_prevention=3, accessibility=2.

Discovery: [3783623999](https://steamcommunity.com/sharedfiles/filedetails/?id=3783623999), [3723726293](https://steamcommunity.com/sharedfiles/filedetails/?id=3723726293). Native comparison groups: animals. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="personal-marks"></a>
**Portfolio coverage.** OWNER_UNASSIGNED. No general livestock owner was identified among these projects. Dog Training is canine-specific and not a deployed herd-care provider. Keep a neutral read-only proposal; do not silently expand Dog Training or Harvest scope.

## 29. Mark not-yet-readable media for later without granting knowledge

**Native baseline.** Native favorites and native learned/read state already exist.

**Remaining scope.** Only separate local seen-for-later notes on not-yet-readable media remain, without setting Favorite or granting read knowledge.

Impact **63/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=4, reach=2, friction=3, error_prevention=4, accessibility=3.

Discovery: [2544353492](https://steamcommunity.com/sharedfiles/filedetails/?id=2544353492), [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562). Native comparison groups: inventory, media. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="equipment-swap"></a>
**Portfolio coverage.** RELATED_SOURCE. Local seen-for-later media notes fit Essentials. Quartermaster Dibs personal item labels/Wanted/Needed lists overlap in intent, but do not prove an unreadability-aware media bookmark. Integrate optionally rather than duplicate shopping or knowledge ledgers.

## 30. Independent-hand compatibility classifier foundation

**Native baseline.** Vanilla already equips primary/secondary items and switches attached equipment.

**Remaining scope.** Keep only Essentials' existing independent-hand classifier foundation. It does not implement new swaps, off-hand attacks or dual wielding.

Impact **62/100**; owner Essentials; Essentials coverage **PARTIAL**. Dimensions: frequency=4, reach=2, friction=4, error_prevention=3, accessibility=1.

Discovery: [2366717227](https://steamcommunity.com/sharedfiles/filedetails/?id=2366717227), [3786918614](https://steamcommunity.com/sharedfiles/filedetails/?id=3786918614), [3771638611](https://steamcommunity.com/sharedfiles/filedetails/?id=3771638611). Native comparison groups: hotbar, inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="tool-return"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep only current independent-hand classifier foundation. It supplies no off-hand attacks, animations or finished swapping workflow. Eyewear protection and SPXTRM light mounts have separate ownership.

## 31. Restore magazines to their source after native loading

**Native baseline.** Native crafting explicitly returns borrowed items; magazine load/unload menu paths do not call that return helper.

**Remaining scope.** Keep only optional magazine source restoration after a verified load/unload action. Remove generic tool-return replacement.

Impact **62/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=3, reach=3, friction=3, error_prevention=4, accessibility=3.

Discovery: [2769706949](https://steamcommunity.com/sharedfiles/filedetails/?id=2769706949), [3793171582](https://steamcommunity.com/sharedfiles/filedetails/?id=3793171582), [2366717227](https://steamcommunity.com/sharedfiles/filedetails/?id=2366717227). Native comparison groups: toolreturn, inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="weight-column"></a>
**Portfolio coverage.** RELATED_SOURCE. The retained delta is magazine source restoration only. Auto Clean already returns its borrowed cleaning equipment through its own job/SupplyAPI contract; generic crafting returns are vanilla and stay excluded.

## 32. Compare per-item and stack weights in a dedicated column

**Native baseline.** Native header shows selected-container weight/capacity and inventory supports weight sorting.

**Remaining scope.** Only an optional simultaneously visible per-row individual/stack weight column remains; no new weight calculation or carrying capacity.

Impact **62/100**; owner UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=3, friction=3, error_prevention=2, accessibility=2.

Discovery: [3586216562](https://steamcommunity.com/sharedfiles/filedetails/?id=3586216562). Native comparison groups: inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="clock"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Optional simultaneous per-item/stack weight columns fit vanilla UI adapters. Quartermaster carry budgets govern logistics, not a general native inventory column.

## 33. Display available watch time more precisely

**Native baseline.** Native watch display supplies device-dependent time information.

**Remaining scope.** Retain current Essentials exact-minute formatting and device precision constraints; native rendering comparison remains a runtime gate.

Impact **59/100**; owner Essentials + Power; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=1, friction=4, error_prevention=2, accessibility=3.

Discovery: [3778884296](https://steamcommunity.com/sharedfiles/filedetails/?id=3778884296). Native comparison groups: options, inventory. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="treatment-queue"></a>
**Portfolio coverage.** RELATED_SOURCE. Essentials owns exact-minute formatting; Power owns powered watches, cell charge and mechanical/digital device distinctions. Current legacy namespace integration needs review; neither project should invent hidden watch information.

## 34. Plan treatment over already revealed eligible wounds

**Native baseline.** Vanilla treats individual selected body parts with separate native handlers.

**Remaining scope.** Keep an explicit finite treatment plan across already revealed wounds, with patient consent and per-step revalidation.

Impact **59/100**; owner Health Care; Essentials coverage **NEW**. Dimensions: frequency=4, reach=2, friction=3, error_prevention=2, accessibility=3.

Discovery: [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134). Native comparison groups: health, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="device-off"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Finite treatment plans belong to Health Care. Its reservation/procedure framework is related foundation, not a finished wound itinerary. Do not use inactive Medical Checks preferences as valid consent.

## 35. Optional fridge and freezer off control

**Native baseline.** Native stoves, washers and radios already expose their own power toggles.

**Remaining scope.** Only a reviewed fridge/freezer-specific off toggle remains a candidate; other powered-device toggles are baseline and no parallel power simulation is proposed.

Impact **56/100**; owner Power; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=3, error_prevention=3, accessibility=3.

Discovery: [3778868211](https://steamcommunity.com/sharedfiles/filedetails/?id=3778868211). Native comparison groups: world, radio. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="map-automark"></a>
**Portfolio coverage.** FOUNDATION_ONLY. Power infrastructure/appliance registries are related foundation. No implemented fridge/freezer off toggle is established by the reviewed adapter/API/docs. Provisions can consume real appliance state; it should not own a competing electrical simulation.

## 36. Mark only player-observed locations automatically

**Native baseline.** Native maps support manually authored marks and known-data display.

**Remaining scope.** Only opt-in rate-limited marks from actual permitted observations remain, using native notes and no unexplored-world scan.

Impact **54/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=3, error_prevention=2, accessibility=3.

Discovery: [3782332412](https://steamcommunity.com/sharedfiles/filedetails/?id=3782332412). Native comparison groups: maps, world. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="building-maintenance"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Observed-only native map annotation fits Essentials. Knowledge & Wisdom geographic familiarity and Rooms designations are separate facts and must not reveal unobserved world state. UI may style controls.

## 37. Queue a chosen multi-window curtain or barricade itinerary

**Native baseline.** Native windows, curtains and barricades have valid single-target actions.

**Remaining scope.** Keep only a bounded player-selected multi-target itinerary, not new barricade/window actions or changed material cost.

Impact **53/100**; owner Essentials + Rooms; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=4, accessibility=3.

Discovery: [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745). Native comparison groups: world, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="corpse-haul"></a>
**Portfolio coverage.** FOUNDATION_ONLY. Essentials may orchestrate player-selected vanilla curtain/barricade actions. Rooms can supply explicit permitted geometry only through a reviewed adapter; its existing API explicitly does not enforce unrelated doors/building/destruction actions. Fences & Gates owns its added construction content.

## 38. Plan selected-area corpse handling to one destination

**Native baseline.** Vanilla already permits ordinary corpse handling and its constraints.

**Remaining scope.** Keep only selected-source-area to chosen-destination planning with native carry/drag actions; no faster dragging or teleportation.

Impact **53/100**; owner Auto Clean; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=3, accessibility=4.

Discovery: [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745). Native comparison groups: world, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="weapon-ammo"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. Selected-area corpse handling is an Auto Clean extension candidate, not current trash cleanup. Corpses must use native handling and exact identities; Health Care recovers body parts and MORTIS supplies anatomy/provenance, neither is a hauling planner.

## 39. Queue native firearm and magazine unloading in one request

**Native baseline.** Native unload magazine and firearm actions are separate and gated by current state.

**Remaining scope.** Only a one-request finite native unload-magazine/chamber sequence remains; no new instant extraction or count setters.

Impact **52/100**; owner Essentials; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=3, error_prevention=2, accessibility=2.

Discovery: [3422220305](https://steamcommunity.com/sharedfiles/filedetails/?id=3422220305). Native comparison groups: inventory, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="crop-queue"></a>
**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. A finite native firearm/magazine unloading sequence belongs with existing magazine workflows. Do not introduce instant extraction or modify ammunition counts directly.

## 40. Queue work over player-selected eligible plots

**Native baseline.** Native farming menus already plant, water and harvest selected targets.

**Remaining scope.** Keep only an explicit bounded player-selected plot itinerary with existing season/tool/water constraints.

Impact **51/100**; owner Harvest; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=4, accessibility=2.

Discovery: [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745), [3777237134](https://steamcommunity.com/sharedfiles/filedetails/?id=3777237134). Native comparison groups: farm, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="heavy-movement"></a>
**Portfolio coverage.** FOUNDATION_ONLY. Harvest owns crops, bounded field inspection and crop-side irrigation. A selected-plot planting/watering/harvest itinerary is not implemented. Waterworks owns real water withdrawal/quality; atomic cross-owner delivery remains incomplete.

## 41. Heavy-object provider lifecycle foundation

**Native baseline.** Vanilla moveable/placement systems own supported movement and collision.

**Remaining scope.** Retain Essentials' provider observation and reserve/start/complete/cancel foundation only; no production physics provider is claimed.

Impact **51/100**; owner Essentials + domain providers; Essentials coverage **FOUNDATION**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=3, accessibility=3.

Discovery: [3781319724](https://steamcommunity.com/sharedfiles/filedetails/?id=3781319724), [3805553089](https://steamcommunity.com/sharedfiles/filedetails/?id=3805553089), [3781716360](https://steamcommunity.com/sharedfiles/filedetails/?id=3781716360). Native comparison groups: placement, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="animal-queue"></a>
**Portfolio coverage.** RELATED_SOURCE. Keep generic capability/lifecycle foundation in Essentials. Quartermaster already owns carry logistics; Earthworks/CAT own terrain/machine/wheelbarrow state. No generic physics provider is established and the experimental Earthworks wheelbarrow is SP-only.

## 42. Queue native care over a player-selected herd list

**Native baseline.** Native animal menus perform individual care actions and zone UI opens individual inspections.

**Remaining scope.** Keep only a selected finite herd-care itinerary using revealed eligible targets and native actions.

Impact **49/100**; owner Animal owner TBD; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=4, accessibility=1.

Discovery: [3793163745](https://steamcommunity.com/sharedfiles/filedetails/?id=3793163745), [3783623999](https://steamcommunity.com/sharedfiles/filedetails/?id=3783623999). Native comparison groups: animals, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="ladder"></a>
**Portfolio coverage.** OWNER_UNASSIGNED. No general herd-care owner was identified. Dog Training owns canine-specific tasks and remains blocked on native ownership/persistence. Do not create client-authoritative animal jobs or treat crop irrigation as animal care.

## 43. Expose valid native ladder interactions

**Native baseline.** Native traversal states support climbing; their presence is not an automatic property-based ladder context adapter.

**Remaining scope.** Retain the current tagged-tile native-transition adapter and landing/access safety.

Impact **49/100**; owner Essentials; Essentials coverage **IMPLEMENTED**. Dimensions: frequency=4, reach=1, friction=2, error_prevention=3, accessibility=2.

Discovery: [3629835761](https://steamcommunity.com/sharedfiles/filedetails/?id=3629835761). Native comparison groups: world, actions. Installed publisher declarations are not proof of native absence or runtime behavior.

<a id="session-briefing"></a>
**Portfolio coverage.** EXISTING_ESSENTIALS. Keep the tagged-tile native-transition adapter. Earthworks owns its excavation/climb affordances and Fences & Gates owns construction content; do not replace either domain state with a generic traversal engine.

## 44. Optional nonblocking recap at session start

**Native baseline.** Native panels already contain personal session facts.

**Remaining scope.** Only an original optional brief nonblocking start-of-session recap remains, without copying presentation themes or adding hidden coordinates.

Impact **48/100**; owner UI; Essentials coverage **NEW**. Dimensions: frequency=4, reach=1, friction=1, error_prevention=3, accessibility=4.

Discovery: [3808944882](https://steamcommunity.com/sharedfiles/filedetails/?id=3808944882). Native comparison groups: character, options. Installed publisher declarations are not proof of native absence or runtime behavior.

**Portfolio coverage.** NOT_FOUND_IN_REVIEWED_SCOPE. A nonblocking recap fits UI presentation. Domain providers retain data permissions, age/completeness and provenance; Knowledge & Wisdom history is not a live omniscient session report.
