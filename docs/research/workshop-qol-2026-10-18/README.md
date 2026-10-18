# Downloaded Workshop quality of life audit

The [portfolio ownership audit](PORTFOLIO_OWNERSHIP.md) checks all 44 retained entries against 28 local projects, identifies existing coverage and corrects proposed owners. Auto Clean already covers selected-area cleaning; SPXTRM is the lighting owner, UI is presentation, and Health Care owns treatment.

The complete vanilla recheck leaves **44 ranked entries**: **20 existing Essentials entries** and **24 specific additions**. Every prior requirement is accounted for in [the comparison matrix](VANILLA_RECHECK.md): **37 native-covered proposals removed**, **33 uncertain proposals held outside the ranking**, and **2 duplicates merged**. All 21 original Essentials source/foundation identifiers remain represented; container inspection is included under nested inspection rather than counted twice.

The downloaded census remains **595 copies / 592 distinct Workshop IDs** (591 Steam-client folders and four SteamCMD-cache folders). The [new top 25](TOP_25_PLAN.md) retains existing Essentials features and plans only the specific remaining workflow. Native search, recipe requirements/favorites, map centering/legend/sharing, ordinary medical consent and other existing controls are not proposed as new features.

- [Complete vanilla recheck and all removals](VANILLA_RECHECK.md)
- [Top 25 implementation plans](TOP_25_PLAN.md)
- [Complete impact ranking](RANKING.md)
- [Every downloaded package and its disposition](PACKAGES.md)
- [Vanilla API evidence and native overlap](API_EVIDENCE.md)
- [Excluded mechanics and unresolved boundaries](EXCLUSIONS.md)
- [Validation commands and results](VALIDATION.md)
- [Exact scan omissions](LIMITS.md)
- [Vanilla baseline exclusions](vanilla-baseline.json)
- [Clean-room review checklist](CLEAN_ROOM_REVIEW.md)
- Machine-readable records: [summary](summary.json), [packages](packages.json), [capabilities and plans](capabilities.json), [API evidence](api-evidence.json).

## Scope and evidence

[VERIFIED] This is a read-only filesystem and declaration census dated 2026-10-18. It enumerated 345,223 files, including 16,956 Lua files, and read/fingerprinted 114,197 eligible text files. All installed mod.info variants remain in the ledger; they are not counted as separate features. SteamCMD copies retain separate provenance. Their text revision comparisons are in summary.json; binary asset identity was not checked.

The inventory includes metadata, file/module names, lexical public-interface/event signals, sandbox declarations, English presentation declarations and package documentation. Public Workshop metadata was retrieved without authentication for discovery context. Publisher descriptions can describe a newer revision than the downloaded files. Their hashes/timestamps are recorded separately and their bodies are not redistributed. Installed author/version values absent from metadata remain UNKNOWN; a text-corpus hash identifies the inspected revision without inventing a release version.

[INFERRED] Neutral capabilities and package dispositions are analytical conclusions from those surfaces. This is broad static capability coverage, not manual line-by-line correctness review, a measured benchmark, or proof that every latent feature inside executable/native/opaque content has been discovered. No third-party Lua was loaded or executed. No saves, player inventories or private server logs were inspected. Downloaded does not mean enabled, compatible, current, licensed for reuse or runtime-verified.

The census found 0 read errors, 18 text files above the 2,000,000-byte read limit, and 0 linked paths omitted. Exact exceptions remain attached to each instance in packages.json. Binary assets were enumerated but not decoded or hashed. License filename/header hints are discovery evidence only; license scope and redistribution permission remain uncleared. **Code, assets, algorithms, UI text and translations imported into implementation: NONE.** Factual names, identifiers, filenames and hashes are retained for provenance.

Scope roots are the discovered Steam-client and SteamCMD content/108600 trees. Other registered library locations had no such content tree. Partial downloads, deleted subscriptions, archives outside those Workshop trees, remotely owned content and uninstalled versions are not represented. The scan is a point-in-time read, not an atomic filesystem snapshot; rerun and compare before relying on a changed installed revision.

