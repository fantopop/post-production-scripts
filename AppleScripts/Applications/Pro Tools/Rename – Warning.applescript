--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Adds ⚠️ to the beginning of every clip name in edit selection
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Check if the menu item Rename is enabled.
			set checkSelection to enabled of menu item "Rename..." of menu "Clip" of menu bar item "Clip" of menu bar 1
			
			if checkSelection is true then
				# Count windows
				set countBefore to count windows
				
				# Open rename dialog
				click menu item "Rename..." of menu "Clip" of menu bar item "Clip" of menu bar 1
				# delay 0.1
				
				repeat while (count windows) is greater than countBefore
					# Move cursor to the beginning of the clip name
					key code 123 # Left arrow.
					# delay 0.1
					
					# Add warning emoji				
					set the clipboard to "⚠️ "
					keystroke "v" using command down
					
					# Confirm rename
					key code 76
				end repeat
			else
				display dialog "No clips in edit selection" buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			end if
		end tell
	end tell
end tell