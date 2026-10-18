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

[TESTED: offline Windows, initial commit 4a9caf0] Report accounting and deterministic scoring PASS:
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

## First vanilla baseline correction at dc5c064

Following the project owner correction, inventory search/filtering is baseline
functionality and no longer a proposed implementation. The ranking at that correction
contained 115 candidates; nearby loot is first, and recipe-dependency browsing
moves into the top 25. The census and provenance observations are unchanged.
All candidates explicitly require a demonstrated vanilla gap before work begins.

The audit checker now prevents vanilla-baseline entries from appearing as
ranked implementation candidates. Current audit, version and identity checks
PASS offline. This correction adds no runtime evidence or gameplay changes.

## Complete vanilla recheck

[TESTED: offline Windows] The current audit checker accounts for all 116 prior
requirements: 37 native-covered entries removed, 33 unproven entries held, two
duplicates merged, and 44 retained entries. All 21 prior Essentials source or
foundation identifiers are represented, including the container-inspection alias
under nested-view. The top 25 has been regenerated from the retained scores.

The checker now enforces exact decision/active/baseline partitions, complete
coverage, evidence-group references, preservation of existing Essentials, score
calculations and 25 complete plans with live dependencies. Targeted comparisons
cover 63 installed vanilla Lua files across 26 evidence groups; each file has a
portable hash and reviewed scope. Source absence is not claimed from a text
search alone. Existing inventory search exclusion remains owner-confirmed; its
full-text binding is still not independently established in installed Lua.

Current report, version, identity, Markdown link and source-hash checks PASS
offline. The earlier 26-host-test result is historical baseline support; no
runtime source changed and it is not new SP or dedicated evidence. Independent
clean-room signoff remains pending; no deploy, package, upload or game launch.
# Portfolio ownership audit — 2026-10-18

Documentation-only continuation at Essentials 0.19.2 from research source commit
`ff59b1e877e9cc09e1481e33bb04e72356eafb81`. The portfolio ledger records 28 primary
local projects and all 44 retained capability decisions. Other project checkouts,
including dirty work, were read only. No runtime source, version, identity,
dependency, configuration or package changed. Scores and top-25 membership remain
the same; existing Auto Clean coverage now replaces duplicate implementation work.

[TESTED — offline] Commands from the Essentials repository using its development
Python environment:

```powershell
python scripts/check_qol_audit.py
python scripts/check_versions.py
python scripts/check_identity.py
git diff --check
```

All PASS. The report checker now verifies the 28-project/44-feature ownership
ledger, owner mirrors, evidence references and the explicit Auto Clean/Health Care
dispositions in addition to the existing census and vanilla accounting. A separate
read-only hash/link pass checked 135 recorded evidence entries (including 38
mod.info candidates), local Markdown file links and unchanged runtime source.
Essentials README's pre-edit hash was verified against the recorded source commit;
other evidence hashes matched their local snapshot files. These are provenance
checks, not proof of domain correctness or feature absence.

Freshness before editing: PASS; HEAD/upstream `ff59b1e877e9`, ahead/behind 0/0,
main ahead 3 / behind 0, clean, no unfinished operation. Other projects' remote
freshness was not checked and their local features are not claimed merged,
released, installed or runtime verified. Pre-commit freshness returned REVIEW solely for these understood audit edits;
HEAD/upstream still matched, main behind 0, no unfinished operation. The public
tracked/staged scan passed for 127 files, including credential-pattern, linked-file,
generated-artifact, case-collision and overview-digest checks.

No new gameplay test suite was needed for documentation/report consistency edits.
Earlier host and vanilla evidence below retain their exact historical scope.
SP/dedicated NOT TESTED; G7/stable G8 and independent clean-room signoff unchanged.
No game/server launch, deployment, package or Workshop upload.

# Essentials-only selection — 2026-10-18

Documentation-only continuation from `84009973a446f62595032dfcfc006d53b07981ee`
at canonical version 0.19.2. The current plan replaces the cross-project top 25
with a preservation-constrained Essentials list: 20 retained entries (11
implemented, five partial, four foundations) plus five new proposals. All 21
original source/foundation identifiers remain represented through 20 entries;
container-open remains merged into nested-view.

The 44-entry portfolio comparison is preserved. Current eligibility accounts
for all 44: 29 Essentials-scoped entries and 15 other-domain exclusions. Retain
all 20 existing entries, add the five highest-scored eligible NEW proposals,
then sort that selected set by score/ID. Four new eligible ideas remain backlog.
This is not an unrestricted highest-25 selection, and no new capability or
artificial subdivision was added to fill slots. Narrowed Essentials boundaries
exclude foreign gameplay systems and broad presentation ownership.

[TESTED — offline] Exact project commands:

```powershell
python scripts/check_qol_audit.py
python scripts/check_versions.py
python scripts/check_identity.py
git diff --check
```

All PASS. The report checker covers the historical census/portfolio evidence,
all 44 current scope decisions, 29 eligibility ranks, all retained identifiers,
20+5 selection rule, 25 plans, selected dependencies, source-file links and
native evidence-group references. Version checks confirm nine mirrors at
0.19.2; identity checks cover 28 Lua files and 35 sandbox options plus metadata,
translations and case-correct internal requires. A separate read-only pass
confirmed all audit local Markdown file links, exact preservation of the prior
portfolio plan body and no runtime-source/VERSION changes.

Startup freshness PASS: HEAD/upstream `84009973a446`, ahead/behind 0/0,
main ahead 4 / behind 0, clean, no unfinished operation. Pre-commit freshness
REVIEW was solely these understood research edits; ancestry remained unchanged.
Public tracked/staged-tree credentials/artifacts/overview checks run before push.
No new gameplay tests were needed for documentation and report-consistency
changes; prior host/API/runtime evidence is not relabeled as current proof.
SP/dedicated NOT TESTED; G7/stable G8 and independent clean-room signoff remain
unchanged. No package, deploy, Workshop upload or game/server launch.
