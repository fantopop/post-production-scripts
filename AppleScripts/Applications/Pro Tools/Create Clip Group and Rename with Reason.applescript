--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Creates Clip Group for selection and switches keyboard input source to RU
-- Adds [R] template for ADR markup reasons (EDI CUE or PGPTSession)
--
-- (C) 2020 Nikita Gankin
-- 
--
-- In order to work properly install xkbswitch.
-- Open Terminal and perform 3 commands:
--
-- 1. Download binary:
-- curl -LJO https://raw.githubusercontent.com/myshov/xkbswitch-macosx/master/bin/xkbswitch
--
-- 2. Add execution rights
-- chmod 755 xkbswitch 
--
-- 3. Move to proper folder
-- mv xkbswitch /usr/local/bin


tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Check if the menu item Copy is enabled.
			# If edit selection is void, this item won't be enabled.
			set checkSelection to enabled of menu item "Copy" of menu "Edit" of menu bar item "Edit" of menu bar 1
			
			if checkSelection is true then
				# Create Clip Group
				key code 5 using {command down, option down}
				delay 0.1
				
				do shell script "/usr/local/bin/xkbswitch -se US"
				
				# Rename
				key code 15 using {command down, shift down}
				delay 0.1
				
				# Add Reason template
				set the clipboard to " [R]"
				keystroke "v" using command down
				
				# Move cursor to the beginning of the line
				key code 126
				
				# Switch to Russian
				do shell script "/usr/local/bin/xkbswitch -se RussianWin"
				#key code 49 using {command down}
			else
				display dialog "Can't create a clip group - edit selection is void" buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			end if
		end tell
	end tell
end tell