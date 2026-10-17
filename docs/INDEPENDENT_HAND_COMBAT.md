# Independent-hand combat

## Status and ownership

Accepted design. Version 0.9.0 implements only the pure equipment classifier and
bounded third-party classification providers documented in
`NATIVE_COMBAT_METADATA_AUDIT.md`; combat/animation runtime remains pending.
Canonical repository branding remains `B47ANCEDEssentials`.

B47ANCEDEssentials owns equipment pairing, input, attacks, manipulation, reloads,
balance, hotkeys and compatibility. Project M.O.R.T.I.S. is an optional provider
of limb capability, never a required dependency or the combat-system owner.

## Equipment-derived activation

Derive NONE, FIREARM_FIREARM, MELEE_MELEE, FIREARM_MELEE or MELEE_FIREARM from
current Primary/Secondary equipment and verified one-handed eligibility.
Never add a stance toggle, context-menu activation or activation hotkey. Never
silently swap the player's chosen hand assignments. Removing/invalidating an
item restores appropriate vanilla single-item behavior.

Use native metadata and animation capability plus override APIs for unusual
items, not long item-ID/Workshop lists. Two-handed weapons are not eligible just
because an inventory slot accepts them. Reevaluate on equipment, ownership,
condition, capability, drop, death and incapacitation changes using dirty/events.

## Firearms and manipulation

- Preserve vanilla RMB aiming. FIREARM_FIREARM LMB alternates trigger attempts,
  Primary then Secondary. Advance after a valid attempt, not just a fired shot.
- Never skip a jammed gun: its turn attempts the trigger without producing a shot.
- Keep ammunition, chamber, magazine, jam, condition, attachments, recoil,
  sound, muzzle effects and XP/events independent per actual weapon.
- Extend native X rack/eject/manipulation semantics to both firearms. Jams take
  priority; resolve one jam per action with deterministic ordering. With no jam,
  alternate manipulation hands.
- Fire and manipulation selectors are independent. X cannot alter next fire.
- Dual firearms incur configurable handling/accuracy penalties, generally larger
  off-hand. Starting ranges of 15–25% Primary and 25–40% Secondary are proposals,
  not final values. Do not balance primarily by reducing bullet damage.
- Preserve native skill, fatigue, panic, movement, injury and weapon factors.

## Melee and mixed pairs

Two eligible melee weapons alternate valid attacks while respecting actor-wide
animation/recovery timing. No cancellation loop or free doubled attack rate.
Derive configurable burden from weapon weight/category/handling, with endurance,
recovery, precision and off-hand costs where native support permits.

Mixed pairs must not alternate gunshots and stabs on ranged-fire input. Preserve
firearm intent; investigate the native shove/close-combat input for the melee
hand. Support reversed hand assignment without silently normalizing it. Verify
the actual input/animation path before deciding the final dispatch.

## Equipment and reload actions

Add normal configurable keybindings for Draw Primary/Secondary/Both, Holster
Primary/Secondary/Both and Swap Hands. They perform equipment actions, not mode
switching. Remember the previous pair and its hand assignment.

Use actual accessible items and vanilla timed equip/storage actions. Prefer the
previous attachment, then an appropriate available holster/belt location, then
ordinary inventory. Respect ownership and legal swaps; no inaccessible-container
teleportation, item deletion or direct setters bypassing timing/network hooks.

Reload each gun independently. Where manipulation requires a free hand, actually
stow the other weapon, reload, then restore it when valid. No instantaneous dual
reloads or cosmetic three-handed manipulation. Preserve interruption safety.

## Optional anatomy and multiplayer

When installed, consume M.O.R.T.I.S. capability for each arm/hand. Missing or
nonfunctional anatomy forbids that hand's attacks; injuries affect handling.
Do not duplicate anatomy or invent an API method from conceptual handoff names.

Server owns attack selection/results, ammo, jams, ejections, condition, equipment,
timed-action completion, hit/projectile resolution and gameplay modifiers.
Clients may predict presentation, never invent successful secondary shots.

## Mandatory research and capability tiers

Audit B42 Primary/Secondary selection, firing/projectiles, native X actions,
reloads, melee, shove, model attachments, secondary muzzle/recoil, left/right
aiming/attacks, mixed stances, moving/turning, sprint transitions, climbs/vaults,
falls/knockdown and dropping before enabling combat hooks.

Classify pair support as full visual/gameplay support, constrained verified
animations, or unsupported. Do not fake polished secondary-hand support or use
equipment swaps to disguise a primary-only firing path.

Sequence: native audit → metadata classifier → automatic reevaluation → separate
selectors → firearm execution/jams/X → handling penalties → equipment hotkeys
and memory → melee/mixed prototypes and balance → optional anatomy → modded
metadata → authority/sync → diagnostics and single-weapon regression tests.

Balance toggles belong centrally in sandbox/config; local input preferences
belong in normal keybindings. No new dependency is authorized by this feature.

## Acceptance and inspection

Tests must cover automatic pistol pairing/removal, normal alternation, jammed
Secondary not skipped, X finding Secondary jams, no-jam X alternation, independent
selectors, melee recovery, intuitive mixed controls, preserved reversed pairing,
Draw Both restoring assignment, Holster Secondary returning to single behavior,
and optional missing-hand rejection. Validate multiplayer and native visuals
before claiming support.

Inspection should report pair type/reason; per-hand item/class, eligibility,
usability, ammo/jam, next-fire readiness, handling and anatomy; separate selectors;
aggregate burden and accuracy/melee modifiers. Diagnose limitations explicitly.
