--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Clicks on the render button of an Audio Suite plug-in if there is an open one.
-- 2. Waits for render to complete.
-- 3. Creates fades around the selection.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Check whether there is an open Audio Suite window.
		set ASOpen to count (windows whose name contains "Audio Suite")
		
		if ASOpen is 0 then
			display dialog "Can't find an Audio Suite plug-in." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
		else
			-- Count windows before processing.
			set numBefore to count windows
			
			-- Click Render button.
			tell (1st window whose name contains "Audio Suite") to click button "Render"
			delay 0.1
			
			-- Count current number of windows.
			set num to count windows
			
			-- Wait until render completes.
			repeat while num is greater than numBefore
				set num to count windows
				delay 0.1
			end repeat
			delay 0.1
			
			-- Extend selection.
			key code 69 using {command down, shift down}
			delay 0.02
			key code 78 using {option down, shift down}
			delay 0.02
			
			-- Create fades.
			keystroke "f"
		end if
		
	end tell
end tell
