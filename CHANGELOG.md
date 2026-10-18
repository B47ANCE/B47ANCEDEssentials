# Changelog

## 0.19.2 — 2026-10-18

- Audited 28 local project scopes against all 44 retained QoL entries. Corrected
  UI/SPXTRM and Health Care/Medical Checks ownership, identified existing Auto Clean
  area cleanup and Quartermaster logistics, and recorded incomplete adapters,
  unassigned livestock scope and Lua-only blockers. Research/documentation only.

- Rechecked every prior QoL requirement against vanilla and rebuilt the top 25.
  The shortlist now has 44 entries: 20 existing Essentials entries and 24 scoped
  additions. Removed 37 native-covered proposals, held 33 unproven entries, and
  merged two duplicates while preserving all 21 prior Essentials source/foundation
  identifiers. Recorded native coverage and remaining scope for every decision.
- Corrected the research backlog after the owner's vanilla-baseline clarification:
  inventory search/filtering is excluded from new implementation work. Reranked
  115 candidates and updated the top 25; every candidate now explicitly requires
  a demonstrated gap against vanilla before any implementation is proposed.
- Added a documentation-only downloaded-Workshop QoL census, impact ranking and
  top-25 clean-room implementation plan, including current Essentials coverage,
  proposed owning projects, native overlap and explicit evidence limits.
  Added development-only metadata and report consistency tools. No runtime,
  identity, configuration, package or Workshop change; independent review pending.
- Added a backpack-only transparent icon derived from the supplied thumbnail:
  no text, loose keys, wristwatch or background fill. Saved the full-resolution
  RGBA master, a 128 px export and a 32 px export matching the existing game slot.
- Preserved the thumbnail, poster, their masters and historical packages.
  Gameplay/configuration are unchanged; the sole Lua edit is the version diagnostic.
- Synchronized current version mirrors and feature overview. Current Workshop
  changenotes describe this patch; earlier notes remain preserved in Git history.

Offline version/identity, image decode/alpha and source/asset integrity checks
are recorded in `docs/ICON_0.19.2.md`. No new PZ runtime proof. The prepared
0.19.1 Workshop upload remains paused; no package, deployment or upload is run.

## 0.19.1 — 2026-10-17

- Replaced the Workshop thumbnail with the user-supplied Essentials backpack,
  keys and watch artwork. Preserved its exact PNG as the authoring master and
  exported the current 512 x 512 preview. No image generation or content edits.
- Preserved the existing mod poster, icon, prior artwork and historical packages.
- Synchronized current version metadata and the reviewed feature overview.
  Corrected the version checker to compare only the current changelog entry,
  preserving prior version headers as historical records.
  Gameplay, configuration, networking and persistence are unchanged; the sole
  Lua edit is the diagnostic version string.

Validation: offline version/identity and PNG integrity/visual checks; see
`docs/THUMBNAIL_0.19.1.md`. SP/dedicated NOT TESTED; G7 and stable G8 BLOCKED.
No deployment or Workshop upload.

Publication preparation for the user-authorized Workshop MP test upload retains
version `0.19.1`: add the required testing label, accurate compatibility limits,
public GitHub source link and a deterministic staging/provenance builder. The
existing hidden item's visibility is preserved by omitting visibility from the
upload VDF. No runtime behavior changes are introduced by this metadata update.

## 0.19.0 — 2026-10-16

- Renamed the project to **B47ANCE'd Essentials** and the Mod ID, public Lua
  namespace, module paths, network channels, sandbox keys, translation keys and
  debug commands to `B47ANCEDEssentials`.
- Established root `VERSION` with explicit user approval, based on the previous
  `0.18.0` metadata. This pre-1.0 MINOR iteration changes public identity contracts.
- Updated current metadata, documentation, tests and local workspace references.
- Updated the preview/poster title while retaining the existing scene and badge;
  preserved the original artwork in the local pre-rename backup.
- Retained serialized heavy-object history, guided-test state and test-kit flags
  under their original storage keys so a rename does not silently reset saves.
- Added standalone host-test and version/identity validation entry points.

Update client and server mod lists, dependent integrations and sandbox settings
together. Do not load both identities. No automatic sandbox-settings migration
or old public namespace alias is provided. Workshop item `3788591728` is unchanged.

Validation: offline Lua host tests and syntax checks only. SP and dedicated MP
are NOT TESTED; G7 and stable-release G8 remain BLOCKED. No deployment or upload.
At rename completion no Git repository/remote existed. On 2026-10-17 the user
authorized public repository onboarding at `B47ANCE/B47ANCEDEssentials`; the
current build is submitted on `feature/essentials-0.19.0` through a PR. Version
and runtime source remain unchanged by onboarding. Added a reviewed feature
overview and exclusion rules for local links, upload receipts and caches.

## Historical baseline

The previous source reported `0.18.0`; no root `VERSION`, version policy,
changelog or Git history was present. Existing historical feature/version notes,
archives, staging backups, upload receipt and checksum records are preserved.
