# 0.19.0 rename validation — 2026-10-16

Project: **B47ANCE'd Essentials**. Mod ID/public namespace: `B47ANCEDEssentials`.
Canonical root `VERSION`: `0.19.0`. Existing Workshop item: `3788591728`.

The user explicitly approved local/offline work and canonical-version
establishment. No Git repository/remote is present. HEAD, branch, upstream,
default-branch divergence and remote SHA are unavailable. Freshness is UNKNOWN;
commit/push is BLOCKED and this iteration is **NOT BACKED UP to GitHub**.
A private pre-rename source copy and hash manifest were retained locally.

## Exact validation commands

Working directory: `C:\Users\willi\Desktop\Work\Project Zomboid\Mod Repositories\B47ANCEDEssentials`.

```powershell
& 'C:\Users\willi\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' scripts\check_versions.py
& 'C:\Users\willi\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' scripts\check_identity.py
& 'C:\Users\willi\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' scripts\run_host_tests.py
& 'C:\Users\willi\.codex\b47anced-team\tools\Test-PZRepositoryFreshness.ps1' -Repository 'C:\Users\willi\Desktop\Work\Project Zomboid\Mod Repositories\B47ANCEDEssentials'
```

- [TESTED — offline] Version checker: PASS; all nine current mirrors match root
  `VERSION`. The pre-rename source had no checker or root `VERSION`.
- [TESTED — offline] Identity checker: PASS; metadata, 35 sandbox option bindings,
  English names, context translation keys, case-correct internal requires and
  duplicate Workshop-description mirrors checked. No active Java/JAR/classes.
- [TESTED — offline] All 26 host regressions and 28 production Lua syntax checks
  PASS before and after rename. Runtime: isolated lupa Lua 5.1, with the
  development harness alias `table.unpack = table.unpack or unpack`. Stock Lua
  5.1 initially lacked this alias; the harness was corrected and both baseline
  and final suites passed without changing production behavior.
- [TESTED — offline] Existing serialized guided progress, kit-grant prevention,
  authoritative history-store attachment and repeated attachment covered by
  updated fixtures. No real player save was opened or modified.
- [VERIFIED — source comparison] All 28 production Lua files match their
  pre-rename versions after normalizing the identity, diagnostic version and
  added comments. Sandbox option values/defaults/bounds are unchanged.
- [TESTED — local integrity] All 586 protected historical files/receipts/checksums
  and item identity files retain SHA-256; the retained ZIP passes CRC/data checks.
  Runtime icon is unchanged. The two current title images intentionally changed;
  they are matching 512 x 512 PNGs. Preview SHA-256:
  `ca658a99e622fdd4c26c1f6f6b3befff983b0b1324689659bd9c3cc81cc88c53`.
- [VERIFIED — local files] Four live workspace shortcuts point to the new root.
- [UNKNOWN] Freshness helper exit 1: not a Git repository. No fetch/commit/push
  or remote visibility claim is possible.

Local comparison/integrity command, retained with private diagnostic evidence:

```powershell
& 'C:\Users\willi\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' 'C:\Users\willi\.codex\tmp\verify_essentials_rename.py'
```

This local helper depends on the private pre-rename hash manifest; it is not a
portable release gate. Public project checks are the three scripts above.

## Runtime and release gates

[RUNTIME GATE] SP NOT TESTED. Hosted/dedicated MP NOT TESTED. Dedicated gameplay
G7 BLOCKED / NOT TESTED; stable-release G8 BLOCKED. Offline checks do not prove
native event loading, multiplayer synchronization, save compatibility or Linux
execution. No current package was built; `--release` was not run against an
invented artifact. No game/server launch, deployment or Workshop upload occurred.

Before combined use, update client/server mod lists, presets and dependent API
consumers together; do not enable both identities. Sandbox values do not migrate
automatically. Validate old-save fixtures, repeated reloads, reconnects and
dedicated restarts. The three retained serialized keys are listed in
[RENAME_COMPATIBILITY.md](RENAME_COMPATIBILITY.md).

Affected surfaces: runtime directory and Lua/translation/sandbox identities,
current mod/Workshop metadata, tests, current docs, root version/changelog,
validation scripts, title artwork and local workspace selectors. Historical
archives/staging and other mod repositories remain original evidence.
