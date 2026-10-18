# User-supplied thumbnail — 0.19.1, 2026-10-17

The user requested replacement of the Workshop thumbnail with supplied
Essentials backpack, keys and watch artwork. This is a compatible artwork PATCH
from `0.19.0` to `0.19.1`. Mod ID, Workshop ID, gameplay, settings, authority,
network protocol and persisted state are unchanged. The only Lua change is the
version diagnostic; no gameplay regression or new runtime behavior is claimed.

## Assets and preservation

- Exact supplied master: `artwork/B47ANCEDEssentials-thumbnail.png`, 1254 x 1254 PNG.
  SHA-256: `5ea324fbc60e136d4220b9c95ac23461191fad2e6c3e04d623cb73dc1ba42747`.
- Active Workshop thumbnail: `preview.png`, 512 x 512 PNG, 405361 bytes.
  SHA-256: `c22b754f2d1f7c40daddeed3e0ca6cc4396add8a2ab89750e45859f3954f520c`.
- The 512 px export uses Windows System.Drawing high-quality bicubic resampling.
  No image generation, crop, redraw or content editing was needed.
- Mod poster, icon and previous poster authoring master retain exact bytes.
  The previous preview remains preserved by merged Git history (`92eae77`).
  Historical staging/archives were not changed or regenerated.

## Checks

Run from the project root:

```powershell
.\.venv\Scripts\python.exe scripts\check_versions.py
.\.venv\Scripts\python.exe scripts\check_identity.py
Get-FileHash -LiteralPath artwork\B47ANCEDEssentials-thumbnail.png,preview.png -Algorithm SHA256
git diff --cached --check
```

[TESTED — offline] The supplied image decodes as a square 1254 px PNG. The
authoring copy matches the supplied SHA-256; exported preview decodes at 512 px.
Visual inspection confirms the supplied title, backpack, keys and watch are
present and legible without cropping. Version checks PASS across all nine
current mirrors; identity checks PASS including 35 option bindings. The reviewed
overview digest is refreshed for current README, VERSION and runtime metadata.
Byte comparisons verify every Lua file is unchanged apart from the TestKit
version string. Poster/icon/prior-master SHA-256 values are unchanged. Host
gameplay regressions were not repeated for this artwork-only change; their
0.19.0 results remain historical evidence. Only intended artwork/version/docs
changes are staged, with a public-file/credential-pattern audit before push.

[RUNTIME GATE] Native display and Workshop download are NOT TESTED. Existing
gameplay SP/dedicated evidence remains unchanged: G7 BLOCKED / NOT TESTED and
stable-release G8 BLOCKED. No packaging, deployment, Workshop upload, server
launch or stable tag is part of this thumbnail update.
