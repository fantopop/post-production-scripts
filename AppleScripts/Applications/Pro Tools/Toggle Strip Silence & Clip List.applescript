--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Closes Strips silence window and clip list.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
--

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		
		-- Close strip silence window.
		keystroke "u" using {command down}
		
		-- Close clip list
		click menu item "Clip List" of menu "Other Displays" of menu item "Other Displays" of menu "View" of menu bar item "View" of menu bar 1
	end tell
end tell
