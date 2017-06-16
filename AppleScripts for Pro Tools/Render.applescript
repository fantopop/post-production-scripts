--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Clicks on the render button of an Audio Suite plug-in if there is an open one.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Check whether there is an open Audio Suite window.
		set ASOpen to count (windows whose name contains "Audio Suite")
		
		if ASOpen is 0 then
			display dialog "Can't find an Audio Suite plug-in." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
		else
			-- click Render button.
			tell (1st window whose name contains "Audio Suite") to click button "Render"
		end if
		
	end tell
end tell