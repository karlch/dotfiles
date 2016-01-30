#!/bin/sh
#AccuWeather (r) RSS weather tool for conky
#
#USAGE: weather.sh <locationcode>
#
#(c) Michael Seiler 2007

if (iwconfig 2>/dev/null | grep "LGB" 1>/dev/null); then
    loc="EUR|DE|altdorf|84032"
else
    loc="EUR|DE|garching-bei-munchen"
fi

data=$(curl -s --connect-timeout 30 http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=1\&locCode\=${loc} | perl -ne 'if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; print "$1"; }' | sed 's/W\//+/')

len=$(echo ${data} | wc -w)

if (( $len == 0 ))
then
    echo "no data"
else
    echo $data
fi
