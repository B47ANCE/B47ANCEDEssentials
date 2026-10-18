"""Check canonical project version mirrors; optionally inspect a release ZIP."""
from pathlib import Path
import argparse
import re
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MOD = 'B47ANCEDEssentials'
MIRRORS = {
    'README.md': r'- Version: `([^`]+)`',
    f'Contents/mods/{MOD}/42/mod.info': r'^modversion=(\S+)',
    f'Contents/mods/{MOD}/info.txt': r'^Version: (\S+)',
    f'Contents/mods/{MOD}/42/media/lua/client/{MOD}/TestKit.lua': r'version=([0-9.]+) feature status',
    'docs/MASTER_ROADMAP.md': r'Current version: `([^`]+)`',
    'WORKSHOP_DESCRIPTION.txt': r'Mod Version: ([0-9.]+)',
    'workshop.txt': r'Mod Version: ([0-9.]+)',
    'WORKSHOP_CHANGE_NOTE.txt': r'^\[b\]Version ([0-9.]+)\[/b\]',
    'CHANGELOG.md': r'\A# Changelog\s+## ([0-9.]+) ',
}

def check(release=False):
    version = (ROOT / 'VERSION').read_text(encoding='utf-8').strip()
    errors = []
    if not re.fullmatch(r'(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)', version):
        errors.append('VERSION must contain one canonical X.Y.Z version')
    for name, pattern in MIRRORS.items():
        text = (ROOT / name).read_text(encoding='utf-8-sig')
        matches = re.findall(pattern, text, re.MULTILINE)
        if matches != [version]:
            errors.append(f'{name}: expected one {version!r} mirror; found {matches!r}')
    if release:
        archives = list((ROOT / 'dist').glob(f'{MOD}-{version}*.zip'))
        if not archives:
            errors.append('No current release ZIP; historical archives are not current release evidence')
        for archive in archives:
            try:
                with zipfile.ZipFile(archive) as package:
                    names = package.namelist()
                    folded = [name.casefold() for name in names]
                    if len(folded) != len(set(folded)):
                        errors.append(f'{archive.name}: duplicate/case-colliding members')
                    for name in names:
                        if '\\' in name or name.startswith('/') or ':' in name or '..' in Path(name).parts:
                            errors.append(f'{archive.name}: unsafe member {name!r}')
                    if package.testzip():
                        errors.append(f'{archive.name}: CRC/data failure')
                    metadata = [name for name in names if name.endswith('/mod.info')]
                    if not metadata:
                        errors.append(f'{archive.name}: missing mod.info')
                    for name in metadata:
                        text = package.read(name).decode('utf-8-sig')
                        if not re.search(rf'^modversion={re.escape(version)}\s*$', text, re.MULTILINE):
                            errors.append(f'{archive.name}: stale version in {name}')
                        if not re.search(rf'^id={MOD}\s*$', text, re.MULTILINE):
                            errors.append(f'{archive.name}: stale Mod ID in {name}')
            except (OSError, ValueError, zipfile.BadZipFile) as exc:
                errors.append(f'{archive.name}: {exc}')
    for error in errors:
        print('FAIL:', error)
    if not errors:
        print(f'PASS: VERSION {version}; {len(MIRRORS)} current mirrors synchronized (offline).')
    return bool(errors)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--release', action='store_true')
    sys.exit(check(parser.parse_args().release))
