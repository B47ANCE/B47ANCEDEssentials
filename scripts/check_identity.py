"""Offline checks for the renamed source identity, paths and localized options."""
from pathlib import Path
import json
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
MOD = 'B47ANCEDEssentials'
DISPLAY = "B47ANCE'd Essentials"
BASE = ROOT / 'Contents/mods' / MOD / '42'

def exact_file(path):
    relative = path.relative_to(ROOT)
    parent = ROOT
    for part in relative.parts:
        if not parent.is_dir() or part not in {entry.name for entry in parent.iterdir()}:
            return False
        parent /= part
    return parent.is_file()

def check():
    errors = []
    def expect(condition, message):
        if not condition:
            errors.append(message)
    metadata = dict(line.split('=', 1) for line in (BASE / 'mod.info').read_text().splitlines() if '=' in line)
    expect(metadata.get('name') == DISPLAY, 'mod.info display name')
    expect(metadata.get('id') == MOD, 'mod.info Mod ID')
    expect(metadata.get('versionMin') == '42.20.3', 'game minimum unexpectedly changed')
    expect((ROOT / 'WORKSHOP_ID.txt').read_text().strip() == '3788591728', 'Workshop ID changed')
    expect(not (ROOT / 'Contents/mods/itjustWorks').exists(), 'old runtime mod directory remains')
    info = (ROOT / f'Contents/mods/{MOD}/info.txt').read_text(encoding='utf-8')
    expect(info.splitlines()[0] == DISPLAY and f'Mod ID: {MOD}' in info, 'info.txt identity')
    lua_files = list((BASE / 'media/lua').rglob('*.lua'))
    for path in lua_files:
        text = path.read_text(encoding='utf-8')
        for module in re.findall(r'\brequire\s*\(?\s*["\']([^"\']+)', text):
            if module.startswith(MOD + '/'):
                expect(any(exact_file(BASE / f'media/lua/{side}/{module}.lua')
                           for side in ('shared', 'client', 'server')),
                       f'{path.name}: missing/case-incorrect require {module}')
        remainder = text
        for key in ('itjustWorks.HeavyObjects.v1', 'itjustWorksGuidedTest', 'itjustWorksTestKitGranted'):
            remainder = remainder.replace(key, '')
        expect('itjustworks' not in remainder.casefold(), f'{path.name}: stale runtime identity')
    options = (BASE / 'media/sandbox-options.txt').read_text(encoding='utf-8')
    declarations = re.findall(r'option\s+(\w+)\.(\w+)\s*\{([^}]+)\}', options)
    translations = json.loads((BASE / 'media/lua/shared/Translate/EN/Sandbox.json').read_text(encoding='utf-8'))
    expect(translations.get('Sandbox_' + MOD) == DISPLAY, 'sandbox page display name')
    expect(len({name for _, name, _ in declarations}) == len(declarations), 'duplicate sandbox option names')
    for namespace, name, body in declarations:
        expect(namespace == MOD, f'{name}: stale option namespace')
        expect(re.search(rf'\bpage\s*=\s*{MOD}\s*,', body), f'{name}: sandbox page')
        expect(re.search(rf'\btranslation\s*=\s*{MOD}_{name}\s*,', body), f'{name}: translation binding')
        expect(f'Sandbox_{MOD}_{name}' in translations, f'{name}: missing English name')
    context = (BASE / 'media/lua/shared/Translate/EN/ContextMenu_EN.txt').read_text(encoding='utf-8')
    keys = set(re.findall(r'^\s*((?:ContextMenu|IGUI)_\w+)\s*=', context, re.MULTILINE))
    for path in lua_files:
        for key in re.findall(r'["\']((?:ContextMenu|IGUI)_' + MOD + r'_\w+)["\']', path.read_text(encoding='utf-8')):
            expect(key in keys, f'{path.name}: untranslated {key}')
    workshop = (ROOT / 'workshop.txt').read_text(encoding='utf-8')
    lines = workshop.splitlines()
    expect('title=' + DISPLAY in lines, 'Workshop title')
    expect(not any(line.startswith('visibility=') for line in lines), 'Workshop visibility must be preserved by omission')
    description = '\n'.join(line.removeprefix('description=') for line in lines if line.startswith('description='))
    expect(description == (ROOT / 'WORKSHOP_DESCRIPTION.txt').read_text(encoding='utf-8').rstrip('\n'), 'Workshop description mirror')
    expect(f'Mod ID: {MOD}' in description, 'Workshop description Mod ID')
    for path in (ROOT / 'Contents').rglob('*'):
        expect(path.suffix.lower() not in ('.java', '.jar', '.class'), f'active custom Java artifact: {path}')
    for error in errors:
        print('FAIL:', error)
    if not errors:
        print(f'PASS: {MOD} metadata, {len(lua_files)} Lua files, {len(declarations)} sandbox options, '
              'translation bindings, case-correct internal requires and Workshop mirrors (offline).')
    return bool(errors)

if __name__ == '__main__':
    sys.exit(check())
