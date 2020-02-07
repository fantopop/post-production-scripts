#!/usr/bin/env python3
'''
Filter events in EDL with matching track name.
It can be used to filter video or audio events.
Example usage:

python filter_tracks path/to/sample.edl -t V -f 24

Dependencies: timecode, edl
'''

import argparse
from os import path
from edl import Parser


def outname(filename, suffix='filtered'):
    '''
    Constructs output filename from input file,
    adding suffix between filename and extension.
    Example:
    input.txt >>> input.filtered.txt
    '''
    split = (path.basename(filename)).split('.')
    l = len(split)
    if l > 1:
        output = '.'.join(split[0:l-1] + [suffix, split[l-1]])
    else:
        output = filename + suffix
    return path.join(path.dirname(filename), output)

def filter_tracks(edl, pattern):
    '''
    Removes events from edl matching with pattern in track name.
    Returns number of filtered events.
    '''
    events = edl.events
    
    # number of events in edl before filtering
    before = len(events)
    
    filtered = list(filter(lambda x: x.track.find(pattern) < 0, events))
    edl.events = filtered
    
    # number of events in edl after filtering
    after = len(filtered)
    
    # return difference
    return before - after

def main():
    '''
    Filters tracks in EDL according to passed argument (A by default)
    and writes to a new EDL file.
    '''
    
    # Parsing command line arguments.
    parser = argparse.ArgumentParser(
        description='''
            Filter tracks in EDL.
        ''')
    parser.add_argument('source', type=argparse.FileType(mode='r'), help='source EDL file')
    parser.add_argument('-t', '--tracks', type=str, help='tracks to filter', default='A')
    parser.add_argument('-f', '--fps', type=str, help='EDL frame rate', default='24')
    args = parser.parse_args()

    # tracks name pattern to filter
    pattern = args.tracks
    # create edl parser with corresponding frame rate
    print(f'Working in {args.fps}fps')
    parser = Parser(args.fps)
    
    # read EDL file
    edl = parser.parse(args.source)
    # filter events, with matching track name
    num_filtered = filter_tracks(edl, pattern)
    
    with open(outname(args.source.name), 'w') as output:
        output.write(edl.to_string())

    print(f'Filtered {num_filtered} events matching \'{pattern}\' in track name')

if __name__ == '__main__':
    main()

