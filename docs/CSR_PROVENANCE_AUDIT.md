# EXT-36 — CSR Fundamentals provenance and duplicate-handler audit

Audit date: 2026-09-05  
Reference: inactive `CSRFundamentals` 0.2.1, Build 42.20.0 minimum  
Current target: `B47ANCEDEssentials` 0.9.1, Build 42.20.3 minimum

## Result

Do not migrate or reactivate CSR Fundamentals as an B47ANCEDEssentials subsystem. Only
four behavior areas materially overlap current B47ANCEDEssentials code: automatic key
filing, magazine batch actions, saw/craft output routing, and device context-menu
actions. Even these are not proven state- or configuration-equivalent. The other
CSR behaviors belong to domain owners, remain unowned, or are unsafe compatibility
shields. No automatic configuration migration is justified.

One local Sandbox save, `2026-08-27_07-15-02`, records both `CSRFundamentals` and
`CommonSenseReborn` as enabled; it does not list `B47ANCEDEssentials`. This proves real
historical activation but not individual option values or persisted gameplay
state. Binary save data was not interpreted and no save was modified.

## Clean-room boundary

The inactive source was inspected to identify behavior, configuration identity,
event surfaces, mutation ownership, and collision risk. No code, constants,
balance, text, item definitions, assets, data tables, or implementation structure
is copied. File and option names below are provenance identifiers only.

## Disposition vocabulary

- **Current owner**: an existing Works project already has the relevant domain.
- **Candidate owner**: domain fit only; requires a separate approved feature and
  current Build reproduction before implementation.
- **Retired**: no supported first-party implementation is planned from this audit.
- **Denied**: behavior is explicitly unsafe and must not be recreated.
- **Overlap**: enabling both runtimes can add duplicate menu/event/override paths.

## Behavior matrix

Every shipped feature gate in `CSR_FeatureFlags.lua`, every sandbox behavior, and
the ungated compatibility modules are represented below. Numeric multipliers and
capacities share their parent behavior's disposition; their old values are not
migration inputs.

