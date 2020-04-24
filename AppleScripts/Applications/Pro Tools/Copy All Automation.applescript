--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Copies all automation.
--
-- (C) 2019 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			click menu item "All Automation" of menu "Copy Special" of menu item "Copy Special" of menu "Edit" of menu bar item "Edit" of menu bar 1
		end tell
	end tell
end tell