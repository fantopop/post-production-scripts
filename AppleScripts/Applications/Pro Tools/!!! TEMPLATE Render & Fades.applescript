--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Renders selection with iZotope Mouth De-click.
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
-- 

set plugin_name to "RX 7 Mouth De-click"
set with_fades to true

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			-- Check if plugin is open.
			set plugin_open to count (windows whose name contains "Audio Suite:" and name contains plugin_name)
			
			-- Open plugin if needed.
			if plugin_open is 0 then
				click menu item plugin_name of menu "Noise Reduction" of menu item "Noise Reduction" of menu "AudioSuite" of menu bar item "AudioSuite" of menu bar 1
				
				-- Wait until the window opens.
				repeat while plugin_open is 0
					delay 0.05
					set plugin_open to count (windows whose name contains "Audio Suite:" and name contains plugin_name)
				end repeat
			end if
			
			-- Click RENDER button
			set num_before to count windows
			tell (1st window whose name contains "Audio Suite:" and name contains plugin_name) to click button "Render"
			
			-- Add fades if needed
			if with_fades is true then
				delay 0.2
				
				-- Count current number of windows.
				set num to count windows
				
				-- Wait until render completes.
				repeat while num is greater than num_before
					delay 0.1
					set num to count windows
				end repeat
				
				-- Extend selection.
				key code 69 using {command down, shift down}
				key code 78 using {option down, shift down}
				
				-- Create fades.
				keystroke "f"
			end if
			
		end tell
	end tell
end tell