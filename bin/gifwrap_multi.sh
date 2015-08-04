#!/bin/sh
# Uses xwinwrap to display given animated .gif in the center of the screen

xwinwrap -g 480x360+0+0 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/angry_dog.gif -a &
xwinwrap -g 480x360+480+0 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/cool_spyder.gif -a &
xwinwrap -g 480x360+960+0 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/gazelle.gif -a &
xwinwrap -g 480x360+1440+0 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/karacho.gif -a &
xwinwrap -g 480x360+0+360 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/putin.gif -a &
xwinwrap -g 480x360+480+360 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/weird_animation.gif -a &
xwinwrap -g 480x360+960+360 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/asian_limbo.gif -a &
xwinwrap -g 480x360+1440+360 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/creepy_dog.gif -a &
xwinwrap -g 480x360+0+720 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/heli_girl.gif -a &
xwinwrap -g 480x360+480+720 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/music_spyder.gif -a &
xwinwrap -g 480x360+960+720 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/snow_cat.gif -a &
xwinwrap -g 480x360+1440+720 -ov -ni -s -nf -a -- gifview -w WID ~/Bilder/Gifs/wtf.gif -a

exit 0