| CSR behavior / settings | Present owner or implementation | Save/config disposition | Duplicate-hook risk / decision |
| --- | --- | --- | --- |
| Entry actions master; pry doors/windows | None | Retain old data untouched | High world-menu/server-command risk; retired pending a reproduced B42 defect/use-case |
| Screwdriver lockpick | None | Retain | Same entry menu and timed-action surface; retired |
| Bolt cutting; fence cutting | None | Retain | Same entry context and object mutation; candidate B47ANCEDEssentials only through a future canonical-action contract |
| Vehicle/garage/safe door pry | None | Retain | Vehicle/world mutation crosses ownership; retired |
| Improvised hotwire; un-hotwire | Vehicle gameplay, no Works owner | Retain | Vehicle radial overrides; retired |
| Alternate can opening; pour contents | foodWorks | Retain; no semantic mapping | Inventory menu/action overlap; candidate owner foodWorks |
| Repair extensions; repair all clothing | Vanilla/medWorks by procedure domain | Retain | Inventory repair-handler replacement is high risk; no adoption |
| Corpse ignition | Vanilla/MORTIS facts; no action owner | Retain | World-menu and corpse mutation risk; retired |
| Tear all nearby clothing | None | Retain | Inventory/world batch mutation; future bounded batch contract only |
| Equipment QoL master | Multiple UI behaviors | Retain | Not a migratable capability; retired as a bundle |
| Drop all but one | B47ANCEDEssentials batch-action candidate | Retain | Inventory context overlap; not currently implemented |
| Dismantle all recipes/watches | B47ANCEDEssentials batch-action candidate | Retain | Direct inventory-pane override; not currently implemented |
| Saw all outputs to ground | `CraftOutputRouting` | No automatic mapping; CSR false default differs from current routing semantics | High duplicate recipe-output handling; CSR must be disabled before coexistence |
| Item rename | Vanilla/UI workflow, no Works owner | Retain | Client menu plus server command and refresh hooks; retired |
| Automatic key ring; capacity; weightless keys | `AutoKeyRing` owns filing only | Do not map capacity/weight: current bounded-transfer/preserve-favorite semantics differ | Critical duplicate client/server transfer risk; never enable both |
| Wearable-slot repair | Clothing/content owner | Retain | Global item/script mutation; requires exact B42 reproduction, otherwise retired |
| Climb while carrying bags/generator | B47ANCEDEssentials traversal candidate, not current ladder behavior | Retain | Direct timed-action method overrides; retired until native input/animation proof |
| Sweep trash/ashes; charcoal chance | groundWorks candidate | Retain | World-object removal and yield authority; not owned by B47ANCEDEssentials |
| Sleep anywhere | Vanilla workflow candidate | Retain | World context/action overlap; retired |
| Sleep benefits | Player-health domain, no Works owner | Retain | Recurring player mutation; retired |
| Hide in furniture | Player stealth domain, no Works owner | Retain | Tick/key/context hooks; retired |
| Stop, drop, and roll | Player fire/health domain, no Works owner | Retain | Timed action and condition mutation; retired |
| Warm up; towel drying | weatherWorks facts, player-health consumer unassigned | Retain | Context action/player-state mutation; no adoption |
| Exercise with gear | Vanilla/player progression, experienceWorks observation only | Retain | Player action override; retired |
| Barrel cap repair; useful barrels/capacity | waterWorks | Retain; never import capacity | Moveable-method, object-add, context, and fluid-state collision; route to EXT-04 only |
| Perfume disinfectant; rag/bandage/staple handlers | medWorks | Retain | Medical menu/action mutation; separate medWorks proposal required |
| Lighter/match use counts | lightWorks/item owner | Retain; never import counts | Script/item mutation at world init; separate defect proof required |
| Extended battery life/multiplier | powerWorks | Retain; never import multiplier | Competing drain authority; denied while powerWorks owns energy |
| Food-expiry tooltip | foodWorks facts, uiWorks presentation | Retain | Tooltip-only candidate after provider contract; not B47ANCEDEssentials state |
| Jar capping | foodWorks/waterWorks fluid boundary | Retain | Inventory timed action; separate canonical recipe/fluid review |
| Split wash menus; wash all | waterWorks facts plus vanilla/UI action | Retain | Direct world-menu override and context duplication; candidate only after EXT-04 |
| Refrigerator toggle | powerWorks consumer transaction; uiWorks presentation | Retain | World menu and server-response overlap; route to EXT-06/07 |
| Vehicle roof climb and peer sync | Vehicle owner/unassigned | Retain | Player-update pinning, server messages, context hooks; explicitly outside B47ANCEDEssentials without vehicle capability |
| Vehicle hood/trunk craft surfaces | Crafting/vehicle capability owner unassigned | Retain | Global `ISEntityUI.FindCraftSurface` override; retired |
| Vehicle mechanics QoL | Vehicle UI owner/unassigned | Retain | Mechanics and fixing-menu overrides; retired pending exact reproduction |
| Vehicle salvage | Vehicle owner/unassigned | Retain | Vehicle menu/radial overrides and mutation; retired |
| Corpse in trunk | Vehicle inventory + corpse ownership unassigned | Retain | World menu/server mutation; future heavy-object contract may expose transport only |
| Rope towing | Vehicle physics owner | Retain | Runtime vehicle behavior; denied for B47ANCEDEssentials under EXT-19 boundary |
| Eat while driving/speed limit | food/vehicle action boundary | Retain | Temporarily replaces global timed-action queue; retired as unsafe |
| Walking item actions | Vanilla action policy | Retain | Base timed-action and wear-action overrides; retired pending native proof |
| Eat all stack | foodWorks candidate | Retain | Inventory batch action overlap; route to foodWorks |
| Magazine batch actions | `BulkMagazines` | Do not map: current limits/nested traversal differ | Critical menu/action duplication; never enable both |
| Reload all magazines | Weapon/action owner unassigned | Retain | Firearm radial and inventory menu overrides; retired |
| Quick sit | Vanilla input/action | Retain | Key-event duplication; retired |
| Stair-sense overlay | uiWorks candidate | Retain | HUD/player lifecycle overlap; presentation only, no B47ANCEDEssentials adoption |
| Stair-vault guard | Traversal safety candidate | Retain | Player-update mutation; requires native fall-order proof |
| Quick device toggle | `DevicePowerMenu` partially overlaps inventory device actions | Do not migrate: current implementation groups canonical power actions and does not patch vehicle menus | World/inventory menu duplication; CSR path must remain inactive |
| Video insertion | Media/device owner unassigned | Retain | World context/action overlap; candidate through canonical device action only |
| Quick inventory actions | B47ANCEDEssentials batch-action candidate | Retain | Direct inventory-pane override; not currently implemented |
| Evolved-recipe menu patch | Vanilla upstream | No setting; no state | Ungated method override; retire unless defect reproduces |
| Farming shovel safety | farmWorks/vanilla | No setting; no state | Error-masking method replacement; denied without reproduction |
| Flashlight attachment adjustment | lightWorks/weapon attachment owner | No setting; no migration | World-init item mutation; separate lightWorks compatibility proof only |
| Items-list viewer fix | uiWorks/vanilla | No setting; no state | Global UI method patch; retire unless defect reproduces |
| Transfer-amount menu | B47ANCEDEssentials future bounded batch contract | No setting; no state | Inventory context duplication; not adopted by EXT-36 |
| Context-menu interop safety | None | No setting; no state | Removes/re-adds foreign callbacks and masks errors; denied |
| Lua global compatibility shield | None | No setting; no state | Replaces/clobbers core Lua globals and can report false success; denied absolutely |
| World-water clicked-object normalization | waterWorks/vanilla | No setting; no state | Pre-context argument mutation; retire unless exact baseline defect reproduces |
| Generic server response router | Each canonical feature owner | No standalone state | Duplicate module command/notification surface; do not import |
| Hard-disabled clipboard/scooper/radial leftovers | None | Ignore/retain old values | Stubs are not features; retired |

