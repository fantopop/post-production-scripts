--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Cuts the selection and makes fades on the edges.
-- Left fade - 2 nudge values, right fade - 1 nudge value.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Cut
		keystroke "x"
		
		-- Make selection to the left of the edge.
		key code 78 using {option down, shift down}
		key code 78 using {option down, shift down}
		
		-- Create left fade.
		keystroke "f"
		
		-- Tab to the right edge.
		key code 48
		key code 48
		
		-- Make selection to the right of the edge.
		key code 69 using {command down, shift down}
		
		-- Create right fade.
		keystroke "f"
	end tell
end tell