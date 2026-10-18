# Offline validation of the Workshop audit

Date: 2026-10-18. Essentials canonical version 0.19.2; source base
`ee5c66a24878fc5a000a07224957f6177e3999fa`. This change adds research and
development tools. Runtime source, configuration, artwork, Workshop metadata,
packages and canonical VERSION are unchanged.

Commands run from the repository root with its development Python environment:

```powershell
.\.venv\Scripts\python.exe scripts/check_qol_audit.py
.\.venv\Scripts\python.exe scripts/check_versions.py
.\.venv\Scripts\python.exe scripts/check_identity.py
.\.venv\Scripts\python.exe scripts/run_host_tests.py
git diff --check
```

[TESTED: offline Windows] Report accounting and deterministic scoring PASS:
595 downloaded instances, 592 unique Workshop IDs, 116 deduplicated capability
entries and 25 detailed plans. Each reference resolves to an inventoried package;
all local Markdown file links were checked. Two overlapping media/menu entries
were merged during final review rather than counted as separate features.

[TESTED: offline Windows] Version PASS: nine current mirrors at 0.19.2.
Identity PASS: 28 Lua files, 35 sandbox options, translation bindings,
case-correct internal requires and Workshop mirrors. Host runner PASS:
26 Lua regressions and 28 syntax checks, zero failures, isolated Lua 5.1 only.
These baseline regressions do not execute Project Zomboid.

[VERIFIED: installed source] 26 relevant curated API records were rechecked
against matching installed vanilla Lua hashes, with 11 additional direct source
observations. Steam build 25485521; full engine semantic version UNKNOWN.
Exact paths, line ranges, signatures and limits are in api-evidence.json.

[TESTED: offline Windows] The portable census was exercised against temporary,
project-authored fixtures: metadata identification, oversized-text reporting,
omission of source bodies, refusal to overwrite prior evidence, rejection of an
output within a source root, and unchanged source hashes passed. Fixture Lua
was read as text and never loaded. The audit/check scripts also passed Python
syntax compilation without writing production runtime code.

[VERIFIED: census] The actual downloaded corpus had zero read errors, 18
oversized-text omissions and no linked-path omissions. See LIMITS.md. Binary
assets were enumerated, not decoded or hashed. A text-corpus fingerprint is
not a package-integrity or binary-equivalence claim. Public descriptions and
current installed metadata remain separate evidence layers.

[RUNTIME GATE] SP and dedicated multiplayer NOT TESTED. No game/server launch,
deployment, packaging or Workshop publication occurred. G7 and stable G8 remain
BLOCKED for gameplay. Independent clean-room reviewer signoff is PENDING;
implementation has not started. No stable release tag is appropriate.
