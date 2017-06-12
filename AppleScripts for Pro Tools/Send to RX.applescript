--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Sends selection to iZotope RX Audio Editor using RX Connect plug-in.
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
