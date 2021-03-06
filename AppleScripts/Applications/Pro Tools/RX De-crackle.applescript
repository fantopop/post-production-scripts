--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Processes selection using RX De-crackle with current settings.
-- The window is openeв if needed.
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
--

set plugin to "RX 7 De-crackle"
set windowName to "Audio Suite: " & plugin

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Check whether plugin window is open
		if (count (windows whose name contains windowName)) is 0 then
			display dialog "Can't find plug-in " & plugin & ". Open AudioSuite window first." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			return
		end if
		
		-- Count windows before processing.
		set numBefore to count windows
		
		-- Click Render button.
		set RXWindow to (1st window whose name contains windowName)
		perform action "AXRaise" of RXWindow
		tell RXWindow to click button "Render"
		delay 0.2
		
		-- Count current number of windows.
		set num to count windows
		
		-- Wait until render completes.
		repeat while num is greater than numBefore
			set num to count windows
			delay 0.1
		end repeat
		
		-- Extend selection.
		key code 69 using {command down, shift down}
		key code 78 using {option down, shift down}
		
		-- Create fades.
		keystroke "f"
		
	end tell
end tell