The numerous `TimedActions/CSR_*` classes are execution halves of the parent
rows above—entry, can/jar/ammo batching, repair, cloth, lighter, battery, medical,
trash, vehicle, and warmup actions. They do not constitute independent migration
targets. `CSR_Utils.lua` and configuration constants are shared implementation,
not standalone behavior.

## Hook collision inventory

Static source evidence shows the highest-risk collision surfaces:

- `OnFillInventoryObjectContextMenu`: CSR key/item/food/magazine/repair/batch
  actions overlap current B47ANCEDEssentials key, magazine, literature, device, and
  cleanup handlers.
- `OnFillWorldObjectContextMenu`: CSR entry, cleaning, water, vehicle, device,
  hide, sleep, and wash handlers overlap current sorting, ladder, and cleanup.
- `OnClientCommand`/`OnServerCommand`: CSR has a general dispatcher plus separate
  key and rename dispatchers; current B47ANCEDEssentials sorting has its own module.
- `OnPlayerUpdate`: CSR key filing, hiding, stairs, walking, and roof pinning can
  compete with player lifecycle and split-screen identity.
- Direct method replacement: CSR overrides vehicle menus/radials, inventory-pane
  methods, fixing menus, crafting-surface lookup, moveable placement, base timed
  actions, wear actions, and firearm menus. Load order changes which wrapper wins.
- Global Lua replacement: the compatibility shield changes `pcall`, `pairs`,
  `ipairs`, or `next`; this is never an acceptable compatibility strategy.

Current B47ANCEDEssentials hooks are additive except for bounded, marked adapters in
inventory presentation and crafting output. Coexistence with CSR cannot be made
safe by handler order because the CSR runtime mutates global methods and owns
stateful actions. The supported posture is one authority: keep CSR inactive when
testing B47ANCEDEssentials successors.

## Configuration and save decision

There is no field-level CSR-to-B47ANCEDEssentials migration in this audit:

- option names and defaults differ;
- CSR capacity, balance, speed, chance, and multiplier values are authored
  behavior that must not be imported;
- current B47ANCEDEssentials adds bounds, nested traversal, favorite preservation,
  canonical routing, and different enablement semantics;
- no persisted CSR ModData mapping to current B47ANCEDEssentials was proven;
- the one historical save proves activation only, not player intent per option.

