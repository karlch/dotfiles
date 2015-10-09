#! /bin/bash

# Safety first
cp ~/.config/qutebrowser/keys.conf ~/.config/qutebrowser/keys.conf.bak
# Catch mappings from vimrc
cat ~/.vimrc | grep "map\|noremap\|nmap\|nnoremap" > ~/tmp.txt

# Run a substitution in vim for the mappings
IFS=$'\n'
for i in $(cat ~/tmp.txt)
do
    cur=$(echo $i | cut -d " " -f3)
    new=$(echo $i | cut -d " " -f2)
    vim +"%s /    ${cur}$/    ${new}TMP/ceI" +"wq" ~/.config/qutebrowser/keys.conf
done

# Remove the TMP which stops remapping recursively
vim +"%s /TMP$//e" +"wq" ~/dummyqute
# Remove the file used for catching the mappings
rm ~/tmp.txt
