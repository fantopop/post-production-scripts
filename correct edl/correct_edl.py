#!/usr/bin/env python3
"""
This script replaces strings in *FROM CLIP NAME field of the EDL,
accroding to the dictionary from the .json file.
Corrected EDL is written to the new file, with '.corrected' added to the filename.
"""

# Constants
from_clip_name = '*FROM CLIP NAME:  '
source_file = '*SOURCE FILE: '


import sys
import json


def print_separator():
    print('\n========================================\n')


def print_dict(d):
    print('Replacements dictionary: \n')
    for key in d:
        print("'%s' >>> '%s'" %(key, d[key]))
    print()


def read_dict(dict_filename):
    """
    Reads replacements dictionary from dict_filename
    and returns it as a dict object.
    """
    try:
        f = open(dict_filename, 'r')
        d = json.load(f)
        f.close()
    except IOError:
        sys.stderr.write('Dictionary file not found.\n')
        sys.exit(1)
    return d


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
    args = sys.argv[1:]
    if not args:
        print('Usage: python correct_edl.py [--dict dict.json] [--stat] edl')
        print('Corrected EDL will be written to a new file.')
        sys.exit(1)

    # Get dictionary filename, if provided.
    # If not - use the default one.
    dict_filename = 'replacements_dict.json'
    if args[0] == '--dict':
        dict_filename = args[1]
        del args[0:2]

    # Read dictionary from file.
    replacements_dict = read_dict(dict_filename)

    # Read print_statistics parameter, if provided.
    # If not - use default value.
    print_statistics = False
    if args[0] == '--stat':
        print_statistics = True
        del args[0]

    # Get filename from the first arbitary argument.
    filename = args[0]

    # Try to read the input edl.
    try:
        input_edl = open(filename, 'r')
    except IOError:
        print('Input file not found.')
        sys.exit(1)

    # Constructing name for the corrected file.
    split = filename.split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + ['corrected', split[l-1]])
    else:
        output = filename + '.corrected'

    output_edl = open(output, 'w')

    # Printing settings.
    print_separator()
    print('Input file: %s' % filename)
    print('Output filename: %s' % output)
    print('Replacements dictionary: %s' % dict_filename)
    print('Print statistics: %s' % print_statistics)
    print_separator()

    # Correct EDL and get replacements count.
    count = correct(input_edl, output_edl, replacements_dict, print_statistics)

    # Clean-up.
    input_edl.close()
    output_edl.close()
    print('\n%d events corrected.\n' % count)
    return 0


if __name__ == '__main__':
    main()
