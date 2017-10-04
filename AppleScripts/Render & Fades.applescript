--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Clicks on the render button of an Audio Suite plug-in if there is an open one.
-- 2. Waits for render to complete.
-- 3. Creates fades around the selection.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			-- Check whether there is an open Audio Suite window. 
			if (count (windows whose name contains "Audio Suite")) is 0 then
				display dialog "Can't find an Audio Suite plug-in." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			else
				-- Count windows before processing.
				set numBefore to count windows
				
				-- Click Render button.
				tell (1st window whose name contains "Audio Suite") to click button "Render"
				delay 0.2
				
				-- Count current number of windows.
				set num to count windows
				
				-- Wait until render completes.
				repeat while num is greater than numBefore
					delay 0.1
					set num to count windows
				end repeat
				
				-- Extend selection.
				key code 69 using {command down, shift down}
				key code 78 using {option down, shift down}
				
				-- Create fades.
				keystroke "f"
			end if
			
		end tell
	end tell
end tell