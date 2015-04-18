# Set VIMODE according to the current mode, default is i
VIMODE='[i]'
function zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
 zle reset-prompt
}

zle -N zle-keymap-select

PROMPT='%{$fg[blue]%}%n: %{$fg[blue]%}%~%{$reset_color%} '

RPROMPT='${VIMODE}'
