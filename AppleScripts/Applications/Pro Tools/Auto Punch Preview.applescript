--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Enables Preview Automation mode.
-- If the Automation window was not open, the scripts closes the window at the end of execution.
--
-- Note: Automation Preview mode is available in Pro Tools HD only.
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Check that Automation window is open
			set automationMenuItem to menu item "Automation" of menu "Window" of menu bar item "Window" of menu bar 1
			set status to value of attribute "AXMenuItemMarkChar" of automationMenuItem
			# Open Automation window if needed
			if status is not equal to "✓" then
				click automationMenuItem
			end if
			
			# Get Automation window
			set allWindows to every window of PT
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
			
			
		end tell
	end tell
end tell