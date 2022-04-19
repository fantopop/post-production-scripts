-- Cut (blade)  on Memory Locations
-- Run this script to cut (blade) on every memory location in session
-- (C) Ilya Putilin, 2021
-- https:/github.com/fantopop

set short_delay to 0.1

tell application "System Events"
	tell application process "Pro Tools"
		activate
		set frontmost to true
		
		try
			set memory_locations_window to window "Memory Locations"
		on error
			click menu item "Memory Locations" of menu "Window" of menu bar item "Window" of menu bar 1
			set memory_locations_window to window "Memory Locations"
		end try
		
		tell memory_locations_window
			set memory_locations_table to table "Memory Locations"
			tell memory_locations_table
				repeat with memory_location in every row
					tell memory_location
						click UI element 2
						keystroke "b"
					end tell
				end repeat
			end tell
		end tell
	end tell
end tell

return "Open Messages tab of Log Output in lower left corner and run again the script"
