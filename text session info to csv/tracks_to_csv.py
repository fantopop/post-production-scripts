#!/usr/bin/env python3.6
"""
This scripts converts .txt file, that could be exported from Pro Tools
using "Export Session Info as Text" command into .csv file.
This CSV file can be easily opened with Number app.

There are two formats available:
    - with TRACK_NAME column as one table.
    - grouped by TRACK NAME with [--tracks] option.
"""

import sys
from os import path
import csv

# Field names in output file.
track_name = 'TRACK_NAME'
event = 'EVENT'
clip_name = 'CLIP_NAME'
start_tc = 'START'
end_tc = 'END'
duration = 'DURATION'
# Separator.
sep = '\t'


def get_output_filename(input_filename):
    """
    Constructs output filename from input file,
    replacing extension with '.csv'.
    Example:
    input.txt >>> input.csv
    """
    split = (path.basename(input_filename)).split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + ['csv'])
    else:
        output = input_filename + '.csv'
    return output


def tracks_to_csv(filename, track_column):
    # Open input file.
    try:
        inputfile = open(filename, mode='rU')
    except IOError:
        print('File not found.')
        sys.exit(1)

    # Open output file.
    todir = path.dirname(filename)
    output_filename = path.join(todir, get_output_filename(filename))
    try:
        outputfile = open(output_filename, mode='w')
    except IOError:
        print('Can\'t create output file.')
        sys.exit(1)

    csv_reader = csv.reader(inputfile, dialect='excel-tab')
    csv_writer = csv.writer(outputfile, dialect='excel-tab')

    # Make header.
    if track_column:
        header = [track_name, event, clip_name, start_tc, end_tc, duration]
        csv_writer.writerow(header)

    for raw_row in csv_reader:
        # Check, whether the row is not empty.
        if raw_row:
            # Remove all whitespaces from start and end of the cells.
            row = [cell.strip() for cell in raw_row]
            # Get track name.
            if row[0].startswith('TRACK NAME:'):
                if track_column:
                    track = row[1]
                else:
                    csv_writer.writerow(['', '', '', '', ''])
                    header = row + [start_tc, end_tc, duration]
                    csv_writer.writerow(header)
                continue
            # Skip original header lines.
            if row[0].startswith('CHANNEL'):
                continue
            if len(row) > 2:
                if track_column:
                    csv_writer.writerow([track] + row[1:6])
                else:
                    csv_writer.writerow(row[1:6])
    inputfile.close()
    outputfile.close()


def main():
    # Parsing command line arguments.
    args = sys.argv[1:]
    if not args or args[0] in ['-h', '--help']:
        print('Usage: python tracks_to_csv.py [--tracks] input.txt')
        print('Use [--tracks] option group by without TRACK_NAME column.')
        print('New file is written next to input file.')
        sys.exit(1)

    # Check for tracks option.
    track_column = True
    if args[0] == '--tracks':
        track_column = False
        del args[0]

    if len(args) == 0:
        print('Invalid arguments.')
        sys.exit(1)

    filename = args[0]
    tracks_to_csv(filename, track_column)


if __name__ == '__main__':
    main()
