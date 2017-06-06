tell application "System Events"
	tell process "Pro Tools"
		-- check if Automation window is open
		set auto_open to count (windows whose name is "")
		
		-- open Automation window if needed
		if auto_open is 0 then
			my openAutomation()
		else
			set theWindow to the first item of �
				(get the windows whose name is "")
			if theWindow is not window 1 then
				my openAutomation()
			end if
		end if
		
		-- click
		click button "Suspend Automation" of window 1
	end tell
end tell

on openAutomation()
	tell application "System Events"
		tell process "Pro Tools"
			click menu item "Automation" of menu "Window" of menu bar 1
		end tell
	end tell
end openAutomation