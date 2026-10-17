# Version policy

Root `VERSION` is the sole canonical project Semantic Version. The user approved
its establishment at `0.19.0` on 2026-10-16 after reviewing the recorded `0.18.0`
legacy metadata and the then-missing Git repository. Offline rename work was
explicitly authorized; historical rename freshness was UNKNOWN. GitHub onboarding
was separately authorized on 2026-10-17.

Before 1.0, changes to public identity/contracts advance MINOR; compatible fixes
advance PATCH. After 1.0, incompatible public changes advance MAJOR. The rename
changes the Mod ID, module/API namespace, command channels and sandbox namespace.

Current mirrors checked by `python scripts/check_versions.py`:

- `README.md`: Version entry.
- `Contents/mods/B47ANCEDEssentials/42/mod.info`: `modversion`.
- `Contents/mods/B47ANCEDEssentials/info.txt`: Version entry.
- `Contents/mods/B47ANCEDEssentials/42/media/lua/client/B47ANCEDEssentials/TestKit.lua`:
  runtime diagnostic version.
- `docs/MASTER_ROADMAP.md`: Current version entry.
- `WORKSHOP_DESCRIPTION.txt` and `workshop.txt`: Mod Version entries.
- `WORKSHOP_CHANGE_NOTE.txt`: first Version header.
- `CHANGELOG.md`: first version entry.

Historical versions in feature notes and validation evidence stay tied to their
original environment; they are not current proof. `dist/`, `SHA256SUMS.txt` and
`.steamcmd-last-upload.sha256` are historical artifacts/receipts, not current
mirrors. Keep their names, contents and hashes unchanged. `--release` additionally
requires and inspects a matching current ZIP; it does not generate one, publish,
or prove runtime compatibility.

PZ minimum version `42.20.3`, sandbox format version `1`, reference schemas and
heavy-object serialization version `1` are independent of project SemVer.

Authoritative runtime source: `Contents/mods/B47ANCEDEssentials/42`.
`tests/`, `scripts/`, `docs/`, `artwork/`, root metadata and Workshop text are development
inputs; `dist/` holds generated historical packages/staging. Preserve custom art.
Workshop item `3788591728` remains selected; do not create an item or alter visibility.

The configured public remote is `https://github.com/B47ANCE/B47ANCEDEssentials.git`.
Use feature branches and PRs before merging shared `main`; verify local/remote
commit SHAs after every push. Repository onboarding records initial version
`0.19.0`; no runtime/API change or additional version bump is introduced by
recording that existing build in Git. Gameplay requires dedicated G7 PASS before
stable-release G8. Source backup and offline checks prove neither runtime gate.
