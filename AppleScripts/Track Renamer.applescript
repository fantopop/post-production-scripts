--
-- AppleScripts for Avid Pro Tools.
--
-- Usage:
-- 1. Open track rename window and enter PREFIX for new track names in the "Name the track:" field.
-- 2. Run the script.
-- 3. Enter the number of tracks to rename.
--
-- Folowing tracks will be renamed to: PREFIX1, PREFIX2 ...
-- Track rename window is left open, so you can enter prefix for the next batch of tracks and run the script again.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

set Responce to display dialog "Enter number of tracks to rename?" default answer "1" buttons {"Cancel", "OK"} Â
	default button "OK" cancel button "Cancel"
set N to (text returned of Responce) as number

tell application "System Events"
	tell process "Pro Tools"
		# Get prefix from the text field
		set win to 1st window
		set prefix to name of 1st text field of win
		
		set i to 1
		repeat N times
			# Get rename window
			set win to 1st window
			
			# Get track name text field
			set txt to 1st text field of win
			
			# Click on the text field
			tell txt to perform action "AXPress"
			
			# Bring rename window to front
			set frontmost to true
			perform action "AXRaise" of win
			
			# Select all text
			keystroke "a" using {command down}
			
			# Construct new name for the track
			set TrackName to prefix & (i as string)
			keystroke TrackName
			
			# Go to the next track
			key code 124 using {command down}
			set i to i + 1
		end repeat
	end tell
end tell