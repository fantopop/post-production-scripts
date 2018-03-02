#!/usr/bin/python
"""
tracks_to_table.py

Author: Ilya Putilin
https://github.com/fantopop/post-production-scripts

Special thanks to Philippe Lagadec for HTML.py module for generating HTML tables.
http://www.decalage.info/python/html

This scripts converts .txt file, that could be exported from Pro Tools
using "Export Session Info as Text" command into .csv file.
This CSV file can be easily opened with Number app.

There are two formats available:
    - with TRACK_NAME column as one table.
    - grouped by TRACK NAME with [--tracks] option.
"""

import sys, csv, argparse
from os import path

# Separator.
sep = '\t'

header = ['#', 'EVENT', 'START', 'END', 'DURATION']
footer = [''] * 5
# TABLE_STYLE_THINBORDER = "border: 1px solid #000000; border-collapse: collapse;"
TABLE_STYLE_THINBORDER = ""
table_style = 'table {border-collapse: collapse;} th, td {border: 1px solid #ccc;padding: 8px;}'


#--- CONSTANTS -----------------------------------------------------------------

# Table style to get thin black lines in Mozilla/Firefox instead of 3D borders
TABLE_STYLE_THINBORDER = "border: 1px solid #000000; border-collapse: collapse;"
#TABLE_STYLE_THINBORDER = "border: 1px solid #000000;"


#=== CLASSES ===================================================================

class TableCell (object):
    """
    a TableCell object is used to create a cell in a HTML table. (TD or TH)

    Attributes:
    - text: text in the cell (may contain HTML tags). May be any object which
            can be converted to a string using str().
    - header: bool, false for a normal data cell (TD), true for a header cell (TH)
    - bgcolor: str, background color
    - width: str, width
    - align: str, horizontal alignement (left, center, right, justify or char)
    - char: str, alignment character, decimal point if not specified
    - charoff: str, see HTML specs
    - valign: str, vertical alignment (top|middle|bottom|baseline)
    - style: str, CSS style
    - attribs: dict, additional attributes for the TD/TH tag

    Reference: http://www.w3.org/TR/html4/struct/tables.html#h-11.2.6
    """

    def __init__(self, text="", bgcolor=None, header=False, width=None,
                align=None, char=None, charoff=None, valign=None, style=None,
                attribs=None):
        """TableCell constructor"""
        self.text    = text
        self.bgcolor = bgcolor
        self.header  = header
        self.width   = width
        self.align   = align
        self.char    = char
        self.charoff = charoff
        self.valign  = valign
        self.style   = style
        self.attribs = attribs
        if attribs==None:
            self.attribs = {}

    def __str__(self):
        """return the HTML code for the table cell as a string"""
        attribs_str = ""
        if self.bgcolor: self.attribs['bgcolor'] = self.bgcolor
        if self.width:   self.attribs['width']   = self.width
        if self.align:   self.attribs['align']   = self.align
        if self.char:    self.attribs['char']    = self.char
        if self.charoff: self.attribs['charoff'] = self.charoff
        if self.valign:  self.attribs['valign']  = self.valign
        if self.style:   self.attribs['style']   = self.style
        for attr in self.attribs:
            attribs_str += ' %s="%s"' % (attr, self.attribs[attr])
        if self.text:
            text = str(self.text)
        else:
            # An empty cell should at least contain a non-breaking space
            text = '&nbsp;'
        if self.header:
            return '  <TH%s>%s</TH>\n' % (attribs_str, text)
        else:
            return '  <TD%s>%s</TD>\n' % (attribs_str, text)

#-------------------------------------------------------------------------------

