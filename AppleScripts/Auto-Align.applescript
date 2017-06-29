--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Copies settings from Auto-Align plug-in in the track.
-- 2. Pastes settings to AudioSuite Auto-Align plug-in.
-- 3. Renders selection with Auto-Align.
-- 4. Creates fades around the selection.
-- 5. Brings track plug-in back to front.
-- 
-- Both intanses of Auto-Align need to be open in prior.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Check whether there is an open Audio Suite window.
		set ASOpen to count (windows whose name contains "Audio Suite: Auto-Align")
		-- Check whether there is an open track plug-in window.
		set TROpen to count (windows whose name contains "Plug-in: Auto-Align")
		
		if (ASOpen + TROpen) < 2 then
			display dialog "Auto-Align track plug-in and Audio Suite plug-in should be open." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			return
		end if
		
		-- Bring track plug-in to front.
		set trackWindow to (1st window whose name contains "Plug-in: Auto-Align")
		perform action "AXRaise" of trackWindow
		
		-- Copy settings.
		keystroke "C" using {command down, shift down}
		
		-- Bring Audio Suite plug-in to front.
		set ASWindow to (1st window whose name contains "Audio Suite: Auto-Align")
		perform action "AXRaise" of ASWindow
		
		-- Paste settings.
		keystroke "V" using {command down, shift down}
		
		-- Render.
		set numBefore to count windows
		tell ASWindow to click button "Render"
		
		-- Wait until render completes.
		delay 0.2
		-- Count current number of windows.
		set num to count windows
		repeat while num is greater than numBefore
			delay 0.1
			set num to count windows
		end repeat
		
		-- Extend selection.
		key code 69 using {command down, shift down}
		key code 78 using {option down, shift down}
		
		-- Create fades.
		keystroke "f"
		
		-- Bring track plug-in back to front.
		perform action "AXRaise" of trackWindow
	end tell
end tell