--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Copies selection to the first alternate playlist.
-- Warning! Before applying, make sure that the playlist exists and is empty.
--
-- © 2017 Ilya Putilin
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
			display dialog "Can't open playlists. Try to remove all clip groups from the track" buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			return
		end if
		
		-- Copy selection.
		keystroke "c"
		
		-- Paste selection.
		keystroke ";"
		keystroke "v"
		
		-- Close playlists.
		keystroke "p"
		key code 124 using {command down, control down}
	end tell
end tell