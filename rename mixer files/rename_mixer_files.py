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

import re, os, sys, argparse
expression = r'([a-zA-Z0-9\-]+)\_(\d\d\d\d)(\.wav)'


def rename_files(path, rename=False):
    # Set working path.
    try:
        os.chdir(path)
    except OSError as err:
        print(err)
        sys.exit(1)

    # Get list of filenames.
    file_list = os.listdir(path)

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
    parser = argparse.ArgumentParser(
        description="""rename files from '05-5-160928_1009.wav' to '1009_05-5-160928.wav, '
            where 1009 - recording time, 05-5 - channel number, 160928 - date""",
        epilog="""Warning: Always backup files before renaming!""")
    parser.add_argument(
        'path', help='path to the folder with files to be renamed')
    parser.add_argument(
        '-r', '--rename', action='store_true',
        help='run script without this option to preview results')

    args = parser.parse_args()
    path = os.path.abspath(os.path.normpath(args.path))
    count = rename_files(path, args.rename)

    # Printing result.
    if args.rename:
        print('\nComplete! %d files renamed.' % count)
    else:
        print('\n%d matches found. Run script with [-r] option to rename files.' % count)

if __name__ == '__main__':
    main()
