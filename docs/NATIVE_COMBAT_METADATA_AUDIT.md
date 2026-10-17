# Build 42 independent-hand metadata audit

This slice establishes only equipment classification. It does not enable dual
attacks, manipulation, reloads, animation changes, or multiplayer commands.

The locally installed Build 42.20.3 Lua source keeps equipped items in distinct
Primary and Secondary slots and routes combat through native character/action
state. The official Project Zomboid Java documentation confirms that
`HandWeapon:isRanged()` distinguishes ranged weapons, while inherited
`InventoryItem:isTwoHandWeapon()` and `isRequiresEquippedBothHands()` expose the
two verified exclusions required by the accepted design:

- <https://projectzomboid.com/modding/zombie/inventory/types/HandWeapon.html>
- <https://projectzomboid.com/modding/zombie/inventory/InventoryItem.html>

Version 0.9.0 therefore adds a pure, fail-closed classifier. It derives only
`FIREARM_FIREARM`, `MELEE_MELEE`, `FIREARM_MELEE`, `MELEE_FIREARM`, or `NONE`,
rejects broken and two-handed items, rejects one item duplicated across both
hands, isolates provider failures, and exposes a bounded priority-ordered
third-party provider registry. It performs no mutation and does not claim that
the engine can animate or authorize the resulting pair.

Remaining native audit gates are firing/projectile dispatch, secondary muzzle
and recoil support, melee recovery, shove/mixed intent, rack/eject/jam actions,
reload sequencing, model attachments, movement transitions, authoritative
network ownership, and visual support tiers. Those must be proven before the
classifier is connected to gameplay input.
