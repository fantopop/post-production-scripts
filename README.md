# post-production-scripts
Collection of Python (compatible with Python2.7 and Python3.x) scripts for audio post-production, including batch rename, EDL management etc.

## correct_edl.py
Replaces strings in `*FROM CLIP NAME` field of the EDL, accroding to the dictionary from the *.json* file. Corrected EDL is written to the new file, with *.corrected* added to the filename. Lines, starting with `*SOURCE FILE` are omitted. Main event lines are leaved unchanged.  
Example edl's are provided in *edl* folder.
#### Usage
```python correct_edl.py [--dict dict.json] [--stat] edl```
#### Options
* You can specify dictionary file with `--dict dictfilename.json` option.
* Use `--stat` option to print out all replacements.
* Path to original edl is passed after all options.

## rename_mixer_files.py
Batch rename files from format:  
``` 05-5-160928_1009.wav```  
to:  
```1009_05-5-160928.wav```  
where `1009` - recording time, `05-5` - channel number, `160928` - shooting date.  

This was done to group files by takes (recording time).  
Sample empty *.wav* files are provided in *files* folder.
#### Usage
```python rename_mixer_files.py [--rename] path_to_dir```
#### Options
* Use `--rename` option to print out all replacements.
* Scpecify path folder with files.
It's strongly recommended to try the script without renaming, to preview what changes could be done.

## text session info to fancy edl
Converts text file, that could be exported from Pro Tools using *Export Session Info as Text* command into pretty-looking EDL-like textfile with 3 columns: `EVENT, START, END, DURATION`.
Script is written as [IPython](https://ipython.org) notebook ([Jupyter](https://jupyter.org)) and is using [pandas](http://pandas.pydata.org) package. Sample files are provided.
