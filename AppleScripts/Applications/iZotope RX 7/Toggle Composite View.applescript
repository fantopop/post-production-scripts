--
-- AppleScripts for Avid Pro Tools.
--
-- Script description:
-- 1. Sends audio back to Pro Tools.
-- 2. Renders the selection.
-- 3. Creates fades around the selection.
--
-- (C) 2020 Ilya Putilin
-- http://github.com/fantopop
--

set RXVersion to "8"

-- activate application ("iZotope RX " & RXVersion & " Audio Editor")
tell application "System Events"
	-- get iZotope RX process
	set RX to the first application process whose name contains "iZotope"
	-- get main window
	
	-- check if already in composite view
	set compositeViewOn to count (windows of RX whose name contains "Composite View")
	
	if (compositeViewOn > 0) then
		set mainwindow to 1st window of RX whose name contains "Composite View"
		set mainWindowGroup to 1st group of mainwindow
		perform action "AXPress" of 2nd item of every button of mainWindowGroup
	else
		set mainwindow to 1st window of RX whose name contains "Pro Tools"
		set mainWindowGroup to 1st group of mainwindow
		perform action "AXPress" of 3rd item of every button of mainWindowGroup
	end if
	
end tell
