# Ear-Protection Audio Handoff

Status: approved small QoL feature; implementation requires native audio-path proof

## Player-facing behavior

When the local player is actively wearing ear protectors, only diegetic in-game
world sound is reduced and muffled. Removing the protectors immediately restores
normal world audio. Carrying the item, placing it in a bag, or wearing a cosmetic
“on neck” variant does not apply the effect.

Diegetic scope includes sounds produced within the playable world, such as nearby
characters, zombies, weapons, doors, alarms, appliances, weather, vehicles,
footsteps, and spatial radios or televisions. Non-diegetic presentation audio is
explicitly excluded: jump-scare stingers, UI clicks, menus, notifications, moodle
or alert cues, music, and similar player-facing effects must remain unchanged.

## Initial eligibility

- Built-in item: `Base.Hat_EarMuff_Protectors`.
- Eligibility is based on the local player's currently worn items, not inventory.
- The equipped item must occupy its active worn/body location; name matching is
  not acceptable.
- `Base.Hat_EarMuffs` is not automatically treated as protective equipment merely
  because its name is similar.
- Third-party items may opt in later through an explicit, bounded hearing-
  protection provider or declared tag after the Build 42 item/tag API is verified.

The inactive CSR wearable-slot fix is identity evidence only: it lists
`Hat_EarMuff_Protectors` and `Hat_EarMuffs` and moves them from `Hat` to `Ears`.
No CSR code or definition is to be copied.

## Ownership boundary

This is an B47ANCEDEssentials client presentation effect. It changes what the wearer
hears, not what the character or world emits.

It must not:

- reduce gunshot, alarm, speech, footstep, vehicle, or other world sound radius;
- change zombie/NPC hearing or attraction;
- change stealth, awareness, traits, panic, damage, or hearing health;
- alter another player's audio;
- require server authority, persistence, or network traffic;
- replace sound definitions or source-mod audio assets;
- attenuate jump-scare stingers, UI/click sounds, menus, notifications, alerts,
  moodle cues, music, or other non-diegetic presentation audio;
- modify permanent user volume sliders as its state mechanism.

## Required implementation shape

1. Detect the local player's worn-set transition through the narrowest verified
   equipment/player update hook.
2. Resolve active ear-protection eligibility from exact full type or an explicit
   future provider/tag.
3. Apply a local diegetic-world audio-bus/filter state only when eligibility
   changes; do not perform per-sound or per-world-object scans. The chosen native
   path must prove that excluded non-diegetic channels are unaffected.
4. Restore the exact pre-effect runtime audio state on unequip, player replacement,
   death, return to menu, mod shutdown/reload, or callback failure.
5. Compose safely with player changes to audio options. The effect must never
   restore stale volume settings over a user adjustment.

Preferred behavior is a native low-pass/muffle effect plus attenuation on a
dedicated diegetic-world listener path. A broad SFX or master-volume path is not
acceptable because it may include excluded presentation cues. Jump scares, music,
UI, notifications, alerts, and menu
audio must bypass the effect. Spatial in-world radio/television, character voice,
and vehicle/interior sounds qualify only when the native bus proves they are
diegetic world audio; non-spatial UI/radio presentation does not. If Build 42
cannot isolate diegetic world sound from excluded presentation channels, stop and
document that limitation rather than applying a broad master/SFX-volume change.

## Configuration

- Default: enabled once the native path is verified.
- Provide one B47ANCEDEssentials sandbox/client option to disable the feature only if
  consistent with existing configuration ownership.
- The attenuation/filter amount is a product-tuning value. Do not inherit an
  external mod's value or invent a final balance claim from host tests.
- If a safe native filter is unavailable but reversible bus attenuation is
  available, ship attenuation only after explicit documentation; do not simulate
  muffling through destructive sound replacement.

## Regression coverage

- protectors in inventory: no effect;
- protectors worn in the active location: effect applies once;
- cosmetic/on-neck form: no effect;
- unequip: exact runtime state restored;
- repeated updates: no stacking or volume drift;
- swap local player/death/menu transition: state restored;
- audio option changed while equipped: no stale setting restoration;
- unsupported third-party item: no effect;
- explicitly registered future provider item: effect follows provider result;
- split-screen: behavior is not claimed until per-listener audio control is proven;
- emitted sound and zombie attraction remain unchanged;
- the same gunshot, alarm, speech, footstep, vehicle, and other world-emission
  events retain exactly the same radius and AI-attraction behavior;
- jump scares, UI clicks, menus, notifications, alerts, moodle cues, and music are
  bit-for-bit/unity-gain unaffected by the ear-protection state;
- existing B47ANCEDEssentials workflows remain unchanged.

## In-game validation

Test ordinary ambience, nearby/far combat, alarms, vehicles, doors, spatial
speech/radio/television, weather, and footsteps as included world audio. Separately
test jump scares, music, UI clicks, menus, notifications, alerts, moodle cues, and
pause/menu transitions as excluded audio. Confirm the effect is listener-local,
excluded channels remain unchanged, and zombies respond to the same sound events
with and without protection.
