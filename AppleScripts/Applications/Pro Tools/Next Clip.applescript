--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Select next continuous clip with fades.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Up Arrow
		key code 126
		
		-- Enable Grabber Object Tool
		-- F8 twice
		key code 100
		key code 100
		
		-- Select next clip
		-- Tab
		key code 48
		-- Shift + Tab twice
		key code 48 using {shift down}
		key code 48 using {shift down}
		
		-- Enable back Smart Tool
		key code 100
		key code 100
		key code 53
	end tell
end tell