## Ranking method

Impact = `(30 × frequency + 25 × reach + 25 × friction + 10 × error prevention + 10 × accessibility) / 5`. Every dimension is an ordinal judgment from 1 to 5. Frequency ranges from exceptional/setup use to recurring play-session use; reach from a specialist workflow to most survival players; friction from a minor cue to repeated multi-step work; error prevention from cosmetic benefit to avoiding common costly mistakes; accessibility from a small convenience to a substantial reduction in input or interpretation burden.

Scores estimate the **remaining workflow benefit after subtracting native coverage**, or the value of an existing Essentials feature retained at the user's request. These are not measured time savings, popularity, implementation priority or proof of feasibility. Condition, capacity, source-return and generator scores were reduced after their native overlap was subtracted. Equal scores are tied and ordered by stable capability ID. Scopes were narrowed rather than using a cosmetic rewording to preserve a vanilla feature's old score.

The review covers 63 distinct installed vanilla Lua files across 26 evidence groups. Native-positive paths have portable hashes, scope ranges and anchor lines in vanilla-review.json. Additional behavior is inferred only within the inspected paths; no method-name search proves engine-wide absence. Unresolved native-renderer, usability, authority and Lua-access questions are excluded from the ranking. A future implementation must still reproduce the specific native-only gap and validate the exact API/authority contract.

Treat differences of roughly five points as an uncertainty band. Equal scores are tied and sorted by stable capability ID only. Reweighting for a dedicated-server administrator, controller-only player or builder can change the order. The top 25 follows this published formula, rather than silently choosing only new work.

Coverage labels describe Essentials source at the audited base: IMPLEMENTED is source behavior, PARTIAL is narrower source coverage, and FOUNDATION is supporting code without the full user workflow. NEW means absent from Essentials, not absent from vanilla. The separate comparison disposition determines inclusion: KEEP_EXISTING follows the user exception, RETAIN_DELTA has a specific scoped difference, REMOVE_VANILLA is excluded, HOLD_UNPROVEN is excluded, and MERGE links a duplicate to its retained owner. Foundations do not become implemented interfaces, combat or physics. None of these labels means runtime PASS.

## Implementation boundaries

The audit is tied to Essentials **0.19.2**, base commit `ee5c66a24878fc5a000a07224957f6177e3999fa`, Git tree `860960f2463268869f297a66c0c41169137ef364`, runtime subtree `b10544a12bbaca8c6dca3ff6c2e6ad43e1a5f86c`. It changes research documentation and development-only read/check tools. It makes no gameplay, identity, dependency, sandbox, packaging or Workshop changes. No new project version is established for this plan.

[VERIFIED] Installed Steam app build is **25485521**. Full engine semantic version is **UNKNOWN**; Essentials' minimum 42.20.3 is a project requirement, not proof of the installed engine's full version. Relevant vanilla evidence was rechecked by hash. Native calls and UI source presence do not establish a complete extension, server-authority or Lua-exposure contract.

[RUNTIME GATE] No game/server was launched. SP and dedicated multiplayer are NOT TESTED. G7 and stable G8 remain BLOCKED for gameplay changes. No deployment or Workshop upload occurred. Independent clean-room reviewer signoff is PENDING; the research PR must remain a draft until that review is supplied. This is an engineering separation plan, not a legal certification.

## Reproduce and validate

Use the project's Python environment; commands run from the repository root:

```powershell
python scripts/check_qol_audit.py
python scripts/check_versions.py
python scripts/check_identity.py
python scripts/audit_workshop_metadata.py --root '<Steam client content/108600>' --root '<SteamCMD content/108600>' --out '<new private census.json>'
```

The portable census never executes external code or contacts Steam. Supply verified roots and a fresh private output path; it refuses to overwrite old evidence. The original discovery pass additionally collected lexical signals and current public declarations privately. The committed ledger is sanitized and contains original neutral analysis, not those raw bodies. Automated checks prove coverage accounting, deterministic scoring, links and evidence labels; they cannot prove subjective rankings or legal independence.
