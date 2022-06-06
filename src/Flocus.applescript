property name : "Flocus"
property id : "flocus"
-- property version : 1.0




to closeAllWindowsExcept(whiteList)
	tell application "System Events"
		set visibleApps to (every application process where visible is true)
	end tell
	repeat with va in visibleApps
		set appName to name of va
		if appName = "Electron" and short name of va = "Code" then
			set appName to "Visual Studio Code"
		end if
		if appName is not in whiteList then
			tell application appName
				quit
			end tell
		end if
	end repeat
end closeAllWindowsExcept

to openApps(openList)
	tell application "System Events"
		set visibleApps to (name of every application process where visible is true)
	end tell
	repeat with a in openList
		if a is not in visibleApps then
			tell application a
				activate
			end tell
		end if
	end repeat
end openApps

to exclusivelyOpen(openList)
	closeAllWindowsExcept(openList)
	openApps(openList)
end exclusivelyOpen

to closeAllBraveTabsExcept(whiteList)
	tell application "Brave Browser"
		repeat while window 2 exists
			close window 2
		end repeat
		
		set w_list to every window
		
		repeat with w in w_list
			set t_list to every tab in w
			
			repeat with t in t_list
				if the URL of t is not in whiteList then
					delete t
				end if
			end repeat
		end repeat
	end tell
end closeAllBraveTabsExcept

to openBraveTabs(newUrls)
	tell application "Brave Browser"
		if (count of windows) is 0 then
			make new window
		end if
		set currentlyOpen to every tab in front window
		set currentURLs to {}
		repeat with t in currentlyOpen
			copy URL of t to end of currentURLs
		end repeat
		
		repeat with newUrl in newUrls
			if newUrl is not in currentURLs then
				tell front window to make new tab at after (get active tab) with properties {URL:newUrl}
			end if
		end repeat
	end tell
end openBraveTabs

to clearNotionWindows()
	tell application "System Events" to set visibleApps to (name of every application process where visible is true)
	if "Notion" is not in visibleApps then return
	
	tell application "System Events" to tell its process "Notion" to set windowCount to count of windows
	delay 0.5
	repeat while windowCount > 0
		tell application "System Events" to tell its process "Notion" to set its frontmost to true
		delay 1
		tell application "System Events" to keystroke "w" using command down
		delay 1
		tell application "System Events" to tell its process "Notion" to set windowCount to count of windows
	end repeat
end clearNotionWindows

to openNotionPages(pageURLs)
	if (count of pageURLs) is 0 then return
	
	tell application "Notion" to activate
	repeat with pageURL in pageURLs
		delay 1.5
		tell application "System Events" to keystroke "n" using {command down, shift down}
		delay 3
		tell application "Notion" to open location pageURL
	end repeat
end openNotionPages

to exclusivelyOpenBraveTabs(newUrls)
	if (count of newUrls) is 0 then return
	
	delay 3
	closeAllBraveTabsExcept(newUrls)
	delay 3
	openBraveTabs(newUrls)
end exclusivelyOpenBraveTabs

to closeFinderWindows()
	tell application "Finder"
		close windows
	end tell
end closeFinderWindows

to flocus(apps, webURLs, notionURLs)
	-- set myLogFile to open for accessPOSIX file "~/Desktop/applescript.log" with write permission
	
	exclusivelyOpen(apps)
	exclusivelyOpenBraveTabs(webURLs)
	clearNotionWindows()
	openNotionPages(notionURLs)
	-- tell application "Finder" to activate
	closeFinderWindows()
	-- write "some data" & return to myLogFile
	-- close accessmyLogFile
	
	
end flocus