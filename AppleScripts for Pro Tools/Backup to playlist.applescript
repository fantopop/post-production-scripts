--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Copies selection to the first alternate playlist.
-- Warning! Before applying, make sure that the playlist exists and is empty.
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Backup windows count to catch warning message.
		set countBefore to count windows
		
		-- Open playlists.
		key code 123 using {command down, control down}
		
		set countAfter to count windows
		-- If warning message has appeared.
		if countBefore is not equal to countAfter then
			-- Hit ESC.
			key code 53
			delay 0.02
			display dialog "Can't open playlists. Try to remove all clip groups from the track" buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			return
		end if
		
		-- Copy selection.
		keystroke "c"
		delay 0.02
		
		-- Paste selection.
		keystroke ";"
		delay 0.02
		keystroke "v"
		delay 0.02
		
		-- Close playlists.
		keystroke "p"
		delay 0.02
		keystroke ""
		key code 124 using {command down, control down}
		
		-- display notification "Selection copied to the first playlist." with title "Backup to playlist"
	end tell
end tell