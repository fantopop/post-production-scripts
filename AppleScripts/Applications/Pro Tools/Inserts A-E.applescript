--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Opens Inserts A-E panel.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			click menu item "Inserts A-E" of menu "Edit Window Views" of menu item "Edit Window Views" of menu "View" of menu bar item "View" of menu bar 1
		end tell
	end tell
end tell