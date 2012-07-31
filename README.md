applescript-applications
========================

Collection of Application Specific AppleScripts

# Installation

The scripts are meant to be stored into `~/Library/Scripts/Applications` within their given subfolders.

However, since it uses the file type `.applescript` and the source code, one would have open it (e.g. in ScriptEditor) and save it as a Script (which gives it a .scpt extension).
This `.scpt` file needs to be stored into the mentioned folder to work.

So best way is to
* open ScriptEditor
* copy the source into it
* save the file as script with `.scpt` into `~/Library/Scripts/Applications/<Name of Application>`

# Usage

Run the scripts from the menu bar when the dependent application is active - you may have to activate applescript menu bar icon for it.

# Contents

## Safari

### GC Cache-Ordner anlegen.applescript

Used on a geocaching.com cache detail page, it will open a special file in a special folder for the cache on your disk to save notes.
It will create the folder for this particular cache in a given location and initialize it with an empty file if that doesn't exist.
It will open it up in one of your preferred editors like TextMate or (meanwhile) Sublime Text 2.

# Author

Karsten Silkenbäumer

[![endorse](http://api.coderwall.com/ksi/endorsecount.png)](http://coderwall.com/ksi)
