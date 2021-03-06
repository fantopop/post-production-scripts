# AppleScripts for Avid Pro Tools
These scripts aim to enhance workflow and speed-up our daily work. AppleScript provides convenient methods for accessing menu items, windows, buttons and sending keystrokes to apps. Feel free to modificate scripts for your needs and upload new scripts to this repository.

## Usage
There are several ways to run script with a shortcut. The native macOS way is to configure a Service using Automator and assign a shortcut in System Preferences. [Here](http://davidteren.github.io/Pro-Tools-Edit-Macros/) you can find good step-by-step instructions for this method. But with Services there is a small but noticeable delay in performance. Also, it seems that iZotope RX Audio Editor does not support Services,  so I prefer using [FastScripts](https://red-sweater.com/fastscripts/). It alows to run scripts from `~/Library/Scripts` folder and assign shortcuts to them. You can assign 10 shortcuts for free, or pay $9.95 to unlock unlimited shortcuts.  
  
Sample shortcuts assignments can be found in [Keymap](#keymap) section.
  
If you don't like scripts, check [Soundflow](https://soundflow.org) or [Keyboard Maestro](https://www.keyboardmaestro.com).

## Installation for FastScripts
1. Install [FastScripts](https://red-sweater.com/fastscripts/).
2. Download [all scripts](https://github.com/fantopop/post-production-scripts/archive/master.zip) or choose manually the ones that you need.
3. Move `Back to Pro Tools.applescript` to `~/Library/Scripts/Applications/iZotope RX 6/` folder and all other scripts to `~/Library/Scripts/Applications/Pro Tools/`.
4. Assign shortcuts in FastScripts preferences.
<img src="https://www.dropbox.com/s/bm0anm3eguf8mgs/fastscripts_preferences.png?raw=true" width="400">
5. Enable access for assistive devices in Security & Privacy pane of System Preferences.
<img src="https://www.dropbox.com/s/bflud17z1xiwes7/accessibility.png?raw=true" width="600">

## Scripts
### Automation
A group of scripts for accessing Automation Window buttons. All scripts also work with a closed Automation Window, in this case it leaves it closed after performing an action.
#### [Enable Automation Preview mode](Applications/Pro%20Tools/Auto%20Preview.applescript)
#### [Punch Automation Preview](Applications/Pro%20Tools/Auto%20Punch%20Preview.applescript)
#### [Suspend Automation](Applications/Pro%20Tools/Auto%20Suspend.applescript)
#### [Write Automation to Selection](Applications/Pro%20Tools/Auto%20Write%20to%20Selection.applescript)
### iZotope RX
These scripts are currently configured to work with iZotope RX 6. Replace all occurrences of 6 with 5 to work with an older version of RX.
#### [Send to iZotope RX Audio Editor](Applications/Pro%20Tools/Send%20to%20RX.applescript)
Opens iZotope RX Connect plug-in window if needed and sends selection to iZotope RX Audio Editor. For some reason this script doesn't work with FastScripts, so it's the only one that I've installed as Service.
#### [Send from iZotope back to Pro Tools](Applications/iZotope%20RX%207/Back%20to%20Pro%20Tools.applescript)
Sends audio back from iZotope RX Audio Editor to Pro Tools, renders the selection and creates fades around the selection when render completes (2 nudge values to the left, 1 nudge value to the right).
### Smart tool
#### [Switch Trim Tool](Applications/Pro%20Tools/Switch%20Trim%20Tool.applescript)
Switches between Standard and Time Compression/Expansion Trim Tools leaving Smart Tool enabled.  
From <img src="https://www.dropbox.com/s/z65q9mhafixgyr3/smart_tool.png?raw=true" heigth="25"> to <img src="https://www.dropbox.com/s/42ks7qajq2oy2l1/trim_tool_tce.png?raw=true" heigth="25"> and back.
#### [Switch Grabber Tool](Applications/Pro%20Tools/Switch%20Trim%20Tool.applescript)
Switches between Smart Tool with Grabber Tool (Separation) and Grabber Tool (Object).  
From <img src="https://www.dropbox.com/s/z65q9mhafixgyr3/smart_tool.png?raw=true" heigth="25"> to <img src="https://www.dropbox.com/s/gadfh62fgxqtmai/grabber_tool_object.png?raw=true" heigth="25"> and back.
### SoundRadix Auto-Align
Two sripts to reduce amount of clicking on different buttons and windows while working with [SoundRadix Auto-Align](https://www.soundradix.com/products/auto-align/) plug-in. Both windows of Auto-Align are considered to be open.
#### [Auto-Align Detect](Applications/Pro%20Tools/Auto-Align%20Detect.applescript)
Toggles "Detect" state of currently open Auto-Align track insert.
#### [Auto-Align](Applications/Pro%20Tools/Auto-Align.applescript)
Performs these actions at once:
1. Copy current settings of the Auto-Align track insert.
2. Paste these settings to an open AudioSuite Auto-Align plug-in.
3. Render selection with these settings.
4. Wait for render to complete and create fades around the selection.
5. Bring track insert window back to front.
#### [Auto-Align Nudge](Applications/Pro%20Tools/Auto-Align%20Nudge.applescript)
Reades delay in an open Auto-Align window and nudges selected clips by this number of __samples__. Be carefull, as Pro Tools can't nudge the clip if the are no handles, for example the clip is processed by an AudioSuite plug-in. In this case, process the clip(s) using [Auto-Align](Auto-Align.applescript) script.
### Render
Renders the selection with frontmost or last frontmost AudioSuite plug-in. 
#### [Render](Applications/Pro%20Tools/Render.applescript)
#### [Render & Fades](Applications/Pro%20Tools/Render%20&%20Fades.applescript)
Creates fades around the selection when render completes (2 nudge values to the left, 1 nudge value to the right).
### Miscellaneous
#### [Backup to playlist](Applications/Pro%20Tools/Backup%20to%20playlist.applescript)
Copies selection to the first unoccupied alternate playlist. Please, be sure that there is one, the script wouldn't create the new playlist, if there are none available - it will paste the selection to the first onoccupied track.
#### [Cut & Fades](Applications/Pro%20Tools/Cut%20&%20Fades.applescript)
Cuts selection and creates fades around it.
#### [Toggle Inserts A-E panel](Applications/Pro%20Tools/Inserts%20A-E.applescript)
#### [Strip Silence & Fades](Applications/Pro%20Tools/Strip%20Silence.applescript)
Strips silence with current settings. It's handy to run script without opening Strip Silence window, in this case the script will close the window at the end. This script is intended to work with long narrative tracks recorded with similar gain for the whole track. You can adjust Strip Silence settings once and then use it in place with one keystroke.
#### [Track Renamer](Applications/Pro%20Tools/Track%20Renamer.applescript)
Renames number of tracks, giving them sequential names. Usage:

1. Open track rename window and enter `PREFIX` for new track names in the `Name the track` field.
2. Run the script.
3. Enter the number of tracks to rename.

Folowing tracks will be renamed to: `PREFIX1`, `PREFIX2` ... Track rename window is left open, so you can enter prefix for the next batch of tracks and run the script again.

## Keymap
This is my keymap for most frequent actions. You can skip this or use it as a starting point.

| Action                        | Shortcut | Type          |
|-------------------------------|----------|---------------|
| Send to RX                    | ^⌘Z      | Script        |
| Back to Pro Tools             | ^⌘\`     | Script        |
| Favourite Audiosuite plug-ins | ^⌥ 1..9  | Menu shortcut |
| Render                        | ^⌥R      | Script        |
| Render & Fades                | ⌥⇧R      | Script        |
| Auto-Align Detect             | §        | Script        |
| Auto-Align                    | ^A       | Script        |
| Enable Automation Preview     |          | Script        |
| Punch Automation Preview      |          | Script        |
| Write Automation to Selection |          | Script        |
| Suspend Automation            | ^S       | Script        |
| Backup to playlist            | ⌥B       | Script        |
| Cut & Fades                   | ⌥X       | Script        |
| Strip Silence & Fades         | ⌥S       | Script        |
| Track Renamer                 | ⌘R       | Script        |
| Track List                    | F16      | Menu shortcut |
| Inserts A-E                   | F17      | Script        |
| Track I/O                     | F18      | Menu shortcut |
| Clip List                     | F19      | Menu shortcut |

Menu shortcuts can be easily configured in Keyboard pane of System Preferences. Just add the exact name of the Pro Tools menu item.  
<img src="https://www.dropbox.com/s/siq2n9poai28fxt/keyboard.png?raw=true" width="600">
