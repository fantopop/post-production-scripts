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
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 


set request to display dialog "Enter number of tracks to rename?" default answer "1" buttons {"Cancel", "OK"} default button "OK" cancel button "Cancel"
set N to (text returned of request) as number

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Get prefix from the text field
			set prefix to name of 1st text field of front window
			
			set i to 1
			repeat N times
				# Iterate to find unused number i with current prefix
				set renamed to false
				repeat while renamed is false
					# Bring rename window to front
					set frontmost to true
					perform action "AXRaise" of front window
					
					# Select all text
					keystroke "a" using {command down}
					
					# Construct new name for the track
					set TrackName to prefix & (i as string)
					keystroke TrackName
					
					# Go to the next track
					key code 124 using {command down}
					
					# Check for valid new track name
					set newWindowName to name of front window
					if newWindowName is "" then
						# Dismiss error window
						key code 36
						# Increment i
						set i to i + 1
					else
						set renamed to true
					end if
				end repeat
				set i to i + 1
			end repeat
		end tell
	end tell
end tell
