tell application "System Events"
	tell process "Pro Tools"
		-- check if Automation window is open
		set auto_open to count (windows whose name is "")
		
		-- open Automation window if needed
		if auto_open is 0 then
			click menu item "Automation" of menu "Window" of menu bar 1
		end if
		
		-- click
		click button "Suspend Automation" of window 1
	end tell
end tell