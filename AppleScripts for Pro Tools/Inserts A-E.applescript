--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Opens Inserts A-E panel.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "System Events"
	tell process "Pro Tools"
		click menu item "Inserts A-E" of menu "Edit Window Views" of menu item "Edit Window Views" of menu "View" of menu bar item "View" of menu bar 1
	end tell
end tell