class TableRow (object):
    """
    a TableRow object is used to create a row in a HTML table. (TR tag)

    Attributes:
    - cells: list, tuple or any iterable, containing one string or TableCell
             object for each cell
    - header: bool, true for a header row (TH), false for a normal data row (TD)
    - bgcolor: str, background color
    - col_align, col_valign, col_char, col_charoff, col_styles: see Table class
    - attribs: dict, additional attributes for the TR tag

    Reference: http://www.w3.org/TR/html4/struct/tables.html#h-11.2.5
    """

    def __init__(self, cells=None, bgcolor=None, header=False, attribs=None,
                col_align=None, col_valign=None, col_char=None,
                col_charoff=None, col_styles=None):
        """TableCell constructor"""
        self.bgcolor     = bgcolor
        self.cells       = cells
        self.header      = header
        self.col_align   = col_align
        self.col_valign  = col_valign
        self.col_char    = col_char
        self.col_charoff = col_charoff
        self.col_styles  = col_styles
        self.attribs     = attribs
        if attribs==None:
            self.attribs = {}

    def __str__(self):
        """return the HTML code for the table row as a string"""
        attribs_str = ""
        if self.bgcolor: self.attribs['bgcolor'] = self.bgcolor
        for attr in self.attribs:
            attribs_str += ' %s="%s"' % (attr, self.attribs[attr])
        if self.header:
            result = '<THEAD>'
        else:
            result = ''
        result += ' <TR%s>\n' % attribs_str
        for cell in self.cells:
            col = self.cells.index(cell)    # cell column index
            if not isinstance(cell, TableCell):
                cell = TableCell(cell, header=self.header)
            # apply column alignment if specified:
            if self.col_align and cell.align==None:
                cell.align = self.col_align[col]
            if self.col_char and cell.char==None:
                cell.char = self.col_char[col]
            if self.col_charoff and cell.charoff==None:
                cell.charoff = self.col_charoff[col]
            if self.col_valign and cell.valign==None:
                cell.valign = self.col_valign[col]
            # apply column style if specified:
            if self.col_styles and cell.style==None:
                cell.style = self.col_styles[col]
            result += str(cell)
        result += ' </TR>\n'
        if self.header:
            result += '</THEAD>'
        return result

#-------------------------------------------------------------------------------

class Table (object):
    """
    a Table object is used to create a HTML table. (TABLE tag)

    Attributes:
    - rows: list, tuple or any iterable, containing one iterable or TableRow
            object for each row
    - header_row: list, tuple or any iterable, containing the header row (optional)
    - border: str or int, border width
    - style: str, table style in CSS syntax (thin black borders by default)
    - width: str, width of the table on the page
    - attribs: dict, additional attributes for the TABLE tag
    - col_width: list or tuple defining width for each column
    - col_align: list or tuple defining horizontal alignment for each column
    - col_char: list or tuple defining alignment character for each column
    - col_charoff: list or tuple defining charoff attribute for each column
    - col_valign: list or tuple defining vertical alignment for each column
    - col_styles: list or tuple of HTML styles for each column

    Reference: http://www.w3.org/TR/html4/struct/tables.html#h-11.2.1
    """

    def __init__(self, rows=None, border='1', style=None, width=None,
                cellspacing=None, cellpadding=4, attribs=None, header_row=None,
                col_width=None, col_align=None, col_valign=None,
                col_char=None, col_charoff=None, col_styles=None):
        """TableCell constructor"""
        self.border = border
        self.style = style
        # style for thin borders by default
        if style == None: self.style = TABLE_STYLE_THINBORDER
        self.width       = width
        self.cellspacing = cellspacing
        self.cellpadding = cellpadding
        self.header_row  = header_row
        self.rows        = rows
        if not rows: self.rows = []
        self.attribs     = attribs
        if not attribs: self.attribs = {}
        self.col_width   = col_width
        self.col_align   = col_align
        self.col_char    = col_char
        self.col_charoff = col_charoff
        self.col_valign  = col_valign
        self.col_styles  = col_styles

    def __str__(self):
        """return the HTML code for the table as a string"""
        attribs_str = ""
        if self.border: self.attribs['border'] = self.border
        if self.style:  self.attribs['style'] = self.style
        if self.width:  self.attribs['width'] = self.width
        if self.cellspacing:  self.attribs['cellspacing'] = self.cellspacing
        if self.cellpadding:  self.attribs['cellpadding'] = self.cellpadding
        for attr in self.attribs:
            attribs_str += ' %s="%s"' % (attr, self.attribs[attr])
        result = '<TABLE%s>\n' % attribs_str
        # insert column tags and attributes if specified:
        if self.col_width:
            for width in self.col_width:
                result += '  <COL width="%s">\n' % width
        # First insert a header row if specified:
        if self.header_row:
            if not isinstance(self.header_row, TableRow):
                result += str(TableRow(self.header_row, header=True))
            else:
                result += str(self.header_row)
        # Then all data rows:
        for row in self.rows:
            if not isinstance(row, TableRow):
                row = TableRow(row)
            # apply column alignments  and styles to each row if specified:
            # (Mozilla bug workaround)
            if self.col_align and not row.col_align:
                row.col_align = self.col_align
            if self.col_char and not row.col_char:
                row.col_char = self.col_char
            if self.col_charoff and not row.col_charoff:
                row.col_charoff = self.col_charoff
            if self.col_valign and not row.col_valign:
                row.col_valign = self.col_valign
            if self.col_styles and not row.col_styles:
                row.col_styles = self.col_styles
            result += str(row)
        result += '</TABLE>'
        return result


