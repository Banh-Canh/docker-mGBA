#!/bin/bash
Xvfb :1 -screen 0 1920x1080x24 -listen tcp -ac &
x11vnc -display :1 -nowf -noipv6 -reopen -forever -repeat -rfbport 5900 -noxdamage -bg &
fluxbox > /dev/null 2>&1 &
websockify -D --web=/usr/share/novnc/ 6180 localhost:5900 > /dev/null 2>&1 &
mgba-qt -f /roms/rom.gba
