--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Switches between Standard Trim Tool and TCE Trim Tool whith Smart Tool enabled.
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
			set TCE to (count (buttons of CursorToolCluster whose name contains "Time Compression/Expansion"))
			set TrimButton to (first button of CursorToolCluster whose name contains "Trim")
			set SmartTool to (first button of CursorToolCluster whose name contains "Smart")
			
			tell TrimButton to perform action "AXPress"
			repeat 1 + TCE times
				key code 97
			end repeat
			tell SmartTool to perform action "AXPress"
		end tell
	end tell
end tell