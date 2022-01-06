use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use script "Flocus"

on run
	set whiteList to {"Finder", "Notion", "Slack", "Brave Browser"}
	set webURLs to {"https://www.instapaper.com/u"}
	set notionURLs to {"notion://www.notion.so/Public-Notion-Page-Example-2b2841ed7e3a4335aa3f854d3efe9b22"}
	tell script "Flocus" to flocus(whiteList, webURLs, notionURLs)
end run