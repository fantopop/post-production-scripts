--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Sends audio back to Pro Tools.
-- 2. Renders the selection.
-- 3. Creates fades around the selection.
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
--

set RXVersion to "8"

activate application ("iZotope RX " & RXVersion & " Audio Editor")
tell application "System Events"
	-- Send to Pro Tools.
	tell process ("iZotope RX " & RXVersion)
		-- press Cmd + Enter
		key code 36 using {command down}
	end tell
	delay 0.5
	
	tell process "Pro Tools"
		-- Count windows before processing.
		set numBefore to count windows
		
		-- Click Render button.
		set RXWindow to (1st window whose name contains ("Audio Suite: RX " & RXVersion & " Connect"))
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
		
		-- Close window
		-- tell (1st window whose name contains "Audio Suite: RX 7 Connect") to click button 1
	end tell
end tell
