-- Clicks buttons "Solo" & "Mute" for chosen track at once
-- Specify desired track name in variable track_name
-- (C) 2021 Ilya Putilin
-- https://guthub.com/fantopop

set track_name to "REF v2"

tell application "System Events"
	tell application process "Pro Tools"
		set edit_window to 1st window whose name contains "Edit: "
		tell edit_window
			try
				set track_group to 1st group whose name contains track_name
			on error
				display dialog ("Can't find track with name " & track_name) with icon caution with title "Track name error" buttons {"OK"} default button "OK"
				return
			end try
			tell track_group
				click button "Solo"
				click button "Mute"
			end tell
		end tell
	end tell
end tell
