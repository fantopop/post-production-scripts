--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Nudges selection on the number of samples in an open Auto-Align plug-in window.
-- NOTE: Enable "Follow Main Time Scale" in Nudge right click menu.

--
-- (C) 2018 Ilya Putilin
-- http://github.com/fantopop
-- 

# Parameters to convert raw values of Auto-Align offset into samples.
# offset = k * raw_value + c
set k to 9.31322715597984E-6
set c to -10000

# set Responce to display dialog "Enter number of samples to shift?" default answer "1"
# set N to (text returned of Responce) as number

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
			# Check wether Auto-Align is open
			set AAOpen to count (windows of PT whose name contains "Plug-In: Auto-Align")
			if AAOpen < 1 then
				display dialog "Can't find Auto-Align track plug-in." buttons {"OK"} default button {"OK"} with icon caution with title "AppleScript error"
				return
			end if
			
			# Get Auto-Align plug-in window
			set AutoAlignWindow to first window of PT whose name contains "Plug-In: Auto-Align"
			set AAEditView to group "FXTDMEditView" of AutoAlignWindow
			set OffsetValue to slider "Offset" of AAEditView
			set offsetRaw to value of OffsetValue
			
			# Convert raw offset value into samples
			set offsetSamples to round (offsetRaw * k + c) as integer
			
			# Switch main counter to Samples
			click menu item "Samples" of menu "Main Counter" of menu item "Main Counter" of menu "View" of menu bar item "View" of menu bar 1
			
			set EditWindow to first window of PT whose name contains "Edit:"
			set GridNudgeCluster to group "Grid/Nudge Cluster" of EditWindow
			set NudgeControlsButton to button "Nudge Controls" of GridNudgeCluster
			set NudgeValue to text field "Nudge Value" of NudgeControlsButton
			
			# Set value and nudge
			# Click on the nudge value entry field
			tell NudgeValue to perform action "AXPress"
			if offsetSamples ³ 0 then
				# Set value
				keystroke offsetSamples
				# Hit enter
				key code 36
				# Nudge right
				key code 78 using {control down}
			else
				# Set value
				keystroke -offsetSamples
				# Hit enter
				key code 36
				# Nudge left
				key code 69 using {control down}
			end if
			
			# Switch main counter back to Timecode
			click menu item "Timecode" of menu "Main Counter" of menu item "Main Counter" of menu "View" of menu bar item "View" of menu bar 1
			
		end tell
	end tell
end tell