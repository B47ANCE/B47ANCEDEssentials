# B47ANCE'd Essentials

The implementation and approved clean-room research backlog are documented in
[docs/ROADMAP.md](docs/ROADMAP.md).

B47ANCE'd Essentials is a configurable vanilla-plus quality-of-life collection for Project Zomboid. It reduces repetitive inventory and interface work while preserving timed actions, character knowledge, capacity rules, and server authority.

- Version: `0.19.2` (canonical: `VERSION`)
- Mod ID: `B47ANCEDEssentials`
- Namespace: `B47ANCEDEssentials`
- Author: B47ANCE
- Developer: Codex
- Hard dependencies: none beyond Project Zomboid 42.20.3 or newer

## Features

- A combined nearby-items container aggregates only the reachable containers already exposed by vanilla's bounded loot scan and refreshes from those admitted sources before each pane rebuild.
- Worn, held, and attached items live in a dedicated Equipped inventory view, refresh from current character state, and no longer clutter the general carried-item list.
- Independent-hand development has a pure, fail-closed equipment classifier for verified one-handed melee/firearm pairs and a bounded third-party provider API. It does not yet hook attacks, input, reloads, or animations.
- Exact-minute vanilla clock display without granting digital information to mechanical watches.
- Powered-device battery actions grouped under the device and duplicate insertion suppressed when a powerWorks cell is installed.
- Inventory selection repaired after vanilla list refreshes.
- Keys automatically filed into an equipped or carried key ring through vanilla transfer actions.
- Ordinary world containers sort their contents into nearby seeded containers through server-validated bounded scans and commit transfers only after observable source/destination ownership succeeds.
- A shared recursive-inventory service traverses only caller-authorized roots with stable identities, deterministic ordering, cycle detection, separate visibility/transfer facts, and hard depth/container/item limits; it never mutates inventory.
- Server workflows share a bounded batch-transfer transaction that revalidates access, ownership, destination rules, and capacity for every move, rolls back uncertain native mutations, deduplicates items, and replicates only committed ownership.
- Versioned inventory references resolve exact world objects, container indexes,
  and item IDs at execution time; custom providers can resolve other stable
  domains without accepting client-supplied Lua object identity.
- A bounded client/server batch transport binds each operation ID to its full
  reference payload, caches per-player retries, resolves on authority, and
  returns read-only result snapshots. No UI invokes it automatically.
- Heavy-object providers expose bounded push/pull/carry observations and retain
  all physics and object ownership. Server-authoritative operations advance
  through replay-safe reserve/start/complete/cancel phases with stable actor and
  target identities, recovery state, and bounded persisted history.
- Matching magazines load or unload through vanilla transfers and timed actions.
- Sawed planks, plus optionally heavy crafting output, route to the character's square through the authoritative crafting path.
- Hotbar slots move left or right with mouse or controller menus while attached items and saved indexes stay aligned.
- Configurable default map-symbol size; vanilla's per-symbol scale editor remains intact.
- Literature and recorded-media menus show read/watched progress, carried duplicates, and data-driven skill or recipe rewards, including nested bags.
- Multiple debug/admin context actions group without deleting or recreating their callbacks.
- `ladderW`, `ladderN`, `ladderE`, and `ladderS` tiles—including correctly tagged modded tiles—use vanilla sheet-rope climbing states without teleport fallbacks.

Every feature has a sandbox master toggle. Search radii, operation limits, nesting, favorite protection, fallback matching, output thresholds, map scale, literature scan limits, and ladder safety are independently tunable.

## Extension points

- `B47ANCEDEssentials.registerKeyPredicate(id, predicate)` recognizes a third-party key-like item.
- `B47ANCEDEssentials.registerKeyRingPredicate(id, predicate)` recognizes a third-party key-ring container.
- `B47ANCEDEssentials.registerCraftOutputRule(id, predicate)` routes a third-party crafting output when the predicate approves it.
- `B47ANCEDEssentials.InventoryTraversal.traverse(actor, roots, options)` returns a bounded read model for authorized container graphs. See [docs/INVENTORY_TRAVERSAL.md](docs/INVENTORY_TRAVERSAL.md).
- `B47ANCEDEssentials.InventoryReferences` describes and resolves versioned stable
  container/item references through fail-closed provider adapters.

Predicates must be nil-safe and return only a boolean. A failed provider is ignored and cannot interrupt gameplay.

## Validation

Run `python scripts/check_versions.py`, `python scripts/check_identity.py`, and
`python scripts/run_host_tests.py` from this project. The host runner requires
the development-only Python `lupa` package (`python -m pip install -r requirements-dev.txt`)
and uses isolated Lua 5.1 runtimes
with a `table.unpack` compatibility alias. It does not emulate the PZ engine.
The legacy ecosystem test wrappers are absent from this checkout. Runtime
checks are listed in [docs/TESTING.md](docs/TESTING.md).

The rename changes Mod ID, Lua/API paths, network channels and sandbox keys.
Update both clients and servers, dependent integrations and configuration together;
do not enable both identities. See [rename compatibility](docs/RENAME_COMPATIBILITY.md).
Workshop item `3788591728` is unchanged. Historical packages and evidence are preserved.

Public source: [B47ANCE/B47ANCEDEssentials](https://github.com/B47ANCE/B47ANCEDEssentials).
The initial `0.19.0` source snapshot was merged through PR #1. Current development
iterations use named feature branches and PRs.
GitHub source history is separate from Workshop distribution and runtime evidence.
See [repository onboarding](docs/GITHUB_ONBOARDING.md) and the reviewed
[feature overview](docs/MOD_OVERVIEW.json).

Version `0.19.1` uses user-supplied backpack, keys and watch artwork for the
Workshop thumbnail. That patch preserved the mod poster and icon; see
[artwork roles and provenance](docs/ARTWORK.md).

Version `0.19.2` adds a transparent backpack-only mod icon derived from that
thumbnail, without text or background fill. The thumbnail and poster are unchanged.
The previously prepared `0.19.1` Workshop upload remains paused.

No multiplayer compatibility claim is made until the current build is exercised on a dedicated server.
