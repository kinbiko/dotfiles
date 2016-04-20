### Command cheat sheet###

Default prefix key:
Ctrl-b  (C-b)

##PANES##
Create a left/right split pane:
C-b %

Create an up/down split pane:
C-b "

Move between panes
C-b <arrow key> //Also works with multiple arrow keys, if fast enough.

Close pane
type exit OR C-d

##WINDOWS(the good kind)##

Create new window
C-b c

Rename window
C-b ,

Change windows
C-b p (previous), OR C-b n (next), OR C-b <number>

##SESSIONS##

Detatch session
C-b d

Attatch to session
tmux attatch -t 0 //To attatch to session 0

Get a list of all sessions before attaching:
tmux ls

##RESIZE##
Toggle full screen:
C-b z
Resize pane
C-b C-<Arrow key> 
