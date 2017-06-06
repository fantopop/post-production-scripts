#!/usr/bin/ python
"""
This scripts converts .txt file, that could be exported from Pro Tools
using "Export Session Info as Text" command into .csv file.
This CSV file can be easily opened with Number app.

There are two formats available:
    - with TRACK_NAME column as one table.
    - grouped by TRACK NAME with [--tracks] option.
"""

import sys, csv, argparse
from os import path

# Field names in output file.
track_name = 'TRACK_NAME'
event = 'EVENT'
clip_name = 'CLIP_NAME'
start_tc = 'START'
end_tc = 'END'
duration = 'DURATION'
# Separator.
sep = '\t'


def outname(filename):
    """
    Constructs output filename from input file,
    replacing extension with '.csv'.
    Example:
    input.txt >>> input.csv
    """
    split = (path.basename(filename)).split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + ['csv'])
    else:
        output = filename + '.csv'
    return path.join(path.dirname(filename), output)


def tracks_to_csv(inputfile, outputfile, tracks):
    csv_reader = csv.reader(inputfile, dialect='excel-tab')
    csv_writer = csv.writer(outputfile, dialect='excel-tab')

    # Make header.
    if not tracks:
        header = [track_name, event, clip_name, start_tc, end_tc, duration]
        csv_writer.writerow(header)

    for raw_row in csv_reader:
        # Check, whether the row is not empty.
        if raw_row:
            # Remove all whitespaces from start and end of the cells.
            row = [cell.strip() for cell in raw_row]
            # Get track name.
            if row[0].startswith('TRACK NAME:'):
                if tracks:
                    csv_writer.writerow(['', '', '', '', ''])
                    header = row + [start_tc, end_tc, duration]
                    csv_writer.writerow(header)
                else:
                    track = row[1]
                continue
            # Skip original header lines.
            if row[0].startswith('CHANNEL'):
                continue
            if len(row) > 2:
                if tracks:
                    csv_writer.writerow(row[1:6])
                else:
                    csv_writer.writerow([track] + row[1:6])


def main():
    parser = argparse.ArgumentParser(
        description="Converts '.txt' file from Pro Tools 'Export Session Info as Text' command to '.csv' file")
    parser.add_argument(
        'txt', metavar='textfile', type=argparse.FileType(mode='r'),
        help='session info text file from Pro Tools')
    parser.add_argument(
        '-t', '--tracks', action='store_true',
        help='skip TRACK_NAME column, group by tracks instead')
    args = parser.parse_args()

    with open(outname(args.txt.name), 'w') as csv:
        tracks_to_csv(args.txt, csv, args.tracks)

    args.txt.close()


if __name__ == '__main__':
    main()
