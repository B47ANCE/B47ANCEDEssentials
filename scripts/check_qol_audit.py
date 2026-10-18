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
    review = json.loads((AUDIT / 'vanilla-review.json').read_text(encoding='utf-8'))
    decisions = {entry['id']: entry for entry in review['entries']}
    assert len(decisions) == len(review['entries']) == summary['vanilla_review_entries'] == 116
    counts = {key: sum(e['decision'] == key for e in review['entries']) for key in review['decision_counts']}
    assert counts == review['decision_counts'] == summary['vanilla_review_decisions']
    prior_ids = {ident for p in packages for ident in p['pre_vanilla_review_capabilities']} | {'inventory-search'}
    assert set(decisions) == prior_ids, 'Prior capability omitted or invented during native filtering'
    assert set(review['preserved_essentials_ids']) == {e['id'] for e in review['entries'] if e.get('existing_essentials_preserved')}
    baseline = json.loads((AUDIT / 'vanilla-baseline.json').read_text(encoding='utf-8'))['entries']
    baseline_ids = {entry['id'] for entry in baseline}
    assert 'inventory-search' in baseline_ids
    assert not baseline_ids.intersection(c['id'] for c in caps), 'Vanilla baseline must not be proposed as new work'
    assert baseline_ids == {e['id'] for e in review['entries'] if e['decision'] == 'REMOVE_VANILLA'}
    expected_active = {e['id'] for e in review['entries'] if e['decision'] in ('KEEP_EXISTING', 'RETAIN_DELTA')}
    assert {c['id'] for c in caps} == expected_active, 'Held, duplicate or native-only entry in ranking'
    for ident in review['preserved_essentials_ids']:
        assert ident in expected_active or (decisions[ident]['decision'] == 'MERGE' and decisions[ident]['merged_into'] in expected_active)
    for entry in review['entries']:
        assert entry['evidence_groups'] and entry['runtime_status'] == 'NOT_TESTED'
        assert all(group in review['evidence_groups'] for group in entry['evidence_groups'])
    for files in review['evidence_groups'].values():
        assert files
        for evidence in files:
            assert re.fullmatch('[a-f0-9]{64}', evidence['sha256'])
            assert evidence['scope_lines'][0] == 1
            assert all(1 <= n <= evidence['scope_lines'][1] for n in evidence['anchor_lines'])
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
    # The original portfolio plans remain separately scoped history.
    top_plan = (AUDIT / catalog['plan_document']).read_text(encoding='utf-8')
    ranking = (AUDIT / 'RANKING.md').read_text(encoding='utf-8')
    package_table = (AUDIT / 'PACKAGES.md').read_text(encoding='utf-8')
    for rank, capability in enumerate(caps, 1):
        assert rank == capability['rank']
        assert capability['vanilla_review']['decision'] == decisions[capability['id']]['decision']
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
            assert set(capability['plan']['depends']) <= expected_active
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
    portfolio = json.loads((AUDIT / 'portfolio-ownership.json').read_text(encoding='utf-8'))
    assert portfolio['essentials_version'] == summary['base_version']
    projects = {p['id']: p for p in portfolio['projects']}
    assert len(projects) == len(portfolio['projects']) == 28
    owners = {f['id']: f for f in portfolio['features']}
    assert len(owners) == len(portfolio['features']) == len(caps)
    assert set(owners) == cap_ids
    for project in projects.values():
        assert project['evidence'] and project['scope']
        for entry in project['evidence']:
            assert sha.fullmatch(entry['sha256'])
            assert entry['anchor_line'] >= 1
            assert not Path(entry['path']).is_absolute() and '..' not in Path(entry['path']).parts
    for capability in caps:
        owner = owners[capability['id']]
        assert owner['rank'] == capability['rank']
        assert owner['recommended_owner'] == capability['proposed_owner']
        assert capability['portfolio_review']['coverage'] == owner['portfolio_coverage']
        assert capability['portfolio_review']['recommendation'] == owner['recommendation']
        assert set(owner['evidence_projects']) <= projects.keys()
        assert f'owner {owner["recommended_owner"]}; Essentials coverage' in ranking
        if capability['rank'] <= 25:
            assert f'owner **{owner["recommended_owner"]}**;' in top_plan
            assert owner['recommendation'] in top_plan
    assert owners['area-clean']['portfolio_coverage'] == 'COVERED_SOURCE'
    assert owners['area-clean']['recommended_owner'] == 'Auto Clean'
    assert owners['bandage-queue']['recommended_owner'] == owners['treatment-queue']['recommended_owner'] == 'Health Care'
    essentials = json.loads((AUDIT / 'essentials-only.json').read_text(encoding='utf-8'))
    current_plan = (AUDIT / 'TOP_25_PLAN.md').read_text(encoding='utf-8')
    current_ranking = (AUDIT / 'ESSENTIALS_RANKING.md').read_text(encoding='utf-8')
    assert essentials['version'] == summary['base_version']
    dispositions = {e['id']: e for e in essentials['decisions']}
    assert len(dispositions) == len(essentials['decisions']) == len(caps)
    assert set(dispositions) == cap_ids
    eligible = essentials['eligible']
    eligible_ids = {e['id'] for e in eligible}
    assert len(eligible_ids) == len(eligible) == 29
    retained = {c['id'] for c in caps if c['essentials_status'] != 'NEW'}
    assert set(essentials['existing_retained']) == retained
    assert len(retained) == 20
    assert len([e for e in dispositions.values() if e['decision'] == 'EXCLUDE_OTHER_DOMAIN']) == 15
    assert eligible_ids == {e['id'] for e in dispositions.values() if e['decision'] != 'EXCLUDE_OTHER_DOMAIN'}
    assert eligible == sorted(eligible, key=lambda e: (-e['impact_score'], e['id']))
    additions = [e for e in eligible if e['id'] not in retained]
    assert essentials['new_selected'] == [e['id'] for e in additions[:5]]
    selected = sorted(retained | set(essentials['new_selected']), key=lambda ident: (-next(e['impact_score'] for e in eligible if e['id'] == ident), ident))
    assert len(selected) == len(set(selected)) == 25
    assert essentials['top_25_ids'] == selected
    assert retained <= set(selected)
    for ident in review['preserved_essentials_ids']:
        assert (ident in selected) or (decisions[ident]['decision'] == 'MERGE' and decisions[ident]['merged_into'] in selected)
    for rank, entry in enumerate(eligible, 1):
        assert entry['eligible_rank'] == rank
        assert entry['owner'] == 'Essentials'
        original = next(c for c in caps if c['id'] == entry['id'])
        assert entry['dimensions'] == original['dimensions']
        assert entry['impact_score'] == original['impact_score']
        assert entry['essentials_status'] == original['essentials_status']
        assert entry['scope_boundary'] and entry['title'] in current_ranking
        if entry['id'] in selected:
            selected_rank = selected.index(entry['id']) + 1
            assert entry['selected_rank'] == selected_rank
            assert f'## {selected_rank}. {entry["title"]}' in current_plan
            assert entry['scope_boundary'] in current_plan
            assert entry['plan']['slice'] in current_plan
            assert set(entry['plan']['depends']) <= set(selected)
            assert set(entry['plan']['api_groups']) <= review['evidence_groups'].keys()
            for name in entry['plan']['existing']:
                assert len(list((ROOT / 'Contents/mods').rglob(name))) == 1
        else:
            assert entry['selected_rank'] is None and 'plan' not in entry
    assert len(re.findall(r'^## \d+\. ', current_plan, flags=re.M)) == 25
    assert essentials['runtime_status'] == 'NOT TESTED'
    assert essentials['independent_review'] == 'PENDING'
    for path in AUDIT.rglob('*'):
        if path.is_file():
            text = path.read_text(encoding='utf-8')
            assert not re.search(r'[A-Za-z]:[\\/](?:Users|Program Files)', text), path.name
    print(f'PASS: {len(packages)} instances, {len(workshop_ids)} Workshop IDs; {len(caps)} portfolio entries; Essentials-only 29 eligible, 15 excluded, top 25 = 20 retained + 5 new (offline).')


if __name__ == '__main__':
    main()
