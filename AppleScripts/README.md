# AppleScripts for Avid Pro Tools
These scripts aim enhancing workflow and speeding-up our daily work. AppleScript provides convenient methods for accessing menu items, windows, buttons and sending keystrokes to apps. Feel free to modificate scripts for your needs and upload new scripts to this repository.

## Usage
There are several ways to run script with a shortcut. The native macOS way is to configure a Service using Automator app and assign a shortcut in System Preferences. [Here](http://davidteren.github.io/Pro-Tools-Edit-Macros/) you can find a good step-by-step instructions for this method. But with Services there is small but noticeable delay in performance. Also it seems, that iZotope RX Audio Editor does not support services,  so I prefer using [FastScripts](https://red-sweater.com/fastscripts/) app. It alows to run scripts from `~/Library/Scripts` folder and assign shortcuts to them. Your can assign 10 shortcuts for free, or pay $9.95 to unlock unlimited shortcuts.  
Also you can check [Soundflow](https://soundflow.org) and [Keyboard Maestro](https://www.keyboardmaestro.com).

## Keymap
This is my keymap for most frequent actions. You can skip this, or use it as a starting point.
| Action                      | Shortcut | Type     |
|-------------------------------|----------|----------|
| Send to RX                    | ^⌘Z      | Script   |
| Back to Pro Tools             | ^⌘\`     | Script   |
| Favourite Audiosuite plug-ins | ^⌥ 1..9  | Shortcut |
| Render                        | ^⌥R      | Script   |
| Render & Fades                | ⌥⇧R      | Script   |
| Enable Automation Preview     |          | Script   |
| Punch Automation Preview      |          | Script   |
| Write Automation to Selection |          | Script   |
| Suspend Automation            | ^S       | Script   |
| Backup to playlist            | ⌥B       | Script   |
| Cut & Fades                   | ⌥X       | Script   |
| Strip Silence & Fades         | ⌥S       | Script   |
| Track List                    | F16      | Shortcut |
| Inserts A-E                   | F17      | Script   |
| Track I/O                     | F18      | Shortcut |
| Clip List                     | F19      | Shortcut |
## Scripts
### Automation
A group of scripts for accessing Automation Window buttons. All scripts also work with a closed Automation Window, in this case it leaves it closed after performing an action.
#### [Enable Automation Preview mode](AppleScripts/Auto%20Preview.applescript)
Toggles Automation Preview mode.
#### [Punch Automation Preview](AppleScripts/Auto%20Punch%20Preview.applescript)
#### [Suspend Automation](AppleScripts/Auto%20Suspend.applescript)
#### [Write Automation to Selection](AppleScripts/Auto%20Write%20to%20Selection.applescript)
### iZotope RX
These scripts are currently configured to work with iZotope RX 6. Replace all occurrences of 6 with 5 to work with an older version of RX.
#### [Send to iZotope RX Audio Editor](AppleScripts/Send%20to%20RX.applescript)
Opens iZotope RX Connect plug-in window if needed, and sends selection to iZotope RX Audio Editor app. For some reason this script isn't working with FastScripts app, so this is the only one ser
#### [Send from iZotope back to Pro Tools](AppleScripts/Back%20to%20Pro%20Tools.applescript)
Sends audio back from iZotope RX Audio Editor to Pro Tools, renders the selection and creates fades around the selection (2 nudge values to the left, 1 nudge value to the right.)
### Render
#### [Render](AppleScripts/Render.applescript)
#### [Render & Fades](AppleScripts/Render%20&%20Fades.applescript)
### Miscellaneous
#### [Backup to playlist](AppleScripts/Backup%20to%20playlist.applescript)
#### [Cut & Fades](AppleScripts/Cut%20&%20Fades.applescript)
#### [Toggle Inserts A-E panel](AppleScripts/Inserts%20A-E.applescript)
#### [Strip Silence & Fades](AppleScripts/Strip%20Silence.applescript)
