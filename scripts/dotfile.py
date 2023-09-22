#!/usr/bin/env python3
import logging
import argparse
import subprocess
import json
import pathlib
import shutil
import filecmp

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

ROOT_PATH = pathlib.Path(__file__).resolve().parent.parent
HOME_PATH = pathlib.Path.home()

DEFAULT_FILE_MAP = {
    '.vimrc': 'vimrc',
    '.vimrc.local': 'vimrc.local',
    '.bashrc': 'bashrc',
    '.bash_aliases': 'bash_aliases',
    '.bash_profile': 'bash_profile',
    '.tmux.conf': 'tmux.conf',
    '.tmux.conf.local': 'tmux.conf.local',
}

FILE_MAP_FILE = 'filemap.json'


def ask_yesno(question):
    yes = {'yes', 'y'}
    no = {'no', 'n'}

    question += ' [y/n]'
    done = False
    while not done:
        print(question, end='')
        choice = input().lower()
        if choice in yes:
            return True
        if choice in no:
            return False


def load_file_map():
    file_map = {}
    custom_file_map = json.load((ROOT_PATH / FILE_MAP_FILE).open())
    for k, v in DEFAULT_FILE_MAP.items():
        v = custom_file_map.get(k) or v
        file_map[HOME_PATH / k] = ROOT_PATH / v
    return file_map


def update_files(file_map):
    """Update effective dot files."""
    for k, v in file_map.items():
        old_path = k if k.exists() else pathlib.Path('/dev/null')
        if filecmp.cmp(old_path, v):
            continue
        proc = subprocess.run(['diff', old_path, v],
                              capture_output=True,
                              encoding='utf-8',
                              check=False)
        print(proc.stdout)
        logger.info('Updating %s', k.name)
        if ask_yesno(f'Update {k.name}?'):
            shutil.copy(v, k)


def save_files(file_map):
    """Save dot files to git repository, without committing them."""
    for k, v in file_map.items():
        if filecmp.cmp(k, v):
            continue
        logger.info('Saving %s', k.name)
        shutil.copy(k, v)


def main():
    parser = argparse.ArgumentParser(
        description='Save dot files to git repository.')
    parser.add_argument('-u', '--update', action='store_true',
                        help='update dot files from repository')
    parser.add_argument('--no-check', action='store_true',
                        help='do not check tree status')
    args = parser.parse_args()

    # Make sure tree is clean, and sync tree
    if not args.no_check:
        subprocess.check_call(['git', 'diff', '--quiet'], cwd=ROOT_PATH)
        subprocess.check_call(['git', 'diff', '--cached', '--quiet'],
                              cwd=ROOT_PATH)
        subprocess.check_call(['git', 'pull', '--ff-only'], cwd=ROOT_PATH)

    file_map = load_file_map()
    if args.update:
        update_files(file_map)
    else:
        save_files(file_map)


if __name__ == '__main__':
    main()
