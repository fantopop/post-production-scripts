--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Strips silence.
-- Note: if the Strip Silence window was open, just stripes the silence.
-- If the window was closed - closes the window after stripping. 
--
-- (C) 2017 Ilya Putilin
-- http://github.com/fantopop
--

activate application "Pro Tools"
tell application "System Events"
	tell process "Pro Tools"
		-- open Strip Silence window if needed.
		set wasOpen to true
		if (count (windows whose title contains "Strip Silence")) is 0 then
			keystroke "u" using {command down}
			set wasOpen to false
		end if
		
		set stripSilenceWindow to (1st window whose title contains "Strip Silence")
		
		-- Strip silence.
		tell stripSilenceWindow to click button "Strip"
		
		-- Close the window if it wasn't open.
		if not wasOpen then
			tell stripSilenceWindow to click button 1
		end if
	end tell
end tell
