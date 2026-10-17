# Build 42 ear-protection audio audit

Audit date: 2026-09-06  
Runtime inspected: installed Project Zomboid 42.20.3 at
`E:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid`

## Result

**BLOCKED for runtime implementation.** Build 42 contains useful internal audio
primitives, but the inspected Lua and Java surfaces do not establish a supported,
listener-local route that a Lua mod can use while proving all required exclusions.
B47ANCEDEssentials must not approximate this feature through the user's SFX, ambience,
music, or master-volume settings.

## Evidence

| Capability | Classification | Evidence and limitation |
|---|---|---|
| Separate in-game and music buses exist | CONFIRMED, JAVA-INTERNAL | `zombie.SoundManager.Update()` resolves `bus:/InGame` and `bus:/Music`. The handles are private fields used by pause/resume. |
| Runtime bus volume/mute calls exist | CONFIRMED, JAVA-INTERNAL | `fmod.javafmod` wraps FMOD Studio bus get/set volume, mute, and pause calls. This is not evidence that the private in-game bus is a supported Lua mod API. |
| Low-pass primitives exist | CONFIRMED, JAVA-INTERNAL | `fmod.javafmod` exposes native channel-group low-pass gain and DSP functions. No inspected game path connects these to the private Studio in-game bus for a wearable effect. |
| Vanilla hearing parameters exist | CONFIRMED BUT UNSUITABLE | `ParameterHardOfHearing` derives a global parameter from the first available player's trait. `ParameterDeaf` is a local event parameter owned by an `IsoPlayer`. Neither exposes a supported setter or wearable-scoped composition contract. |
| Lua can isolate all required diegetic sounds | POSSIBLE / UNPROVEN | The in-game bus name suggests a useful grouping, but bank routing was not proven to exclude jump scares, alerts, moodle cues, notifications, menus, and UI sounds. |
| Per-listener filtering for split-screen | BLOCKED | Listener count/position is managed internally; no inspected Lua-facing per-listener bus/filter control was found. |
| Safe exact restoration and option composition | BLOCKED | Without an owned filter instance or supported bus-effect API, a mod cannot reliably restore only its contribution while preserving concurrent engine/user changes. |

The existing public sound-manager volume methods target settings VCAs such as
`vca:/Settings_Sfx`, `vca:/Settings_Ambience`, and `vca:/Settings_Music`. They
are deliberately rejected because they are broad preference mechanisms and do
not satisfy the handoff's channel exclusions or no-setting-drift requirement.

## Reconsideration gate

Implementation may resume only when a current Build 42 runtime provides at
least one of the following with reproducible evidence:

1. a supported Lua API for a reversible effect/parameter explicitly routed to
   diegetic world audio and excluding every presentation category in the
   handoff; or
2. a supported listener-local filter API with independently verifiable routing,
   lifecycle, and composition behavior.

The first subsequent slice must be a diagnostic-only in-game probe that reports
capability and routing state. It must not change persistent audio settings and
must restore its exact owned state on every exit path. Native implementation
still requires the full audible exclusion matrix in
`EAR_PROTECTION_AUDIO_HANDOFF.md`.

## Clean-room note

This audit uses only installed vanilla source/classes as engine evidence. No
third-party mod code, assets, tuning values, or implementation structure were
used.
