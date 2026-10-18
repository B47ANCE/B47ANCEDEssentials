"""Validate the portable QoL audit's coverage, scoring and provenance links."""
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / 'docs/research/workshop-qol-2026-10-18'


def main():
    summary = json.loads((AUDIT / 'summary.json').read_text(encoding='utf-8'))
    package_data = json.loads((AUDIT / 'packages.json').read_text(encoding='utf-8'))
    catalog = json.loads((AUDIT / 'capabilities.json').read_text(encoding='utf-8'))
    packages = package_data['instances']
    caps = catalog['capabilities']
    sha = re.compile(r'^[a-f0-9]{64}$')
    assert summary == package_data['snapshot'], 'Diverging snapshot summary'
    assert summary['base_version'] == (ROOT / 'VERSION').read_text().strip()
    assert len(packages) == summary['instances']
    assert len({p['instance'] for p in packages}) == len(packages)
    workshop_ids = {p['workshop_id'] for p in packages}
    assert len(workshop_ids) == summary['unique_workshop_ids']
    assert len(caps) == summary['ranked_capabilities']
    assert len({c['id'] for c in caps}) == len(caps)
    expected = sorted(caps, key=lambda c: (-c['impact_score'], c['id']))
    assert caps == expected
    weights = catalog['weights']
    assert sum(weights.values()) == 100
    top_plan = (AUDIT / 'TOP_25_PLAN.md').read_text(encoding='utf-8')
    ranking = (AUDIT / 'RANKING.md').read_text(encoding='utf-8')
    package_table = (AUDIT / 'PACKAGES.md').read_text(encoding='utf-8')
    for rank, capability in enumerate(caps, 1):
        assert rank == capability['rank']
        dims = capability['dimensions']
        assert dims.keys() == weights.keys()
        assert all(isinstance(v, int) and 1 <= v <= 5 for v in dims.values())
        score = sum(dims[key] * weight for key, weight in weights.items()) / 5
        assert score == capability['impact_score']
        assert capability['source_workshop_ids']
        assert set(capability['source_workshop_ids']) <= workshop_ids
        assert f'## {rank}. {capability["title"]}' in ranking
        assert f'| {rank} | [{capability["title"]}](#{capability["id"]}) | {score:g} |' in ranking
        if rank <= 25:
            assert capability.get('plan')
            assert f'## {rank}. {capability["title"]}' in top_plan
            for name in capability['plan']['existing']:
                assert len(list((ROOT / 'Contents/mods').rglob(name))) == 1
        else:
            assert 'plan' not in capability
    cap_ids = {c['id'] for c in caps}
    for p in packages:
        assert sha.fullmatch(p['text_corpus_sha256'])
        assert set(p['capabilities']) <= cap_ids
        assert p['disposition'] and p['rationale']
        assert p['title'].replace('|', '/') in package_table or '&' in p['title'] or '<' in p['title'] or '>' in p['title']
        assert p['permission_to_reuse'].startswith('NONE')
        for m in p['metadata']:
            assert sha.fullmatch(m['sha256'])
            assert not m['path'].startswith(('/', '\\')) and '..' not in Path(m['path']).parts
    for field, expression in [
        ('files_enumerated', lambda p: p['file_count']),
        ('lua_files_enumerated', lambda p: p['lua_file_count']),
        ('text_files_read', lambda p: p['text_files_read']),
        ('mod_info_instances', lambda p: len(p['metadata'])),
    ]:
        assert sum(map(expression, packages)) == summary[field], field
    api = json.loads((AUDIT / 'api-evidence.json').read_text())
    assert api['steam_build'] == summary['steam_build']
    assert all(e['hash_recheck'] == 'MATCH' for r in api['curated_rechecks'] for e in r['evidence'])
    assert all(r['runtime_status'] == 'NOT_TESTED' for r in api['curated_rechecks'] + api['observations'])
    assert summary['clean_room_independent_review'] == 'PENDING'
    assert summary['sp_runtime'] == summary['dedicated_runtime'] == 'NOT TESTED'
    for path in AUDIT.rglob('*'):
        if path.is_file():
            text = path.read_text(encoding='utf-8')
            assert not re.search(r'[A-Za-z]:[\\/](?:Users|Program Files)', text), path.name
    print(f'PASS: {len(packages)} instances, {len(workshop_ids)} Workshop IDs, {len(caps)} scored capabilities, 25 plans, provenance and evidence limits (offline).')


if __name__ == '__main__':
    main()
