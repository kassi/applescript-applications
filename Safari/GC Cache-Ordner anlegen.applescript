(**
  * @description
  * This is an application specific applescript to create a new folder and file in a special place on the local machine
  * to store data for a geocache - most likely a riddle to be solved.
  * The script itself tries to extract gccode and name from the open document (Safari)
  * and opens the newly created file in the preferred editor.
  * Currently TextMate and Sublime Text 2 are supported.
  * File is to be placed into ~/Library/Scripts/Applications/Safari
  * @author Karsten Silkenbäumer
  *)
property caches_path : "/Users/Kassi/Documents/Geocaching/Caches/" -- folder containing subfolder for each cache
property mate_path : "/Users/Kassi/bin/mate"
property subl_path : "/Users/Kassi/bin/subl"

tell application "Safari"
	activate
	set current_url to URL of document 1
	set current_document to document 1

	set gccode to do JavaScript "document.getElementById('ctl00_ContentBody_CoordInfoLinkControl1_uxCoordInfoCode').innerText" in current_document
	set title to do JavaScript "document.evaluate( \"self::*//meta[@name='og:title']/@content\", document.documentElement, null, XPathResult.STRING_TYPE, null).stringValue" in current_document
	if title is not "" then
		set new_folder_name to (gccode & " " & title)
		set new_folder_path to caches_path & new_folder_name
		set caches_folder_file to caches_path as POSIX file
		tell application "Finder"
			set caches_folder to folder caches_folder_file
			-- create a new cache folder if it doesn't exist
			set new_folder to ""
			try
				set new_folder to (folder new_folder_name of caches_folder)
			on error
				set new_folder to make new folder at caches_folder with properties {name:new_folder_name}
			end try

			-- create initial document with cache title, so we can fuzzy search for it in Sublime Text
			set new_init_filename to quoted form of (new_folder_path & "/" & title & ".txt")
			do shell script "touch " & new_init_filename
			-- open preferred editor
			my open_subl(caches_folder, new_init_filename)
			-- my open_mate(caches_folder, new_init_filename)
			-- highlight new item - works in both, subl and mate
			tell application "System Events"
				-- click menu item "Reveal in Project" of menu "File" of menu bar 1
				keystroke "r" using {control down, command down}
			end tell
		end tell
	else
		display dialog "GC Daten können nicht extrahiert werden."
	end if
end tell

-- This version opens a sublime project file, but you can also open the directory itself
on open_subl(caches_folder, new_filename)
	do shell script subl_path & " -a --project " & caches_path & "Caches.sublime-project " & new_filename
	tell application "Sublime Text 2" to activate
end open_subl

on open_mate(caches_folder, new_filename)
	open file "Caches.tmproj" of caches_folder
	do shell script mate_path & " " & new_filename
end open_mate
