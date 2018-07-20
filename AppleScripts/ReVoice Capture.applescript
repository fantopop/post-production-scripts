--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Sends selection to Revoice Pro.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			-- Check if RX Connect is open.
			set ReVoiceOpen to count (windows whose name contains "Audio Suite: Revoice Pro")
			
			-- Open RX Connect if needed.
			if ReVoiceOpen is 0 then
				click menu item "Revoice Pro APT" of menu "Other" of menu item "Other" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
				
				-- Wait until the window opens.
				repeat while ReVoiceOpen is 0
					delay 0.05
					set ReVoiceOpen to count (windows whose name contains "Audio Suite: Revoice Pro")
				end repeat
			end if
			
			-- Click SEND button
			tell (1st window whose name contains "Audio Suite: Revoice Pro") to click button "Analyze"
			
		end tell
	end tell
end tell