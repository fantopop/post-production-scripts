--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Enables Suspend Automation mode.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- check if RX Connect is open
		
		set RXopen to count (windows whose name contains "Audio Suite: RX" and name contains "Connect")
		
		-- open RX if needed
		if RXopen is 0 then
			click menu item "RX 6 Connect" of menu "Noise Reduction" of menu item "Noise Reduction" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
			delay 0.9
		end if
		
		-- click SEND button
		tell (1st window whose name contains "Audio Suite: RX" and name contains "Connect") to click button "Analyze"
		
	end tell
end tell


tell application "System Events"
	tell process "Pro Tools"
		-- Get list of all floating windows without title.
		-- If Automation window is open, it should be among them.
		set allWindows to (get the windows whose name is "")
		
		if length of allWindows is greater than 0 then
			-- Search within windows without title.
			repeat with currentWindow in allWindows
				-- Automation window can be determined by presence of Suspend Automation button.
				set isAutomationWindow to count (buttons of currentWindow whose title contains "Suspend Automation")
				if isAutomationWindow is greater than 0 then
					-- Click and exit the script.
					click button "Suspend Automation" of currentWindow
					return
				end if
			end repeat
		end if
		
		-- If there is no open windows without title, or window not found,
		-- open Automation window.
		click menu item "Automation" of menu "Window" of menu bar item "Window" of menu bar 1
		-- Click.
		tell (1st window whose name is "") to click button "Suspend Automation"
		
	end tell
end tell
