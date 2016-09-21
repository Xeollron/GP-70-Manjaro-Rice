#!/bin/bash

# Dependencies:
# ffmpeg
# i3lock-color-git

IMAGE=/tmp/i3lock.png
font="Roboto"
fortunePath="/home/christopher/.local/share/fortune/arch"
TEXT="$(fortune $fortunePath)"
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
LOCK=$SCRIPTPATH/lock.png
RES=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
#This is a bit cheaty
BOXSIZE=$(expr $(echo $RES | cut -d 'x' -f1) / 2)

if [[ $1 != "" ]]; then
    TEXT=$1
fi

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=7,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $IMAGE
convert "$IMAGE" -font "$font" -pointsize 28 -fill white -gravity center -annotate +0+200 "$TEXT" "$IMAGE"

i3lock -u -i $IMAGE

rm $IMAGE
