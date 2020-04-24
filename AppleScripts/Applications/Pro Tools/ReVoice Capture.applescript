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
			
			-- Check if Revoice APT is open.
			set ReVoiceOpen to count (windows whose name contains "Audio Suite: Revoice Pro")
			
			-- Open Revoice APT if needed.
			if ReVoiceOpen is 0 then
				click menu item "Revoice Pro APT" of menu "Other" of menu item "Other" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
				
				-- Wait until the window opens.
				repeat while ReVoiceOpen is 0
					delay 0.05
					set ReVoiceOpen to count (windows whose name contains "Audio Suite: Revoice Pro")
				end repeat
			end if
			
			set Revoice to (1st window whose name contains "Audio Suite: Revoice Pro")
			
			-- Click "Capture" button
			tell Revoice to click button "Analyze"
			
			-- Wait until Capture performs
			
			-- Count windows before processing.
			set numBefore to count windows
			-- Count current number of windows.
			set num to count windows
			
			-- Wait until render completes.
			repeat while num is greater than numBefore
				set num to count windows
				delay 0.1
			end repeat
			
			-- Move selection down
			keystroke ";"
			
			delay 0.05
			
			-- Click "Capture" button
			tell Revoice to click button "Analyze"
			
		end tell
		
		-- Switch to Revoice window
		tell process "Revoice Pro"
			activate
			set frontmost to true
		end tell
	end tell
end tell