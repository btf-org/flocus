# flocus
Purposefully move from one window configuration to another in OSX (browser tabs, Notion pages, open applications)

# Contributors Welcome!
I'd like to keep improving this and share the benefits with others. If you'd like to contribute, fork it or [reach out to me](https://github.com/anguspmitchell)

# TLDR Setup
1. Install [FastScripts](https://redsweater.com/fastscripts/)
2. Make Flocus an Applescript Library
```bash
# cd into root of project
. install.sh
```

3. Copy a script into FastScript's script library
```bash
mkdir -p ~/Library/Scripts
cp examples/notion-slack-brave.applescript ~/Library/Scripts
```
4. You should see it show up in the FastScript menu bar dropdown
![Screen Shot 2022-01-05 at 9 54 49 PM](https://user-images.githubusercontent.com/4749149/148330493-0c572f7d-1aa9-4149-81b1-c25d2e6aa22a.png)

# More Explanation
### Applescript Library
`src/Flocus.applescript` is a collection of functions, aka "handlers" in Applescript terminology. To make these "handlers" globally visible to Applescripts, they need to live in `~/Library/Script Libraries` (or one of the [other 7 default path locations](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/conceptual/ASLR_script_objects.html#//apple_ref/doc/uid/TP40000983-CH207-SW13)  ). Running `install.sh` will move Flocus into the right folder for you.

### Text versus Compiled Applescript
If you use Script Debugger or Script Editor to save scripts as `.app` or `.scpt`, the script will get compiled and will be unreadable. For the sake of source control, Flocus is saved as plain text (.applescript). `install.sh` compiles it while moving it into `~/Library/Script Libraries`. 

### FastScripts
[FastScripts](https://redsweater.com/fastscripts/) is a menu bar dropdown for running your scripts. This is helpful for a couple reasons:
1. It provides quick and easy access to running scripts
2. FastScripts is the entrypoint, so if you give it, say, permission to access Finder, you only have to do so on FastScripts, instead of having to permission each one of your individual scripts.

By default, FastScripts will include folders that you likely don't care about. To only show the one folder with your scripts, quit FastScripts, run the following, then restart.
```bash
defaults write com.red-sweater.fastscripts3 ScriptTreePathsKey '("~/Library/Scripts")'
```

### Example Usage
This piece of code calls a handler/function called `flocus` that...
1. Closes every application except for Finder, Notion, Slack and Brave
2. Closes every Brave tab except for Instapaper
3. Closes every Notion window except for the one specified in the URL

```applescript
use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use script "Flocus"

on run
	set whiteList to {"Finder", "Notion", "Slack", "Brave Browser"}
	set webURLs to {"https://www.instapaper.com/u"} -- Applescript lists are contained within curly brackets 
	set notionURLs to {"notion://www.notion.so/Public-Notion-Page-Example-2b2841ed7e3a4335aa3f854d3efe9b22"}
	tell script "Flocus" to flocus(whiteList, webURLs, notionURLs)
end run
```
