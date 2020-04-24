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

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Copy Clip Gain
			click menu item "Clip Gain" of menu "Copy Special" of menu item "Copy Special" of menu "Edit" of menu bar item "Edit" of menu bar 1
			
			# Paste Clip Gain
			click menu item "Paste" of menu "Edit" of menu bar item "Edit" of menu bar 1
			
		end tell
	end tell
end tell