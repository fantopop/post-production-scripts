--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Enables Preview Automation mode.
-- If the Automation window was not open, the scripts closes the window at the end of execution.
--
-- Note: Automation Preview mode is available in Pro Tools HD only.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "System Events"
	tell process "Pro Tools"
		-- Get list of all floating windows without title.
		-- If Automation window is open, it should be among them.
		set allWindows to (get the windows whose name is "")
		
		if length of allWindows is greater than 0 then
			-- Search within windows without title.
			repeat with currentWindow in allWindows
				-- Automation window can be determined by presence of Suspend Automation button.
				if (count (buttons of currentWindow whose title contains "Suspend Automation")) is greater than 0 then
					-- Click and exit the script.
					click button "Punch Automation Preview" of currentWindow
					return
				end if
			end repeat
		end if
		
		-- If there is no open windows without title, or window not found, open Automation window.
		click menu item "Automation" of menu "Window" of menu bar item "Window" of menu bar 1
		-- Click.
		set automationWindow to (1st window whose name is "")
		tell automationWindow to click button "Punch Automation Preview"
		-- Close the window.
		tell automationWindow to click button 1
		
	end tell
end tell
