### Command cheat sheet###

Default prefix key:
Ctrl-b  (C-b)

##PANES##
Create a left/right split pane:
<prefix> %

Create an up/down split pane:
<prefix> "

Move between panes
<prefix> <arrow key> //Also works with multiple arrow keys, if fast enough.

Close pane
type exit OR C-d

##WINDOWS(the good kind)##

Create new window
<prefix> c

Rename window
<prefix> ,

Change windows
<prefix> p (previous), OR <prefix> n (next), OR <prefix> <number>

##SESSIONS##

Detatch session
<prefix> d

Attatch to session
tmux attatch -t 0 //To attatch to session 0

Get a list of all sessions before attaching:
tmux ls

##RESIZE##
Toggle full screen:
<prefix> z
Resize pane
<prefix> C-<Arrow key> 
