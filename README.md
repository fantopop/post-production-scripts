# post-production-scripts
Collection of AppleScripts and Python (compatible with Python2.7 and Python3.x) scripts for audio post-production, including batch rename, EDL management, shortcuts for Pro Tools etc.
- [AppleScripts for Pro Tools](AppleScripts)
- [correct_edl.py](#correct_edlpy)
- [rename_mixer_files.py](#rename_mixer_filespy)
- [Session info to table converter](#session-info-to-table-converter)  

## AppleScripts for Pro Tools.
Scripts for Pro Tools to enhance workflow and speed-up our daily work. See details in [README.md](AppleScripts/README.md) file in corresponding folder.
* Automation
  - Enable Automation Preview mode
  - Punch Automation Preview
  - Suspend Automation
  - Write Automation to Selection
* iZotope RX
  - Send to iZotope RX Audio Editor
  - Send from iZotope back to Pro Tools
* SoundRadix Auto-Align
  - Auto-Align Detect
  - Auto-Align
* Render
  - Render
  - Render & Fades
* Miscellaneous
  - Backup to playlist
  - Cut & Fades
  - Toggle Inserts A-E panel
  - Strip Silence & Fades
  - Track Renamer

## How to use Python scripts (macOS):
1. Download `.py` file (and other files if neccessary).
2. Open Terminal.app.
3. Type `python `
4. Drag script from the Finder to the Terminal window.
5. Specify options and input file(s) (see detailed description for corresponding script) and press return.

You can run scripts with `-h` option to see help message and available options.

## correct_edl.py
Replaces strings in `*FROM CLIP NAME` field of the EDL, accroding to the dictionary from the `.json` file. Corrected EDL is written to the new file, with `.corrected` added to the filename. Lines, starting with `*SOURCE FILE` are omitted. Main event lines are leaved unchanged.  
Example edl's are provided in `edl` folder.

#### Usage
```
usage: correct_edl.py [-h] [-d DICT] [-s] edl

Replaces strings in *FROM CLIP NAME field of the EDL, accroding to the
dictionary from the .json file

positional arguments:
  edl                   source EDL file

optional arguments:
  -h, --help            show this help message and exit
  -d DICT, --dict DICT  replacements dictionary in JSON format,
                        'replacements_dict.json' is used, if not specified
  -s, --stat            print detailed replacements statistics
```  
The dictionary can be updated, just maintain the given in the example format:  
```
'REPLACE_THIS.MXF': 'WITH CORRECT CLIP NAME'
'AND_REPLACE_THIS.MXF': 'WITH ANOTHER CLIP NAME'
...
```
#### Options
* You can specify dictionary file with `-d DICT` option.
* Use `-s` option to print out all replacements.

##  Session info to table converter
[tracks_to_table.py](../master/Session%20info%20to%20table/tracks_to_table.py) script converts `.txt` file, that could be exported from Pro Tools using *Export Session Info as Text* command, into `.html` or `.csv` file. HTML is ready to print, and CSV could be easily edited in Numbers.app or Excel. Also an [macOS app](../master/Session%20info%20to%20table/Tracks_to_Table_macos_app.zip) with drag-n-drop support is provided.

> Note: it's recommended to print HTML file from Google Chrome browser.
<img src="https://www.dropbox.com/s/3r6wli0fawqqje7/HTML-table.png?raw=true" width="600">

#### macOS App
<img src="https://www.dropbox.com/s/68sqilwejvf9epy/converter.png?raw=true" width="240">

#### Script usage  
```
usage: tracks_to_table.py [-h] --to {csv,html} textfile

Converts '.txt' file from Pro Tools 'Export Session Info as Text' command to
'.csv' or '.html' file

positional arguments:
  textfile         session info text file from Pro Tools

optional arguments:
  -h, --help       show this help message and exit
  --to {csv,html}  export format: "csv" or "html"
```

## rename_mixer_files.py
Batch rename files from format:  
``` 05-5-160928_1009.wav```  
to:  
```1009_05-5-160928.wav```  
where `1009` - recording time, `05-5` - channel number, `160928` - shooting date.  

This was done to group files by takes (recording time).  
Sample empty `.wav` files are provided in `files` folder.
#### Usage
```
usage: rename_mixer_files.py [-h] [-r] path

rename files from '05-5-160928_1009.wav' to '1009_05-5-160928.wav, ' where
1009 - recording time, 05-5 - channel number, 160928 - date

positional arguments:
  path          path to the folder with files to be renamed

optional arguments:
  -h, --help    show this help message and exit
  -r, --rename  run script without this option to preview results

Warning: Always backup files before renaming!
```
#### Options
* Use `-r` option to rename files. Without this option changes are previewed only.

It's strongly recommended to try the script without renaming, to preview what changes could be done.
