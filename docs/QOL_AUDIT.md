# Quality-of-Life Audit

The implementation was cross-checked against installed Build 42 Workshop examples and the installed 42.20.3 vanilla Lua/tile definitions. Third-party code and assets are not included.

## Completed ownership

| Workflow | B47ANCEDEssentials implementation | Important improvement |
|---|---|---|
| Proximity inventory | Read-only aggregate of the container buttons admitted by vanilla's bounded loot-window scan | Preserves each item's real source, deduplicates containers/items, rejects locked storage, and defers to the standalone Proximity Inventory mod when present |
| Equipped inventory | Dedicated virtual container for worn, held, and attached items plus a post-refresh personal-inventory filter | Preserves ownership, selections, drag state, and carried key rings; defers to O.C.D. Inventory when present |
| Key filing | Vanilla queued transfers into equipped/carried rings | Nested inventory, favorites, bounded passes, public recognition predicates |
| Storage sorting | Ordinary world-container action plus authoritative server execution | No special crate, exact-type priority, optional category fallback, loaded-square and transfer caps |
| Magazines | Vanilla load/unload and transfer actions chained per magazine | Unique ammunition reservation, nested inventory and operation limits |
| Craft output | Scoped wrapper around the authoritative output function | Hook always restores, recipe-specific defaults, public routing rules |
| Hotbar | Mouse/controller context-menu left/right swap | Preserves slot/item pairing and attachment indexes without replacing drag behavior |
| Map symbols | Configurable global default scale | Retains Build 42's native per-symbol slider instead of duplicating it |
| Literature/media | Vanilla page, recipe, and known-media-line queries plus carried-copy count | Data-driven skill/recipe hints; no world scan or competing knowledge registry |
| Context cleanup | Groups multiple developer/admin option objects | Preserves callback, parameters, tooltip, icon, availability and submenu |
| Ladders | Dynamic `ladderW/N/E/S` adapter to native rope states | Recognizes correctly tagged modded tiles; no sprite whitelist, invisible objects or teleport fallback |
| Independent hands | Pure one-handed melee/firearm pair classifier and bounded provider registry | Fails closed for broken, two-handed, unknown, duplicate, and provider-error cases; no combat hooks yet |

## Ownership boundaries

- powerWorks owns batteries, energy stores, consumption rates, watches as devices, and grid power.
- lightWorks owns light compatibility, emitters, bulbs, colors, cones, attachment rules, and light semantics.
- uiWorks owns broad reusable presentation and accessibility systems.
- B47ANCEDEssentials owns small workflow and vanilla-interface conveniences.

## Deliberate exclusions

- No global storage or literature scans.
- No automatic movement of favorite items by default.
- No replacement inventory, crafting, map, or hotbar UI; inventory views extend vanilla container buttons and row rendering.
- No direct item transfer from a multiplayer client.
- No ladder teleportation.
- No copied Workshop Lua, artwork, strings, or private identifiers.
