activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- check if RX Connect is open
		set RXopen to count (windows whose name contains "Audio Suite: RX Connect")
		
		-- open RX if needed
		if RXopen is 0 then
			click menu item "RX 6 Connect" of menu 1 of menu item "Noise Reduction" of menu "AudioSuite" of menu bar 1
			delay 1.5
		end if
		
		-- click SEND button
		tell (1st window whose name contains "Audio Suite") to click button "Analyze"
		
	end tell
end tell