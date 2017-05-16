#!/usr/bin/env python3.6
"""
This script renames files from format:
    05-5-160928_1009.wav
to:
    1009_05-5-160928.wav
where:
    1009: recording time,
    05-5: channel number,
    160928: date.

This was done to group files by takes (recording time).
"""

import re, os, sys
expression = r'([a-zA-Z0-9\-]+)\_(\d\d\d\d)(\.wav)'


def rename_files(path, rename=False):
    # Set working path.
    try:
        os.chdir(path)
    except OSError:
        print('Error accessing the path.')
        sys.exit(1)

    # Get list of filenames.
    file_list = os.listdir()

    # Processed files counter.
    count = 0

    # Rename files.
    for name in file_list:
        match = re.search(expression, name)
        if match:
            new_name = match.group(2) + '_' + match.group(1) + match.group(3)
            print(name + ' => ' + new_name)
            if rename:
                os.rename(name, new_name)
            count += 1
    return count

def main():
    # Parsing command line arguments.
    args = sys.argv[1:]
    if not args or args[0] in ['-h', '--help']:
        print('Usage: python rename_mixer_files.py [--rename] path_to_dir')
        print('Run script without --rename option to preview result.')
        print('Warning: Always backup files before renaming!')
        sys.exit(1)

    # Check for rename option.
    rename = False
    if args[0] == '--rename':
        rename = True
        del args[0]

    path = os.path.abspath(os.path.normpath(args[0]))
    count = rename_files(path, rename)

    # Printing result.
    if rename:
        print('Complete! %d files renamed.' % count)
    else:
        print('%d matches found. Run script with --rename option to rename files.' % count)

if __name__ == '__main__':
    main()