Unknown CSR sandbox fields and ModData remain untouched. A future migration may
consider only an explicit user opt-in and exact boolean intent for a semantically
identical feature; none is proven here.

### Exact sandbox-key coverage

The inactive package declares 85 keys. This inventory prevents a grouped behavior
row from accidentally hiding a tuning field. Each key inherits the disposition
of its parent row above.

- Entry/tools (38): `EnableEntryActions`, `EnablePrySystem`,
  `PrySuccessMultiplier`, `PryNoiseMultiplier`, `EnableScrewdriverLockpick`,
  `LockpickSuccessMultiplier`, `LockpickNoiseMultiplier`, `EnableBoltCutter`,
  `BoltCutSuccessMultiplier`, `EnableFenceCutting`, `FenceCutTimeMultiplier`,
  `EnableImprovisedHotwire`, `EnableUnHotwire`, `EnableVehicleDoorPry`,
  `EnableGarageDoorPry`, `EnableSafeDoorPry`, `ReinforcedDoorLevel`,
  `VehicleWindowShatterChance`, `InjuryChance`, `ToolWearMultiplier`,
  `EnableAlternateCanOpening`, `EnablePourCanContents`,
  `EnableRepairExtensions`, `EnableRepairAllClothing`, `EnableCorpseIgnite`,
  `EnableTearAllNearbyClothing`, `EnableEquipmentQoL`, `EnableDropAllButOne`,
  `EnableDismantleAllRecipes`, `EnableDismantleAllWatches`,
  `EnableSawAllDropToGround`, `EnableItemRename`, `EnableAutoKeyRing`,
  `AutoKeyRingCapacity`, `AutoKeyRingWeightless`, `EnableWearableSlotFix`,
  `EnableClimbWithBags`, `EnableClimbWithGenerator`.
- Gameplay (25): `EnableSweepTrash`, `EnableSweepAshes`,
  `SweepAshesCharcoalChance`, `EnableSleepAnywhere`, `EnableSleepBenefits`,
  `EnableHideInFurniture`, `EnableStopDropRoll`, `EnableWarmUp`,
  `EnableTowelDrying`, `EnableExerciseWithGear`, `EnableBarrelCapFix`,
  `EnableUsefulBarrels`, `UsefulBarrelCapacity`,
  `EnablePerfumeAsDisinfectant`, `EnableLighterUses`, `LighterMaxUses`,
  `DisposableLighterMaxUses`, `MatchesMaxUses`, `EnableExtendedBatteryLife`,
  `BatteryLifeMultiplier`, `EnableFoodExpiryTooltip`, `EnableJarCapping`,
  `EnableWashMenuSplits`, `EnableWashAll`, `EnableFridgeToggle`.
- Vehicles (12): `EnableRoofClimb`, `RoofClimbPeerVisualSync`,
  `RoofClimbFallDamage`, `EnableVehicleCraftSurfaces`,
  `EnableVehicleHoodCraft`, `EnableVehicleTrunkCraft`,
  `EnableVehicleMechanicsQoL`, `EnableVehicleSalvage`, `EnableCorpseTrunk`,
  `EnableRopeTow`, `EnableEatWhileDriving`, `EatWhileDrivingMaxSpeed`.
- Interface (10): `EnableWalkingItemActions`, `EnableEatAllStack`,
  `EnableMagazineBatchActions`, `EnableReloadAllMags`, `EnableQuickSit`,
  `EnableStairSense`, `EnableStairVaultGuard`, `EnableQuickDeviceToggle`,
  `EnableVideoInsert`, `EnableQuickInventoryActions`.

The saved ModData surfaces observed in source—key-ring bookkeeping, renamed-item
fields, barrel state, swept-trash counts, hiding state, jar state, towing material,
and vehicle-roof state—have no exact current B47ANCEDEssentials schema. They are retained
untouched and are not evidence for a conversion.

## EXT-36 completion boundary

The required provenance and duplicate-handler audit is complete. It authorizes no
runtime changes. Adoption of any retired/candidate behavior requires EXT-37's fix
record, a reproduced defect on the supported Build, an exact canonical owner, an
inert capability probe, regression coverage, and a removal condition.
