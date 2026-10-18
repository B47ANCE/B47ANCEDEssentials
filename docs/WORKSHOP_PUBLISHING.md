# Workshop MP test publication

## Paused prepared upload

The prepared `0.19.1` package from source `e002cae` remains frozen and local.
SteamCMD requested a password on 2026-10-17, and the user chose to leave the upload
for later. No upload was confirmed. Current source advanced to `0.19.2` for an
icon-only update; that does not resume publication or modify the prepared package.
A future publish request must select the intended build and repeat freshness,
authentication, staging/provenance and applicable checks. The 0.19.1 instructions
and evidence below describe that preparation.

Canonical upload text remains `WORKSHOP_DESCRIPTION.txt` (Steam BBCode) and
`WORKSHOP_CHANGE_NOTE.txt`. `workshop.txt` mirrors the description for local
authoring. The user confirmed existing Workshop item `3788591728` is hidden;
the public details API returns result 9. This is not authorization to create an
item or change visibility. Upload VDFs omit visibility and tags so existing
server-side settings are retained. Do not infer visibility from older files.

The publication target is app `108600`, Mod ID `B47ANCEDEssentials`, current
version `0.19.1`. The user explicitly requested publication after passing tests
and merging open project PRs on 2026-10-17. This is an MP test upload under the
shared Workshop exception, not stable release approval.

## Reproducible package and provenance

From a clean, freshly verified merged source commit:

```powershell
.\.venv\Scripts\python.exe scripts/check_versions.py
.\.venv\Scripts\python.exe scripts/check_identity.py
.\.venv\Scripts\python.exe scripts/run_host_tests.py
.\.venv\Scripts\python.exe scripts/build_workshop.py --game-build 25485521
.\.venv\Scripts\python.exe scripts/check_versions.py --release
```

`25485521` is the installed app's Steam build ID read from its appmanifest during
this preparation; it is distinct from the source minimum PZ version `42.20.3`.
No game/server is launched. The builder stages only authoritative `Contents/`,
copies the selected preview separately, writes a deterministic ZIP, hashes all
members and creates an adjacent provenance manifest binding source commit,
version, IDs, exact Steam build and evidence limits. Every new staging directory
is unique; prior packages/staging are not removed or overwritten. The ZIP is a
source-to-stage integrity artifact; SteamCMD uploads the staged Contents folder.

The generated VDF sets nonzero `publishedfileid`, app, exact content folder,
preview, title, description and changenote. It must never set visibility or tags,
nor omit/reset the existing item ID. Actual paragraph breaks are preserved.
Preview is the user-supplied 512 px export, below the 1 MiB Steam preview limit.
No local settings, diagnostics, linked tools, credentials, custom Java/native
runtime files or unrelated mods are included. The builder never logs in,
uploads, deploys, launches Steam or restarts anything.

Valve documents [updating an existing item with a nonzero ID and omitting fields
that should remain unchanged](https://partner.steamgames.com/doc/features/workshop/implementation#SteamCmd_Integration),
and an [8000-byte description limit](https://partner.steamgames.com/doc/api/ISteamRemoteStorage#Constants).
The same 8000-byte ceiling is used conservatively for local changenote checks;
the SDK lists that change-description constant as unused. Current inputs fit.

## SteamCMD and acceptance

Use the verified local SteamCMD installation and cached authentication. No
password/token/Steam Guard value belongs in a repository, argument or log.
If cached authentication fails, stop for developer reauthentication. Keep raw
SteamCMD output private; report only sanitized results. An actual successful
update result for item `3788591728` is required; exit code alone is insufficient.
No automatic desktop-client restart is allowed. Ask after confirmed success.

[TESTED — offline] 26 host regressions, 28 production Lua syntax checks and
version/identity checks passed before the thumbnail PR merge. Repeat applicable
checks on the final metadata/package snapshot. Shared transfer execution is
server-owned, resolves references again and requires positive container access;
providers retain their state ownership. These are source observations, not MP proof.

[RUNTIME GATE] SP NOT TESTED; dedicated G7 BLOCKED / NOT TESTED; stable G8 BLOCKED.
After upload, humans validate subscription/download, server startup, client
join/rejoin, access/duplication handling, synchronization, save/reload and
dedicated restart on disposable saves. The renamed ID and sandbox namespace
require coordinated configuration. Legacy Power integration remains unverified.
Historical archives and provenance remain available; a rollback requires an
explicitly selected prior package with matching mod lists and configuration.
