#!/bin/bash

cat ~/.abook/addressbook | grep "name" | sed "s/name=//" | sort > ~/tmp

IFS=$'\n'
for name in $(cat ~/tmp); do
    sed -e '/./{H;$!d;}' -e "x;/$name/!d;" ~/test >> ~/tmp2
done
mv ~/tmp2 ~/.abook/addressbook
rm ~/tmp ~/tmp2
