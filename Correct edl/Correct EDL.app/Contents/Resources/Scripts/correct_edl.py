#!/usr/bin/env python3
"""
This script replaces strings in *FROM CLIP NAME field of the EDL,
accroding to the dictionary from the .json file.
Corrected EDL is written to the new file, with '.corrected' added to the filename.
"""

# Constants
from_clip_name = '*FROM CLIP NAME:  '
source_file = '*SOURCE FILE: '


import sys, json, argparse
from os import path


def print_separator():
    print('\n========================================\n')


def print_dict(d):
    print('Replacements dictionary: \n')
    for key in d:
        print("'%s' >>> '%s'" %(key, d[key]))
    print()


def outname(filename):
    """
    Constructs output filename from input file,
    adding '.corrected' between filename and extension.
    Example:
    input.txt >>> input.corrected.txt
    """
    split = (path.basename(filename)).split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + ['corrected', split[l-1]])
    else:
        output = filename + '.corrected'
    return path.join(path.dirname(filename), output)


def correct(inputfile, outputfile, dictionary, print_statistics=False):
    """
    Reads input file line by line and writes them into output file,
    applying corrections:
        1. Lines, that start with "*SOURCE FILE" are omitted.
        2. '*FROM CLIP NAME ' lines are written with replacements according to dictionary.
        3. Other lines are written unchanged.
    Returns lines with replacements count.
    """
    # Corrected events count.
    count = 0

    for line in inputfile:
        # Remove lines that start with "*SOURCE FILE".
        if not line.startswith(source_file):
            # Working with '*FROM CLIP NAME ' lines only.
            if line.startswith(from_clip_name):
                old_line = line
                for key in dictionary:
                    # Replace.
                    line = from_clip_name + line[len(from_clip_name):].replace(key, dictionary[key])
                # Write down corrected line.
                if not line == old_line:
                    count += 1
                    # Print out replacements.
                    if print_statistics:
                        print(old_line[len(from_clip_name):-1] + ' >>> ' + line[len(from_clip_name):-1])
                outputfile.write(line)
            else:
                # Write main event line unchanged.
                outputfile.write(line)
    return count


def main():
    # Parsing command line arguments.
    parser = argparse.ArgumentParser(
        description='Replaces strings in *FROM CLIP NAME field of the EDL, accroding to the dictionary from the .json file')
    parser.add_argument(
        'edl', type=argparse.FileType(mode='r'),
        help='source EDL file')
    parser.add_argument(
        '-d', '--dict', type=argparse.FileType(mode='r'),
        default='replacements_dict.json',
        help='replacements dictionary in JSON format, \'replacements_dict.json\' is used, if not specified')
    parser.add_argument(
        '-s', '--stat', action='store_true',
        help='print detailed replacements statistics')

    args = parser.parse_args()

    # Constructing name for the corrected file.
    output = outname(args.edl.name)

    # Read dictionary from file.
    replacements_dict = json.load(args.dict)
    args.dict.close()

    # Printing settings.
    # print_separator()
    print('Input EDL: %s' % path.basename(args.edl.name))
    print('Output filename: %s' % path.basename(output))
    print('Replacements dictionary: %s' % args.dict.name)
    print('Print statistics: %s' % args.stat)
    # print_separator()

    with open(output, 'w') as output_edl:
        count = correct(args.edl, output_edl, replacements_dict, args.stat)

    # Cleanup and result.
    args.edl.close()
    print('\n%d events corrected.\n' % count)


if __name__ == '__main__':
    main()
