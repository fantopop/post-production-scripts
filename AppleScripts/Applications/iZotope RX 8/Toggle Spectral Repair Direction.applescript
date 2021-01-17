--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- !!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!
-- 
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
--

set RXVersion to "8"

-- activate application ("iZotope RX " & RXVersion & " Audio Editor")
tell application "System Events"
	-- get iZotope RX process
	set RX to the first application process whose name contains "iZotope"
	
	set isOpen to count (windows of RX whose name contains "Spectral Repair")
	if isOpen is 0 then
		display dialog "Open Spectral Repair window to change direction mode"
	else
		set spectralRepairWindow to 1st window of RX whose name contains "Spectral Repair"
		set btns to name of every item of group 1 of spectralRepairWindow
		display dialog btns
	end if
	
end tell
