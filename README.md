# post-production-scripts
Collection of AppleScripts and Python (compatible with Python2.7 and Python3.x) scripts for audio post-production, including batch rename, EDL management, shortcuts for Pro Tools etc.
1. [correct_edl.py](#correct_edlpy)
2. [rename_mixer_files.py](#rename_mixer_filespy)
3. [tracks_to_csv.py](#tracks_to_csvpy)  
4. [Send to RX](#send-to-rx)
5. [Suspend Automation](#suspend-automation)

## How to use scripts (macOS):
1. Download `.py` file (and other files if neccessary).
2. Open Terminal.app.
3. Type `python `
4. Drag script from the Finder to the Terminal window.
5. Specify options and input file(s) (see detailed description for corresponding script) and press return.

You can run scripts with `-h` option to see help message and options description.

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

## tracks_to_csv.py
This scripts converts `.txt` file, that could be exported from Pro Tools using *Export Session Info as Text* command, into `.csv` file.
This CSV file can be easily opened with Numbers.app or Excel.
#### Usage
```
usage: tracks_to_csv.py [-h] [-t] textfile

Converts '.txt' file from Pro Tools 'Export Session Info as Text' command to
'.csv' file

positional arguments:
  textfile      session info text file from Pro Tools

optional arguments:
  -h, --help    show this help message and exit
  -t, --tracks  skip TRACK_NAME column, group by tracks instead
```

#### Options
There are two formats available:
1. With `TRACK_NAME` column as one table.

| TRACK_NAME 	| EVENT 	| CLIP_NAME     	| START       	| END         	| DURATION    	|
|------------	|-------	|---------------	|-------------	|-------------	|-------------	|
| JOHN       	| 1     	| TOO NOISY     	| 01:03:28:04 	| 01:03:46:03 	| 00:00:17:24 	|
| JOHN       	| 2     	| BAD ACTING    	| 01:09:00:07 	| 01:09:50:24 	| 00:00:50:17 	|
| MARY       	| 1     	| OUTDOOR NOISE 	| 01:16:18:01 	| 01:16:21:13 	| 00:00:03:12 	|
| MARY       	| 2     	| OUTDOOR NOISE 	| 01:18:48:17 	| 01:18:49:23 	| 00:00:01:06 	|
| MARY       	| 3     	| NOT SURE???   	| 03:00:00:00 	| 03:01:28:08 	| 00:01:28:08 	|
2. Grouped by `TRACK NAME` with `[--tracks]` option.

| TRACK NAME: 	| JOHN          	| START       	| END         	| DURATION    	|
|-------------	|---------------	|-------------	|-------------	|-------------	|
| 1           	| TOO NOISY     	| 01:00:11:18 	| 01:01:22:05 	| 00:01:10:11 	|
| 2           	| BAD ACTING    	| 05:11:28:07 	| 05:11:48:19 	| 00:00:20:12 	|
|             	|               	|             	|             	|             	|
| TRACK NAME: 	| MARY          	| START       	| END         	| DURATION    	|
| 1           	| OUTDOOR NOISE 	| 01:03:28:04 	| 01:03:46:03 	| 00:00:17:24 	|
| 2           	| NOT SURE???   	| 01:09:00:07 	| 01:09:50:24 	| 00:00:50:17 	|
| 3           	| TOO NOISY     	| 05:01:56:13 	| 05:02:32:17 	| 00:00:36:04 	|

## Send to RX
These scripts alow to make a selection in Pro Tools and send it to iZotope Audio Editor, and after editing, send it back to Pro Tools and render. You can configure Apple Service for Send to RX script to assign a shortcut. [Here](http://davidteren.github.io/Pro-Tools-Edit-Macros/) is a good step-by-step instructions for configuring Service. It seems that Services are not supported in iZopope RX Audio Editor, so for Back to Pro Tools script [FastScripts](https://red-sweater.com/fastscripts/) app can be used for assigning a shortcut.  
#### Modification
In this repository the scripts are written to communicate with iZotope RX 6, but this can be easily fixed to work with RX 5 (or RX 4), just replace `RX 6 Connect`, `iZotope RX 6 Audio Editor` and `iZotope RX 6` with yours RX version.

## Suspend Automation
If installed as Service, this script allows to enable/disable Suspend Automation with one shortcut. Apparently can be applied to toggle Preview automation mode, with slight modifications to the script body.
