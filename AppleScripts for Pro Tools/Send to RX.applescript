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
		-- Check if RX Connect is open.
		set RXopen to count (windows whose name contains "Audio Suite: RX" and name contains "Connect")
		
		-- Open RX Connect if needed.
		if RXopen is 0 then
			click menu item "RX 6 Connect" of menu "Noise Reduction" of menu item "Noise Reduction" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
			
			-- Wait until the window opens.
			repeat while RXopen is 0
				delay 0.05
				set RXopen to count (windows whose name contains "Audio Suite: RX" and name contains "Connect")
			end repeat
		end if
		
		-- Click SEND button
		tell (1st window whose name contains "Audio Suite: RX" and name contains "Connect") to click button "Analyze"
		
	end tell
end tell
