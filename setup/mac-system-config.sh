#!/bin/bash

# Make key repeat super fast. Stolen from:
# https://apple.stackexchange.com/a/83923
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Hide fluffy directories from finder that I can't delete
chflags hidden Applications Movies Music Pictures Public

# Make Anki-Connect work well even when not in foreground
defaults write net.ankiweb.dtop NSAppSleepDisabled -bool true
defaults write net.ichi2.anki NSAppSleepDisabled -bool true
defaults write org.qt-project.Qt.QtWebEngineCore NSAppSleepDisabled -bool true
