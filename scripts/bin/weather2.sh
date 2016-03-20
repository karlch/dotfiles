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

while true; do
    data=$(curl -s --connect-timeout 30 http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=1\&locCode\=${loc} | perl -ne 'if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; print "$1"; }' | sed 's/W\//+/')

    len=$(echo ${data} | wc -w)

    # Correct data to the file
    if (( $len == 0 ))
    then
        echo "no data" > ~/.i3/info/weather
    else
        echo $data > ~/.i3/info/weather

        # Find out the correct image name
        if echo $data | grep -i "rain"; then
            cp ~/.i3/info/weather_icons/heavy_rain.svg ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "sunny"; then
            cp ~/.i3/info/weather_icons/sunny.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "cloudy"; then
            cp ~/.i3/info/weather_icons/cloudy.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "wind"; then
            cp ~/.i3/info/weather_icons/wind.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "drizzle"; then
            cp ~/.i3/info/weather_icons/rain.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "flurries"; then
            cp ~/.i3/info/weather_icons/snow.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "snow"; then
            cp ~/.i3/info/weather_icons/snow.svg  ~/.i3/info/weather_icon.svg
        elif echo $data | grep -i "fog"; then
            cp ~/.i3/info/weather_icons/fog.svg  ~/.i3/info/weather_icon.svg
        fi
    fi
    sleep 1200
done
