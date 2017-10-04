--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- Strips silence.
-- Note: if the Strip Silence window was open, just stripes the silence.
-- If the window was closed - closes the window after stripping. 
--
-- © 2017 Ilya Putilin
-- http://github.com/fantopop
--

tell application "Finder"
	tell application "System Events"
		set PT to the first application process whose creator type is "PTul"
		tell PT
			activate
			set frontmost to true
			
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
end tell