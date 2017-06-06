activate application "iZotope RX 6 Audio Editor"
tell application "System Events"
	delay 0.02
	tell process "iZotope RX 6"
		-- press Cmd + Enter
		key code 36 using {command down}
	end tell
	delay 1
	
	tell process "Pro Tools"
		-- Render
		tell (1st window whose name contains "Audio Suite: RX Connect") to click button "Render"
		delay 0.5
		-- Close window
		tell (1st window whose name contains "Audio Suite: RX Connect") to click button 1
	end tell
end tell
