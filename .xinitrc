#!/usr/bin/env sh
# Monitor setup
xrandr --dpi 117
# Replace capslock with escape
setxkbmap be -option caps:escape &
# Set a background image
feh --bg-fill ~/.config/wallpaper/alicia-vikander-monochrome-x6-2560x1440.jpg &
# Synchronize X clipboard and selection buffers
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
# Start i3wm
exec i3
