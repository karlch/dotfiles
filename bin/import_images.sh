#!/bin/zsh

# Function to import a range under a specific name
function import_range()
{
    clear
    printf "Enter name: " 
    read name
    if [[ ${name} == q || ${name} == "" ]]; then
        break
    fi
    mkdir ${name}
    cd ${name}
    printf "Enter range: " 
    read range
    printf "Delete images from camera after import? (y/N) " 
    read delete
    if [[ ${range} == "" ]]; then
        gphoto2 --get-all-files --filename "${name}_%03n.jpg"
        if [[ ${delete} == y ]]; then
            gphoto2 --delete-all-files
        fi
    else
        gphoto2 --get-file ${range} --filename "${name}_%03n.jpg"
        if [[ ${delete} == y ]]; then
            gphoto2 --delete-file ${range}
        fi
    fi
    echo "Import successfull"
    jhead -autorot -ft *
    cd ..
}

# Open all thumbnails
mkdir tmp
cd tmp
gphoto2 --get-all-thumbnails --filename "%04n.jpg"
vimiv &
while true; do
    curwin=$(xdotool getactivewindow)
    if (xprop -id $curwin | grep -i "wm_class.*vimiv" > /dev/null); then
        xdotool key t
        i3-msg -q focus left
        break
    fi
done
cd ..

while true
do
    import_range
done

rm -rf tmp
i3-msg -q focus right
i3-msg -q kill
thumbnails=$(find ~/.vimiv/Thumbnails  -mindepth 1 -cmin -10 | tr "\n" " ")
for thumb in $(echo ${thumbnails}); do
    rm ${thumb}
done
echo "cleaned temporary files"
