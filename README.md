# flocus
Purposefully move from one window configuration to another in OSX (browser tabs, Notion pages, open applications)

# Contributors Welcome!
I'd like to keep improving this and share the benefits with others. If you'd like to contribute, fork it or [reach out to me](https://github.com/anguspmitchell)

# Example
[Video Here](https://www.loom.com/share/6c4b09b7f4f9475eabfa709171464d66)

[![Screen Shot 2021-12-23 at 10 38 19 AM small](https://user-images.githubusercontent.com/4749149/147269375-3d87e842-eb09-45a8-8478-6dc85bfbed14.png)](https://www.loom.com/share/6c4b09b7f4f9475eabfa709171464d66)
[![Screen Shot 2021-12-23 at 10 35 28 AM small](https://user-images.githubusercontent.com/4749149/147269463-e5e25384-897f-4226-93fa-286fe7305071.png)](https://www.loom.com/share/6c4b09b7f4f9475eabfa709171464d66)

# Setup
### Applescript Library
`src/Flocus.scpt` is a collection of functions, aka "handlers" in Applescript terminology. To make these "handlers" globally visible to Applescripts, they need to live in `~/Library/Script Libraries` (or one of the [other 7 default path locations](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/conceptual/ASLR_script_objects.html#//apple_ref/doc/uid/TP40000983-CH207-SW13)  ). Running `install.sh` will move those scripts into the right folder for you.

```bash
# cd into root of project
. install.sh
```

### Brave/Chrome, Script Debugger, and "Enhanced Applications"
For background:
1. In order to boss around Brave/Chrome, the script needs to get access from OSX to do so. You can see this under System Preferences > Security and Privacy > Automation. 
2. There are a few different ways of saving Applescripts:
   - script (`.scpt` file)
   - script bundle (`.scptd` file)
   - application (`.app` file).
3. OSX ships with Script Editor (see: Applications/Utilities), but it's not great for debugging. [Script Debugger](https://latenightsw.com/) is a much better alternative.

I lied. There's actually a fourth way of saving a script, which is Script Debugger's ["Enhanced Application" format](https://latenightsw.com/enhanced-applets/). From what I can tell, this is the only application format that can be permissioned to interact with Brave/Chrome. At least when running it by pointing/clicking on desktop icons.

![Screen Shot 2021-12-22 at 9 37 44 PM](https://user-images.githubusercontent.com/4749149/147184589-c8a5dedb-eefc-4cb1-a3df-7c19c59a2ef5.png)

So, if you want to run this, I think you need to download Script Debugger so that you can save scripts in the "Enhanced Application" format.

In summary, for Brave/Chrome access:
- ✅ Script Debugger "Enhanced Application"
- ❌ `.scpt` wrapped in bash script
- ❌ Regular Application
- ✅ Running directly from Script Editor or Script Debugger (not super userful...)

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
