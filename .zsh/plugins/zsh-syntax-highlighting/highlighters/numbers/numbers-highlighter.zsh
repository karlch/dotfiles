#!/bin/zsh

_zsh_highlight_numbers_highlighter_predicate() {
    [[ -d .pdf ]]
}

_zsh_highlight_numbers_highlighter() {
    region_highlight+=(0 $#BUFFER bg=blue)
}
