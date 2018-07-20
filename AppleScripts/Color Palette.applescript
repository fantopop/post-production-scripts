--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Opens Inserts A-E panel.
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
			
			click menu item "Color Palette" of menu "Window" of menu bar item "Window" of menu bar 1
		end tell
	end tell
end tell