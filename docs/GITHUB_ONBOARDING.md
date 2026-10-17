# Public repository onboarding — 2026-10-17

The user authorized creation of the public repository
[B47ANCE/B47ANCEDEssentials](https://github.com/B47ANCE/B47ANCEDEssentials)
and commit/push of the existing `0.19.0` development build.

`main` starts with an empty bootstrap commit so the initial source can be
reviewed in a PR from `feature/essentials-0.19.0`. This records an existing build;
runtime source, canonical version, game minimum, serialized schema, configuration
defaults/bounds and Workshop item `3788591728` do not change. No stable tag,
release artifact, deployment or Workshop upload is part of onboarding.

## Source inventory

- Runtime source: `Contents/mods/B47ANCEDEssentials/42`.
- Mod authoring metadata/poster: `Contents/mods/B47ANCEDEssentials`.
- Development inputs: `tests/`, `scripts/`, `docs/`, `artwork/`, `README.md`,
  `VERSION`, `CHANGELOG.md`, `AGENTS.md` and local Workshop text/preview inputs.
- Historical provenance: `SHA256SUMS.txt`; referenced historical archives are
  retained locally under ignored `dist/`, not uploaded as source.
- Excluded: linked `.agents/` and `.codex/` directories, local SteamCMD receipt,
  generated staging/packages, Python caches, environment files and diagnostics.
- `.gitattributes` disables implicit newline conversion, preserving exact source
  bytes and the overview source digest between Windows and other checkouts.

The initial push contains original project source and development documents only.
No third-party implementation, runtime Java/JAR/classes, credentials, player saves,
console/server logs or linked global Codex configuration is an intended input.
The older rename validation remains historical evidence of its original state.

## Validation commands

From the project root, using Python with development-only `lupa` installed
from `requirements-dev.txt` (pinned to `2.8`). This onboarding used an ignored
local `.venv` because the updated bundled Python no longer included `lupa`:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements-dev.txt
.\.venv\Scripts\Activate.ps1
python scripts/check_versions.py
python scripts/check_identity.py
python scripts/run_host_tests.py
git diff --cached --check
```

The validation commands were executed with `.\.venv\Scripts\python.exe`
explicitly in place of `python`; shell activation is optional.

The version check must match all nine mirrors to `VERSION`; the identity check
validates metadata, 35 options, translations, case-correct internal module paths
and Workshop-description mirrors. Host tests execute in isolated Lua 5.1 with
`table.unpack = table.unpack or unpack`. Syntax checks cover the 28 Lua sources.
Review the staged diff/file inventory and scan credential patterns before every
public push. Fetch and compare source ancestry immediately before commit/push;
verify the branch's remote SHA against local HEAD after push.

No CI workflow is configured in this initial source snapshot; local passing
checks must not be described as GitHub CI success. No branch-protection settings
are changed by this task. Merge requires a separate explicit request.

[TESTED — offline, 2026-10-17] Version and identity checks PASS, all 26 host
regressions PASS, and all 28 production Lua files pass syntax checks. These
results are tied to the initial `0.19.0` source submission, not historical ZIPs.

## Evidence limits

[TESTED — offline] Source checks and host fixtures are development validation,
not engine emulation. [RUNTIME GATE] SP and dedicated multiplayer remain NOT
TESTED; G7 BLOCKED / NOT TESTED and stable-release G8 BLOCKED. New identities,
sandbox presets and dependent integrations require coordinated runtime testing.
The optional Power adapter still probes the legacy `powerWorks` contract;
compatibility with the renamed Power project is unverified. Public source backup
does not grant readiness to publish or automatically enable gated foundations.
