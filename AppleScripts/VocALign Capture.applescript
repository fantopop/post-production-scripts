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
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			-- Check whether there is an open track plug-in window.
			set isOpen to count (windows whose name contains "Audio Suite: VocALign")
			
			-- Open plug-in if needed.
			if isOpen < 1 then
				# display dialog "Can't find VocALign plug-in window." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
				# return
				click menu item "VocALign Project" of menu "Other" of menu item "Other" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
			end if
			
			-- Bring plug-in to front.
			set win to (1st window whose name contains "Audio Suite: VocALign")
			perform action "AXRaise" of win
			
			click button "Analyze" of win
		end tell
	end tell
end tell