"""Run the project's Lua host regressions in isolated Lua 5.1 runtimes."""
from pathlib import Path
import argparse
import os
import sys
from lupa.lua51 import LuaRuntime

def run(root, mod_id):
    os.chdir(root)
    base = Path('Contents/mods') / mod_id / '42/media/lua'
    sources = {
        'auto_key_ring': ('client', 'AutoKeyRing'),
        'bulk_magazines': ('client', 'BulkMagazines'),
        'context_menu_cleanup': ('client', 'ContextMenuCleanup'),
        'craft_output_routing': ('shared', 'CraftOutputRouting'),
        'device_power_menu': ('client', 'DevicePowerMenu'),
        'exact_watch_clock': ('client', 'ExactWatchClock'),
        'guided_test': ('client', 'GuidedTest'),
        'hotbar_reordering': ('client', 'HotbarReordering'),
        'independent_hand_classifier': ('shared', 'IndependentHandClassifier'),
        'inventory_action_grouping': ('client', 'InventoryActionGrouping'),
        'inventory_selection_repair': ('client', 'InventorySelectionRepair'),
        'ladder_interaction': ('client', 'LadderInteraction'),
        'literature_core': ('shared', 'LiteratureCore'),
        'literature_tracking': ('client', 'LiteratureTracking'),
        'map_symbol_defaults': ('client', 'MapSymbolDefaults'),
        'sorting_client': ('client', 'SortingClient'),
        'sorting_core': ('shared', 'SortingCore'),
        'sorting_server': ('server', 'SortingServer'),
        'testkit': ('client', 'TestKit'),
    }
    failures = []
    for test in sorted(Path('tests').glob('test_*.lua')):
        runtime = LuaRuntime(unpack_returned_tuples=True)
        # Existing game-facing code uses table.unpack; stock Lua 5.1 calls it unpack.
        runtime.execute('table.unpack = table.unpack or unpack')
        runtime.globals().print = lambda *args: None
        paths = [f'{base.as_posix()}/{side}/?.lua' for side in ('shared', 'client', 'server')]
        runtime.globals().package.path = ';'.join(paths) + ';' + runtime.globals().package.path
        arguments = runtime.table()
        key = test.stem.removeprefix('test_')
        if key in sources:
            side, name = sources[key]
            arguments[1] = (base / side / mod_id / (name + '.lua')).as_posix()
        elif key == 'inventory_transfer_transport':
            arguments[1] = (base / 'server' / mod_id / 'InventoryTransferServer.lua').as_posix()
            arguments[2] = (base / 'client' / mod_id / 'InventoryTransferClient.lua').as_posix()
        runtime.globals().arg = arguments
        try:
            runtime.execute(test.read_text(encoding='utf-8-sig'), name='@' + test.as_posix())
            print('PASS', test.name)
        except Exception as exc:
            failures.append(test.name)
            print('FAIL', test.name, str(exc))
    compiler = LuaRuntime(unpack_returned_tuples=True)
    for source in sorted(base.rglob('*.lua')):
        result = compiler.eval('function(s,n) local f,e=loadstring(s,n); return f~=nil,e end')(
            source.read_text(encoding='utf-8-sig'), '@' + source.as_posix())
        if not result[0]:
            failures.append(source.as_posix())
            print('SYNTAX FAIL', source, result[1])
    print(f'{len(list(Path("tests").glob("test_*.lua")))} host tests; '
          f'{len(list(base.rglob("*.lua")))} Lua syntax checks; {len(failures)} failures. Offline Lua 5.1 only.')
    return bool(failures)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--mod-id', default='B47ANCEDEssentials')
    args = parser.parse_args()
    sys.exit(run(args.root.resolve(), args.mod_id))
