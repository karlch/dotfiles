#! /bin/bash
function calc() {
    awk "BEGIN { print $* }"
}

stat=`cat /proc/net/wireless | tail -1 | cut -d " " -f5 | tr -d "."`
if [[ $stat -gt 0 ]]; then
    stat1=`calc $stat / 70.0`
    stat2=`echo "$stat1 100 * p" | dc`
    echo ${stat2%.*}
else
    echo "---"
fi
