"""Read-only, portable Workshop metadata census; never loads external Lua.

Output contains provenance and identifiers, not source bodies or translations.
Supply explicit Workshop content/108600 roots and a private output destination.
No game, network, authentication, repository edits or upstream mutations occur.
"""
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import re
import stat

TEXT = {'.lua', '.txt', '.json', '.md', '.info', '.xml', '.ini', '.cfg', '.js', '.html', '.properties'}
NATIVE = {'.jar', '.java', '.class', '.dll', '.so', '.dylib', '.exe'}
MAX_TEXT = 2_000_000


def linked(path):
    value = path.lstat()
    return path.is_symlink() or bool(getattr(value, 'st_file_attributes', 0) & getattr(stat, 'FILE_ATTRIBUTE_REPARSE_POINT', 0x400))


def scan(package):
    row = {'workshop_id': package.name, 'mods': [], 'file_count': 0,
           'text_files_read': 0, 'text_bytes_read': 0, 'native_files': [],
           'license_evidence': [], 'read_errors': [], 'oversized_text': [], 'linked_paths': []}
    fingerprint = hashlib.sha256()
    for directory, dirs, names in os.walk(package, followlinks=False):
        parent = Path(directory)
        for name in list(dirs):
            path = parent / name
            if linked(path):
                row['linked_paths'].append(path.relative_to(package).as_posix())
                dirs.remove(name)
        dirs.sort()
        for name in sorted(names):
            path = parent / name
            relative = path.relative_to(package).as_posix()
            extension = path.suffix.lower()
            row['file_count'] += 1
            if extension in NATIVE:
                row['native_files'].append(relative)
            license_name = bool(re.search(r'(?:^|[/_.-])(?:licen[cs]e|copying|permission|copyright)(?:$|[/_.-])', relative, re.I))
            if extension not in TEXT and not license_name:
                continue
            try:
                if linked(path):
                    row['linked_paths'].append(relative)
                    continue
                size = path.stat().st_size
                if size > MAX_TEXT:
                    row['oversized_text'].append([relative, size])
                    continue
                raw = path.read_bytes()
            except OSError as error:
                row['read_errors'].append([relative, type(error).__name__])
                continue
            digest = hashlib.sha256(raw).hexdigest()
            fingerprint.update(relative.encode() + b'\0' + bytes.fromhex(digest))
            row['text_files_read'] += 1
            row['text_bytes_read'] += len(raw)
            if name.lower() == 'mod.info':
                metadata = {'path': relative, 'sha256': digest}
                for line in raw.decode('utf-8-sig', errors='replace').splitlines():
                    if '=' not in line or line.lstrip().startswith(('#', '--')):
                        continue
                    key, value = line.split('=', 1)
                    if key.strip() in {'name', 'id', 'author', 'modversion', 'version', 'versionMin', 'versionMax', 'require', 'incompatible'}:
                        metadata[key.strip()] = value.strip()
                row['mods'].append(metadata)
            if license_name:
                row['license_evidence'].append({'path': relative, 'sha256': digest})
    row['text_corpus_sha256'] = fingerprint.hexdigest()
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', action='append', required=True, type=Path)
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--workers', type=int, default=4, choices=range(1, 17))
    args = parser.parse_args()
    if args.out.exists():
        parser.error('Output already exists; choose a new file to preserve prior evidence.')
    jobs = []
    for number, root in enumerate(args.root, 1):
        if not root.is_dir() or linked(root):
            parser.error('Each root must be an existing non-linked content directory.')
        if args.out.resolve().is_relative_to(root.resolve()):
            parser.error('Output must be outside every audited source root.')
        jobs.extend((number, p) for p in root.iterdir() if p.name.isdigit() and p.is_dir() and not linked(p))
    rows = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures = {pool.submit(scan, path): number for number, path in jobs}
        for index, future in enumerate(concurrent.futures.as_completed(futures), 1):
            row = future.result()
            row['root_label'] = 'root-' + str(futures[future])
            rows.append(row)
            if index % 25 == 0:
                print(f'Inventoried {index}/{len(jobs)}', flush=True)
    rows.sort(key=lambda row: (row['root_label'], row['workshop_id']))
    output = {'schema': 1, 'method': 'metadata-census-v1',
              'fingerprint_scope': 'Sorted relative paths and SHA-256 of eligible text files up to 2,000,000 bytes; not a binary asset or package integrity hash.',
              'external_execution': 'NONE', 'root_count': len(args.root),
              'instance_count': len(rows), 'unique_workshop_ids': len({r['workshop_id'] for r in rows}),
              'instances': rows}
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps(output, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps({key: output[key] for key in ('instance_count', 'unique_workshop_ids', 'external_execution')}))


if __name__ == '__main__':
    main()
