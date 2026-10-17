# Build 42.20 API Surface

Verified against the installed Project Zomboid 42.20.3 source.

- Inventory automation uses `ISInventoryTransferAction`, `ISTimedActionQueue`, container `isItemAllowed`, and `hasRoomFor(player, item)`.
- Multiplayer sorting uses `sendClientCommand`, `Events.OnClientCommand`, server-side square/object/container re-resolution, and container synchronization.
- Magazine batches use `ISLoadBulletsInMagazine` and `ISUnloadBulletsFromMagazine`.
- Craft output uses the `ActionManager.addOrDropItem` path called by `ISHandcraftAction:performRecipe`; the override exists only for one protected call.
- Hotbar persistence uses `availableSlot`, `attachedItems`, `InventoryItem:setAttachedSlot`, `savePosition`, and `reloadIcons`.
- Map symbols use `ISMap.SCALE`; Build 42 already provides `showScaleSlider` for each symbol.
- Literature status mirrors vanilla read-page/recipe knowledge; recorded-media status uses `InventoryItem:getMediaData`, media-line GUIDs, and `IsoPlayer:isKnownMediaLine`.
- Ladders use tile-definition `ladderW/N/E/S` properties and vanilla `climbSheet*`, `climbSheetTop*`, `Hoppable*`, `ISClimbSheetRopeAction`, and character climb checks.

Unknown methods and objects are treated as unavailable. Context callbacks are protected so diagnostics cannot break inventory or world menus.
