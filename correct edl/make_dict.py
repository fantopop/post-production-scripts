#!/usr/bin/env python3
"""
This script creates dictionary and writes it
to the .json file for use by correctEDL.py script.
"""


import json
import sys
from os import path


# Dictionary with strings to be replaced.
d = {}
d[','] = '_'
d['/'] = '_'
d[' A'] = 'A'
d[' B'] = 'B'
d[' C'] = 'C'

# Scene names from shooting day 160803.
d['A139C002_160803_L0F7.MXF'] = '113-11-1'
d['A136C001_160803_L0F7.MXF'] = '113-06-1A'
d['A139C001_160803_L0F7.MXF'] = '113-10-01'
d['A134C003_160803_L0F7.MXF'] = '113-02-03A'
d['A137C002_160803_L0F7.MXF'] = '113-07-02'
d['A140C001_160803_L0F7.MXF'] = '113-12-01'
d['A134C004_160803_L0F7.MXF'] = '113-04-01A'
d['A137C001_160803_L0F7.MXF'] = '113-07-01'
d['B014C013_160801_R59N.MXF'] = '113-01-04'
# Scene names from scenes 61-62.
d['A214C010_160814_L0F7.MXF'] = '61-02-02'
d['A214C007_160814_L0F7.MXF'] = '61-01-03'
d['A215C004_160814_L0F7.MXF'] = '62-01-04'
d['A216C002_160814_L0F7.MXF'] = '62-03-01'
d['A216C001_160814_L0F7.MXF'] = '62-02-01'
d['A215C002_160814_L0F7.MXF'] = '62-01-02'
d['A215C001_160814_L0F7.MXF'] = '62-01-01'
d['A069C002_160725_R0F7.MXF'] = '60_63-02-02'
d['A218C001_160814_L0F7.MXF'] = '62-04-03'
d['A219C001_160814_L0F7.MXF'] = '62-05-02'
d['A218C002_160814_L0F7.MXF'] = '62-04-04'
d['A218C003_160814_L0F7.MXF'] = '62-05-01'
d['A219C004_160814_L0F7.MXF'] = '62-08-01'
d['A217C003_160814_L0F7.MXF'] = '62-04-02'


def main():
    filename = path.join(path.dirname(sys.argv[0]), 'replacements_dict.json')
    f = open(filename, 'w')
    json.dump(obj=d, fp=f, indent=4)
    f.close()


if __name__ == '__main__':
    main()
