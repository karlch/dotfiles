#! /bin/bash
titles=`~/.i3/py-scripts/fb-notify/fb-notify.py`
if (echo $titles | grep -e "qutebrowser.*Nachricht geschickt\|qutebrowser.*(.)" > /dev/null) && [[ $(~/.i3/py-scripts/wincurrent.py) != "qutebrowser" ]]; then
    echo "fb"
fi
