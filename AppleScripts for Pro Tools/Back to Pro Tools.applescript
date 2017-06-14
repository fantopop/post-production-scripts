--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Sends audio back to Pro Tools.
-- 2. Renders the selection.
-- 3. Creates fades around the selection.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
--

activate application "iZotope RX 6 Audio Editor"
tell application "System Events"
	delay 0.02
	-- Send to Pro Tools.
	tell process "iZotope RX 6"
		-- press Cmd + Enter
		key code 36 using {command down}
	end tell
	delay 0.5
	
	tell process "Pro Tools"
		-- Count windows before processing.
		set numBefore to count windows
		
		-- Click Render button.
		tell (1st window whose name contains "Audio Suite: RX 6 Connect") to click button "Render"
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
		
		-- Close window
		-- tell (1st window whose name contains "Audio Suite: RX 6 Connect") to click button 1
	end tell
end tell
