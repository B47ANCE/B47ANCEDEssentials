# Rename compatibility

Version `0.19.0` names the project **B47ANCE'd Essentials**. Its Mod ID, public
Lua global, Lua directory/require prefix, client/server command module, sandbox
page/options namespace, translation prefix and debug-command prefix are all
`B47ANCEDEssentials`. No old public API or module aliases are registered.

The project directory is `B47ANCEDEssentials`; runtime source remains under
`Contents/mods/B47ANCEDEssentials/42`. The existing Workshop ID is `3788591728`.
Workshop title/description/changenote files are local upload inputs only; this
rename does not update the live Workshop item or locally installed mods.

## Configuration and integrations

Previously the public identity was `itjustWorks`. Existing server `Mods=` lists,
client mod selections, sandbox presets/options and consumers of the old Lua
namespace must be updated together. Enable only the new identity. Mixed client
and server identities do not share command channels. Sandbox values are not
automatically copied from the old namespace: transfer intended values into the
new options before starting an existing save; otherwise their declared defaults
apply. Options, defaults and bounds themselves are unchanged.

Other mod repositories and installed mods are outside this rename's scope.
They may still reference the old public namespace and require coordinated
changes before combined use. The old ecosystem mass-test callback chain is
not verified with the new command names.

## Persisted state exceptions

These are serialized compatibility keys, not current public branding:

| Existing key | Owner | Reason retained |
| --- | --- | --- |
| `itjustWorks.HeavyObjects.v1` | Authoritative server/SP ModData | Preserve operation/replay history and reservations. |
| `itjustWorksGuidedTest` | Character guided-test state | Preserve recorded progress and results. |
| `itjustWorksTestKitGranted` | Character test-kit flag | Prevent duplicate grants. |

The serialized schema remains `1`; there is no copy, deletion or live-save
migration. Native hotbar slot storage and item IDs are unchanged. Keeping these
keys is covered by host fixtures, not native save validation. Test old-save
reload, repeat reload, reconnect and dedicated restart on disposable fixtures.
Downgrading public IDs/configuration still requires restoring matching old
client/server installations; no general downgrade guarantee is made.

## Evidence and historical artifacts

The user authorized offline work and root `VERSION` establishment at `0.19.0`
on 2026-10-16. The pre-1.0 identity break is classified MINOR. Source freshness
was UNKNOWN at rename time because no Git repository/remote existed; the
iteration was then NOT BACKED UP to GitHub. Public repository onboarding was
separately authorized on 2026-10-17; see [GITHUB_ONBOARDING.md](GITHUB_ONBOARDING.md).

Historical `dist/` packages/staging, `SHA256SUMS.txt`, upload receipt, the runtime
icon and Workshop item identity retain exact bytes. The preview/poster title was
updated with the built-in image tool, with originals backed up. Archived names/metadata describe
their original versions. Historical test/audit claims do not become 0.19.0 proof.
The older roadmap's Java authorization is superseded by current Lua-only policy.

[TESTED — offline] Source regressions run with Python/lupa Lua 5.1, not PZ.
[RUNTIME GATE] SP NOT TESTED; dedicated G7 BLOCKED / NOT TESTED; stable-release
G8 BLOCKED. No package, deployment, server launch or Workshop upload is authorized
by this rename. See [VALIDATION_0.19.0.md](VALIDATION_0.19.0.md) for exact commands.
