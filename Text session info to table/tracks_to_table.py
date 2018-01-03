#!/usr/bin/python
"""
This scripts converts .txt file, that could be exported from Pro Tools
using "Export Session Info as Text" command into .csv file.
This CSV file can be easily opened with Number app.

There are two formats available:
    - with TRACK_NAME column as one table.
    - grouped by TRACK NAME with [--tracks] option.
"""

import sys, csv, argparse
import html, table
from os import path

# Separator.
sep = '\t'

header = ['#', 'EVENT', 'START', 'END', 'DURATION']
footer = [''] * 5
# TABLE_STYLE_THINBORDER = "border: 1px solid #000000; border-collapse: collapse;"
TABLE_STYLE_THINBORDER = ""
table_style = 'table {border-collapse: collapse;} th, td {border: 1px solid #ccc;padding: 8px;}'


class Track():
    def __init__(self, name):
        self.name = name
        self.events = []


class Session():
    def __init__(self, filename):
        # Open session info file for reading
        csv_reader = csv.reader(filename, dialect='excel-tab')
        # Create array for Track() objects
        self.tracks = []

        for raw_row in csv_reader:
            # Check, whether the row is not empty.
            if raw_row:
                # Remove all whitespaces from start and end of the cells.
                row = [cell.strip() for cell in raw_row]
                # Get track name.
                if row[0].startswith('TRACK NAME:'):
                    track = Track(name=row[1])
                    self.tracks.append(track)
                    continue
                # Skip original header lines.
                if row[0].startswith('CHANNEL'):
                    continue
                if len(row) > 2:
                    track.events.append(row[1:6])


    def to_csv(self, filename):
        with open(filename, 'w') as outputfile:
            csv_writer = csv.writer(outputfile, dialect='excel-tab')
            for track in self.tracks:
                csv_writer.writerow([''] + [track.name] + ['']*3)
                csv_writer.writerow(header)
                for line in track.events:
                    csv_writer.writerow(line)
                csv_writer.writerow(footer)


    def to_html(self, filename):
        h = html.HTML()
        with h.html():
            with h.head():
                with h.title():
                    # Add document title
                    h.add(filename.split('.')[-2].split('/')[-1])
                with h.style():
                    h.add('@media print {')
                    # Add page break after each track's table when printing
                    h.add('  table {page-break-after: always;}')
                    # Set default landscape orientation when printing
                    h.add('  @page {size: landscape;}}')
                    h.add(table_style)
            with h.body():
                for track in self.tracks:
                    # Add track name as header
                    with h.h2():
                        h.add(track.name)
                    # Add track's EDL table
                    h.add(table.table(track.events,
                                      header_row=header,
                                      width='100%',
                                      border=None,
                                      cellpadding=None,
                                      col_width=['2.5%', '', '5%', '5%', '5%'],
                                      col_align=['center', 'left', 'center', 'center', 'center'],
                                      style=TABLE_STYLE_THINBORDER
                                      ))
        with open(filename, 'w') as outputfile:
            outputfile.write(str(h))


    def export(self, filename, to):
        outputfile = outname(filename, to)
        if to == 'csv':
            self.to_csv(outputfile)
        else:
            self.to_html(outputfile)


def outname(filename, ext='csv'):
    """
    Constructs output filename from input file,
    replacing extension with '.csv'.
    Example:
    input.txt >>> input.csv
    """
    split = (path.basename(filename)).split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + [ext])
    else:
        output = filename + '.' + ext
    return path.join(path.dirname(filename), output)


def main():
    parser = argparse.ArgumentParser(
        description="Converts '.txt' file from Pro Tools 'Export Session Info as Text' command to '.csv' file")
    parser.add_argument(
        'txt', metavar='textfile', type=argparse.FileType(mode='r'),
        help='session info text file from Pro Tools')
    parser.add_argument(
        '--to', choices=['csv', 'html'], required=True,
        help='export format: "csv" or "html"')
    args = parser.parse_args()

    # Read session info to Session() object
    session = Session(args.txt)
    args.txt.close()

    # Export to the file of choses format.
    session.export(filename=args.txt.name, to=args.to)


if __name__ == '__main__':
    main()
