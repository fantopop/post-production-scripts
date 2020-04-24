#
# AppleScripts for Avid Pro Tools.
#
# Script description:
# Copies selection to the first unoccupied alternate playlist.
# Warning! Before applying, make sure that the are empty playlists for the selected track.
#
# (C) 2017 Ilya Putilin
# http://github.com/fantopop
# 

set max_tries to 15

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Try to open playlists.
			# In case of warning - cancel the action.
			
			# Backup windows count to catch warning message
			set countBefore to count windows
			
			# Open playlists.
			key code 123 using {command down, control down}
			
			set countAfter to count windows
			
			# If warning message has appeared:
			if countBefore is not equal to countAfter then
				# Hit ESC.
				key code 53
				display dialog "Can't open playlists. Try to remove all clip groups from the track" buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
				return
			end if
			
			# Copy selection
			keystroke "c"
			
			# Counter of skipped playlists
			set i to 0
			
			set occupied to true
			# Search for the first unoccupied playlist
			repeat while occupied and (i is less than max_tries)
				# Move selection down
				keystroke ";"
				
				# Check if the menu item Clip/Rename... is enabled.
				# If no clips are present in the selection, this item won't be enabled.
				set occupied to enabled of menu item "Clip Gain" of menu "Clear Special" of menu item "Clear Special" of menu "Edit" of menu bar item "Edit" of menu bar 1
				
				# Increment counter of skipped playlists
				set i to (i + 1)
			end repeat
			
			# Paste selection.
			keystroke "v"
			
			# Go up to the main playlist
			repeat i times
				keystroke "p"
			end repeat
			
			# Close playlists.
			key code 124 using {command down, control down}
		end tell
	end tell
end tell