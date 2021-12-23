# flocus
Purposefully move from one window configuration to another (browser tabs, Notion pages, open applications)

### Setup
`src/Flocus.scpt` is a collection of functions, aka "handlers" in Applescript terminology. To make these "handlers" globally visible to Applescripts, they need to live in `~/Library/Script Libraries` (or one of the [other 7 default path locations](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/conceptual/ASLR_script_objects.html#//apple_ref/doc/uid/TP40000983-CH207-SW13)  ). Running `install.sh` will move those scripts into the right folder for you.

```bash
# cd into root of project
. install.sh
```
