--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Switches between Smart Tool with Grabber tool (Separation) and Grabber tool (Object).
--
-- (C) 2018 Ilya Putilin
-- http://github.com/fantopop
-- 

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			# activate
			# set frontmost to true
			
			set EditWindow to first window whose name contains "Edit:"
			set CursorToolCluster to first group of EditWindow whose name contains "Cursor Tool CLuster"
			
			# Check wether Grabber tool (Object) is selected
			set Object to (count (buttons of CursorToolCluster whose name contains "Grabber tool (Object)"))
			
			set GrabberButton to (first button of CursorToolCluster whose name contains "Grabber")
			set SmartTool to (first button of CursorToolCluster whose name contains "Smart")
			
			# Switch between Grabber tool Separation and Object (press F8 twice)
			key code 100
			key code 100
			
			# After switching from Object enable Smart tool
			if Object > 0 then
				tell SmartTool to perform action "AXPress"
			end if
		end tell
	end tell
end tell