def table(*args, **kwargs):
    'return HTML code for a table as a string. See Table class for parameters.'
    return str(Table(*args, **kwargs))


#-------------------------------------------------------------------------------

tab = '    '

class Tag():
    '''
    A class to provide correct opening and closing tags,
    with intendation support via HTML class instance.

    Implies usage of the "with" statement:

        with Tag('tag', HTML-instance):
            <code>
    '''
    def __init__(self, name, HTML):
        self.name = name
        self.HTML = HTML
    def __enter__(self):
        self.HTML.content += tab * self.HTML.indent + '<' + self.name + '>\n'
        self.HTML.indent += 1
    def __exit__(self, exc_type, exc_value, traceback):
        self.HTML.indent -= 1
        self.HTML.content += tab * self.HTML.indent + '</' + self.name + '>\n'



class HTML():
    '''
    HTML() class instance accumulates generated HTML code, handles indentation
    and provides several html-tags as methods, returning Tag() class instances.
    Common usage pattern:
        h = HTML()
        with h.html():
            with h.head():
                with h.title()
                    h.add('Hello world page')
            with h.body():
                with h.h1():
                    h.add('Hello World!')
                with h.p():
                    h.add('This is the HTML code')
        print(str(h))
    '''
    def __init__(self):
        self.indent = 0
        self.content = '<!DOCTYPE html>\n'
    def __str__(self):
        return self.content
    def add(self, text):
        for line in text.split('\n'):
            self.content += tab * self.indent + line + '\n'

    def html(self):
        return Tag('html', self)
    def body(self):
        return Tag('body', self)
    def head(self):
        return Tag('head', self)
    def title(self):
        return Tag('title', self)
    def h1(self):
        return Tag('h1', self)
    def h2(self):
        return Tag('h2', self)
    def style(self):
        return Tag('style', self)
    def p(self):
        return Tag('p', self)


#-------------------------------------------------------------------------------


class Track():
    '''
    Stores track name and list of track events:
        [NUMBER, CLIP_NAME, START TC, END TC, DURATION TC]
    '''
    def __init__(self, name):
        self.name = name
        self.events = []


class Session():
    '''
    Session() instance reads .txt file, exported from Pro Tools and
    stores every tracks EDL as list of Track() instances.

    Supports export to .csv and .html formats.
    '''
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
                if len(row) > 6:
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
        h = HTML()
        with h.html():
            with h.head():
                h.add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">')
                with h.title():
                    # Add document title
                    h.add(filename.split('.')[-2].split('/')[-1])
                with h.style():
                    h.add('@media print {')
                    h.indent += 1
                    # Add page break after each track's table when printing
                    h.add('TABLE { page-break-after: always}')
                    # Configure correct display of table over multiple printing pages
                    h.add('TR    { page-break-inside:avoid; page-break-after:auto }')
                    h.add('TD    { page-break-inside:avoid; page-break-after:auto }')
                    h.add('THEAD { display:table-header-group }')
                    h.add('TFOOT { display:table-footer-group }')
                    # Set default landscape orientation when printing
                    h.add('@page {size: landscape;}}')
                    h.indent -= 1
                    h.add(table_style)
            with h.body():
                for track in self.tracks:
                    # Add track name as header
                    with h.h2():
                        h.add(track.name)
                    # Add track's EDL table
                    h.add(table(track.events,
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
        print('Source: ' + filename)
        print('Result: ' + outputfile)


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
        description="Converts '.txt' file from Pro Tools 'Export Session Info as Text' command to '.csv' or '.html' file")
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
