# Architecture

B47ANCEDEssentials separates pure planning from runtime adapters.

- `shared/B47ANCEDEssentials/SortingCore.lua` describes seeded containers and plans capacity-aware transfers. `SortingServer.lua` alone mutates multiplayer containers.
- `shared/B47ANCEDEssentials/LiteratureCore.lua` provides character-local status and bounded nested-inventory queries.
- `shared/B47ANCEDEssentials/CraftOutputRouting.lua` owns recipe/output policy and exposes registered third-party rules.
- Client adapters add options to vanilla menus or queue vanilla timed actions. They do not replace complete menus.
- Ladder compatibility is property-driven, so vanilla and modded tiles share one detection rule. Context-menu discovery, direction inference, execution-time revalidation, and native action initiation converge on `Ladders.resolve`/`Ladders.request`; input adapters may not implement their own climb path.

Automation follows four invariants:

1. Bound every scan and batch.
2. Preserve favorites and validate capacity/access at execution.
3. Use native timed actions or an authoritative server mutation path.
4. Fail closed and report only the first diagnostic for a repeating callback error.

Public recognition/routing registries belong to `B47ANCEDEssentials`. Compatibility aliases are not used.

`InventoryReferences.actorRoot()` is the canonical descriptor for a character's
root inventory. `actorPath()` adds at most 16 native item-ID links for carried
nested containers. Resolution starts from the supplied actor every time and
fails closed at the first missing item or child inventory. Item references then
resolve by native item ID, so uiWorks never owns or serializes inventory state.

`InventoryViews.getProximityRoots` is contextual to a live vanilla inventory
page. It deduplicates that page's real buttons and rejects locked thumpable
storage; it never scans squares, chunks, vehicles, or global object lists.

Vehicle references contain only `vehicleId` and `partId`. Resolution uses the
bounded loaded-cell vehicle list and verifies `part:getItemContainer()` at the
moment of use. The descriptor does not retain coordinates or a vehicle object.

Corpse references combine square coordinates with `getObjectIDAsLong()`. The
square narrows lookup; the synchronized object ID establishes identity. A
static-list index is never persisted or trusted.

Planned [independent-hand combat](INDEPENDENT_HAND_COMBAT.md) belongs here, with
automatic equipment-derived pairing and optional M.O.R.T.I.S. anatomy support.
It is pending mandatory native input/animation research; no dual-wield runtime
or additional required dependency is introduced by accepting this design.

Planned [contextual traversal](CONTEXTUAL_TRAVERSAL.md) extends native window
initiation and ladder interactions through the implemented ladder resolver.
The explicit `Ladder → Climb Ladder` fallback already shares this path.
Upper-ladder walking auto-descent and its intentional run bypass remain distinct
from run-assisted window/lower-ladder ascent; native input/fall-order research
is still required before those automatic adapters can be enabled safely.
