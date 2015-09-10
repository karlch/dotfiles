#! /bin/bash
titles=`~/.i3/py-scripts/fb-notify/fb-notify.py`
if (echo $titles | grep "Nachricht geschickt\|(1)" > /dev/null) && [[ $(~/.i3/py-scripts/wincurrent.py) != "qutebrowser" ]]; then
    echo "fb"
fi
