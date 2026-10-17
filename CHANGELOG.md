# Changelog

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
