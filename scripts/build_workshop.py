"""Build an existing-item Workshop test staging tree; never upload or restart Steam."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import tempfile
import zipfile
import zlib

ROOT=Path(__file__).resolve().parents[1]
MOD='B47ANCEDEssentials'
ITEM='3788591728'
LABEL='MP testing build - dedicated multiplayer NOT TESTED'

def git(*args):
    return subprocess.check_output(['git','-C',str(ROOT),*args],text=True).strip()

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def png(path):
    data=path.read_bytes()
    assert data[:8]==b'\x89PNG\r\n\x1a\n', 'Not a PNG'
    offset=8; dimensions=None; ended=False
    while offset<len(data):
        length=struct.unpack('>I',data[offset:offset+4])[0]
        kind=data[offset+4:offset+8]; payload=data[offset+8:offset+8+length]
        crc=data[offset+8+length:offset+12+length]
        assert len(payload)==length and len(crc)==4, 'Truncated PNG'
        assert zlib.crc32(kind+payload)&0xffffffff==struct.unpack('>I',crc)[0], 'PNG CRC mismatch'
        if kind==b'IHDR': dimensions=struct.unpack('>II',payload[:8])
        offset+=length+12
        if kind==b'IEND': ended=True; break
    assert ended and offset==len(data), 'Invalid PNG end'
    return dimensions

def quote(value):
    assert '\x00' not in value
    return '"'+value.replace('\\','\\\\').replace('"','\\"')+'"'

def build(game_build):
    assert not git('status','--porcelain=v1'), 'Commit intended source before packaging'
    commit=git('rev-parse','HEAD')
    assert commit==git('rev-parse','origin/main'), 'Build only the freshly verified merged source'
    version=(ROOT/'VERSION').read_text().strip()
    assert re.fullmatch(r'\d+\.\d+\.\d+',version)
    assert (ROOT/'WORKSHOP_ID.txt').read_text().strip()==ITEM
    for check in ('check_versions.py','check_identity.py'):
        import sys
        subprocess.run([sys.executable,str(ROOT/'scripts'/check)],cwd=ROOT,check=True)
    description=(ROOT/'WORKSHOP_DESCRIPTION.txt').read_text(encoding='utf-8')
    note=(ROOT/'WORKSHOP_CHANGE_NOTE.txt').read_text(encoding='utf-8')
    for name,text in (('description',description),('changenote',note)):
        assert LABEL in text and len(text.strip())>50, f'{name}: testing label missing'
        assert '\\n' not in text and '\x00' not in text and not re.search(r'\b(?:TODO|TBD|FIXME)\b',text), f'{name}: invalid placeholder/newlines'
    assert 'https://github.com/B47ANCE/B47ANCEDEssentials' in description
    assert len(description.encode())<8000 and len(note.encode())<8000, 'Steam text exceeds verified 8000-byte limit'
    preview=ROOT/'preview.png'
    assert png(preview)==(512,512) and preview.stat().st_size<1024*1024
    source=ROOT/'Contents'
    files={}
    for directory,dirs,names in os.walk(source,followlinks=False):
        for name in dirs+names:
            path=Path(directory)/name
            assert not path.is_symlink() and not getattr(path,'is_junction',lambda:False)(), 'Linked source'
        for name in names:
            path=Path(directory)/name
            relative=path.relative_to(ROOT).as_posix()
            assert path.suffix.lower() in ('.lua','.png','.txt','.json','.info'), relative
            assert ':' not in relative and '..' not in Path(relative).parts and '\\' not in relative
            files[relative]=sha(path)
    assert len({name.casefold() for name in files})==len(files), 'Case-colliding source'
    assert files and all(name.startswith('Contents/mods/'+MOD+'/') for name in files)
    # Unique staging protects every earlier package and provenance record.
    dist=ROOT/'dist'; dist.mkdir(exist_ok=True)
    stage=Path(tempfile.mkdtemp(prefix=f'workshop-{version}-{commit[:12]}-',dir=dist))
    shutil.copytree(source,stage/'Contents')
    shutil.copy2(preview,stage/'preview.png')
    assert all(sha(stage/name)==value for name,value in files.items()), 'Stage/source parity'
    archive=dist/f'{MOD}-{version}-mp-test-{commit[:12]}.zip'
    assert not archive.exists(), 'Protect existing archive; select an explicit new artifact name'
    with zipfile.ZipFile(archive,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as package:
        for name in sorted(files):
            info=zipfile.ZipInfo(name,date_time=(1980,1,1,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED; info.external_attr=0o100644<<16
            package.writestr(info,(ROOT/name).read_bytes())
    with zipfile.ZipFile(archive) as package:
        assert package.testzip() is None
        assert package.namelist()==sorted(files), 'Unexpected/duplicate archive entries'
        assert all(hashlib.sha256(package.read(name)).hexdigest()==value for name,value in files.items()), 'ZIP parity'
    vdf=stage/'upload.vdf'
    values={'appid':'108600','publishedfileid':ITEM,'contentfolder':(stage/'Contents').as_posix(),
            'previewfile':(stage/'preview.png').as_posix(),'title':"B47ANCE'd Essentials",'description':description,'changenote':note}
    vdf.write_text('"workshopitem"\n{\n'+''.join('    '+quote(key)+' '+quote(value)+'\n' for key,value in values.items())+'}\n',encoding='utf-8')
    assert 'visibility' not in values and 'tags' not in values
    manifest={'schema':1,'version':version,'source_commit':commit,'appid':108600,'workshop_id':ITEM,'mod_id':MOD,
              'source_tree':git('rev-parse','HEAD^{tree}'),'game_steam_buildid':game_build,'minimum_pz_version':'42.20.3',
              'visibility':'preserve existing; hidden confirmed by user','package':archive.name,'package_sha256':sha(archive),
              'preview_sha256':sha(stage/'preview.png'),'description_sha256':sha(ROOT/'WORKSHOP_DESCRIPTION.txt'),
              'changenote_sha256':sha(ROOT/'WORKSHOP_CHANGE_NOTE.txt'),'vdf_sha256':sha(vdf),'files':files,
              'validation':{'offline':'26 host tests, 28 Lua syntax checks; version/identity PASS',
                            'SP':'NOT TESTED','G7':'BLOCKED / NOT TESTED','stable_G8':'BLOCKED'},'upload':'NOT YET ATTEMPTED'}
    manifest_path=stage/'release-manifest.json'
    manifest_path.write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'stage':str(stage),'vdf':str(vdf),'manifest':str(manifest_path),'package':str(archive),
                      'package_sha256':manifest['package_sha256'],'source_commit':commit,'files':len(files)},indent=2))
    return stage

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--game-build',required=True,type=int)
    build(parser.parse_args().game_build)
