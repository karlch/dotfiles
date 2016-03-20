#!/bin/bash

os="Parabola Gnu/Linux"
kernel=$(uname -sr)
host=$(uname -n)
uptime=$(uptime | cut -d " " -f4-7 | tr -d ",")
packages=$(pacman -Q | wc -l)
ram=$(free -h | sed -n '2,2p' | awk '{print $3 " / " $2 " (" substr($3/$2*100,1,4) "%)"}')
swap=$(free -h | sed -n '3,3p' | awk '{print $3 " / " $2 " (" substr($3/$2*100,1,4) "%)"}')
cpu=$(lscpu | sed -n '13,13p' | awk '{$1=$2=""; print substr($0,3)}')
printf "
\e[0;34m                        ###     ###      \e[1;34mOS: \e[0;38mParabola Gnu/Linux
\e[0;34m                ###   ###     #######    \e[1;34mKernel: \e[0;38m%s
\e[0;34m            # ###    ###     #########   \e[1;34mHost: \e[0;38m%s
\e[0;34m       ###  ###   ###      ##########    \e[1;34mUptime: \e[0;38m%s
\e[0;34m    ##### ###    ###     ###########     \e[1;34mPackages: \e[0;38m%s
\e[0;34m#####                   ############     \e[1;34mRam: \e[0;38m%s
\e[0;34m                       ############      \e[1;34mSwap: \e[0;38m%s
\e[0;34m                        ##########       \e[1;34mCpu: \e[0;38m%s
\e[0;34m                         ########        
\e[0;34m                         #######         
\e[0;34m                         #####           
\e[0;34m                         ###             
\e[0;34m                        ##               
\e[0;34m                       #                 \n\e[0;38m
" "${kernel}" "${host}" "${uptime}" "${packages}" "${ram}" "${swap}" "${cpu}"

fortune ~/bin/fortune/marvin
printf "\n"
