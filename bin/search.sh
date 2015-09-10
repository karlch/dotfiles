#! /bin/bash

if [ -f $HOME/.dmenurc ]; then
  . $HOME/.dmenurc
else
  DMENU='dmenu -i -b -y 25 -fn SourceCodePro -nb #2C2C2C -nf #00C1FF -sb #00A0DD -sf #EEEEEE'
fi

GS=`echo "Search duckduckgo"| $DMENU $*`

qutebrowser http://www.duckduckgo.com/?q="$GS" &
i3-msg [class="qutebrowser"] focus
