--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Clicks on Detect button of the Auto-Align track plug-in.
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
-- 

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- Check whether there is an open track plug-in window.
		set AAOpen to count (windows whose name contains "Plug-in: Auto-Align")
		
		if AAOpen < 1 then
			display dialog "Can't find Auto-Align track plug-in window." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
			return
		end if
		
		-- Get Detect button.
		set trackWindow to (1st window whose name contains "Plug-in: Auto-Align")
		set AAEditView to group "FXTDMEditView" of trackWindow
		set detectButton to slider "Detect" of AAEditView
		
		-- Detect button current state.
		set detectEnabled to value of detectButton
		
		-- Toggle.
		if detectEnabled = 0 then
			perform action "AXIncrement" of detectButton
		else
			perform action "AXDecrement" of detectButton
		end if
	end tell
end tell