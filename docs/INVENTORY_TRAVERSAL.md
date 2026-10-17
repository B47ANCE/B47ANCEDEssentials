# Recursive inventory traversal

Version 0.10.0 establishes the EXT-21 read boundary used by future uiWorks storage
views. It does not scan the world and never transfers, sorts, removes, or adds an
item.

Call `B47ANCEDEssentials.InventoryTraversal.traverse(actor, roots, options)`. Roots must
already have been discovered by a bounded, authority-appropriate caller. The
result contains deterministic `containers` and `items` arrays plus diagnostics.
Every container and item requires a stable string identity. Repeated containers
are treated as cycles/duplicates and repeated item identities are emitted once.

Required production adapters are:

- `canView(actor, container)` and `canTransfer(actor, container)`, evaluated
  separately. A callback error denies permission.
- `getContainerId(container)` and `getItemId(item)`. The built-in adapter accepts
  only native `getID()` evidence; it does not fabricate coordinate/type IDs.
- Optional `getItems(container)` and `getChildContainer(item)` adapters when a
  provider does not use normal Build 42 container/item methods.

Defaults are capped at depth 4, 64 containers, and 512 items. Callers may lower
or raise these within hard caps of depth 16, 256 containers, and 4096 items.
Opening a view grants no transfer authority. Any later mutation must resolve the
stable references again and use a canonical server-authoritative inventory action.

Version 0.13.0 adds `InventoryReferences` for that resolution step. The built-in
`world` provider accepts only schema-versioned integer square coordinates and
bounded object/container indexes, then resolves them against the current cell.
Item references pair an exact container reference with the native item's stable
ID and search only that resolved container. Missing squares, streamed objects,
changed indexes, missing items, malformed values, and throwing custom providers
all fail closed. Custom providers must authenticate the actor and revalidate
their own domain; registration is conflict-safe.

`InventoryTransfers.executeReferencedBatch` resolves each source item and
destination independently, preserves original request indexes, and feeds only
successfully resolved moves to the rollback-safe canonical transaction. The
client `requestReferencedTransfers` API sends a bounded explicit request; the
server binds the operation ID to the entire payload per player and returns a
cached result for an identical session retry. A changed retry is rejected as
`OPERATION_ID_CONFLICT`. Opening or traversing storage never invokes mutation.

Still requiring in-game validation: native `ItemContainer:getID()` stability
across refresh/save/reload, actor access results for nested worn/world/vehicle
containers, and multiplayer realm behavior. Until those pass, consumers should
supply verified provider IDs rather than infer identity.
