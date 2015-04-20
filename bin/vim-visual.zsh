#!/bin/zsh -f 
#===============================================================================
#
#          FILE:  zle_vi_visual.zsh
# 
#         USAGE:  source zle_vi_visual.zsh 
# 
#   DESCRIPTION: Vi VISUAL MODE for Zsh 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Radostan Riedel (Raybuntu), raybuntu@googlemail.com 
#       COMPANY:  
#       VERSION:  0.1
#       CREATED:  01.01.2010 22:46:59 CET
#      REVISION:  ---
#
#      """"Powered by VIM and ZSH""""
#===============================================================================
# LICENCE: GNU GPL version 3
#
# zle_vi_visual.zsh is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This project is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#===============================================================================

##### Xclip Fun #######################################################################################################
#######################################################################################################################
# The following code is from Stephane Chazelas <Stephane_Chazelas@yahoo.fr> mouse.zsh
# http://stchaz.free.fr/mouse.zsh

set-x-clipboard() { return 0; }
get-x-clipboard() { return 1; }

if whence xclip > /dev/null 2>&1; then
  x_clipboard_tool="xclip -sel c"
else
  x_clipboard_tool=
fi

if [[ -n $x_clipboard_tool ]]; then
  eval '
    get-x-clipboard() {
        (( $+DISPLAY )) || return 1
        local r
        r=$('$x_clipboard_tool' -o < /dev/null 2> /dev/null && print .)
        r=${r%.}
        if [[ -n $r && $r != $CUTBUFFER ]]; then
            killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
            CUTBUFFER=$r
        fi
    }

    set-x-clipboard() {
        (( ! $+DISPLAY )) ||
         print -rn -- "$1" | '$x_clipboard_tool' -i 2> /dev/null
    }
  '

  # redefine the copying widgets so that they update the clipboard.
  for w in copy-region-as-kill vi-delete vi-yank vi-change vi-change-whole-line vi-change-eol; do
    eval '
      '$w'() {
        if [[ $_clipcopy == '+' ]];then
            zle .'$w'
            set-x-clipboard $CUTBUFFER
            unset _clipcopy
        else
            zle .'$w'
        fi
      }
      zle -N '$w
  done
fi

vi-set-buffer () { 
    read -k keys
    if [[ $keys == '+' ]];then
        _clipcopy='+'
    else 
        zle -U $keys  
        zle .vi-set-buffer
    fi 
}
zle -N vi-set-buffer

vi-put-after () {
    if [[ $_clipcopy == '+' ]];then
        local cbuf
        cbuf=$CUTBUFFER
        get-x-clipboard
        zle .vi-put-after
        unset _clipcopy
        CUTBUFFER=$cbuf
    else
        zle .vi-put-after
    fi
}
zle -N vi-put-after

vi-put-before () {
    if [[ $_clipcopy == '+' ]];then
        local cbuf
        cbuf=$CUTBUFFER
        get-x-clipboard
        zle .vi-put-before
        unset _clipcopy
        CUTBUFFER=$cbuf
    else
        zle .vi-put-before
    fi
}
zle -N vi-put-before

#######################################################################################################################
## VI VISUAL MODE #####################################################################################################

# create a new keymap and remap a few key's with other or new widget's
bindkey -N \[v\]
bindkey -M \[v\] "\"" vi-set-buffer
bindkey -M \[v\] '1' digit-argument
bindkey -M \[v\] '2' digit-argument
bindkey -M \[v\] '3' digit-argument
bindkey -M \[v\] '4' digit-argument
bindkey -M \[v\] '5' digit-argument
bindkey -M \[v\] '6' digit-argument
bindkey -M \[v\] '7' digit-argument
bindkey -M \[v\] '8' digit-argument
bindkey -M \[v\] '9' digit-argument

# Main Highlighting Widget for VISUAL Mode
vi-visual-highlight () {
    integer CURSOR_HL MARK_HL

    if [[ $CURSOR -gt $MARK ]];then
        (( CURSOR_HL = CURSOR + 1 ))
        __regstart=$MARK
        __regend=$CURSOR_HL
        region_highlight=("${MARK} ${CURSOR_HL} standout")
    elif [[ $MARK -gt $CURSOR ]];then
        (( MARK_HL = MARK + 1 )) 
        __regstart=$CURSOR
        __regend=$MARK_HL
        region_highlight=("${CURSOR} ${MARK_HL} standout")
    elif [[ $MARK -eq $CURSOR ]];then 
        __regstart=$CURSOR
        __regend=$MARK
        region_highlight=("${CURSOR} ${MARK} standout")
    fi
}
zle -N vi-visual-highlight

# Start Vi Visual mode
vi-visual-mode () { 
    zle -K \[v\]
    MARK=$CURSOR
    zle vi-visual-highlight
}
zle -N vi-visual-mode
bindkey -M vicmd 'v' vi-visual-mode

# Exit Vi Visual mode and go to vi-cmd-mode
vi-visual-exit () {
    region_highlight=("0 0 standout")
    (( CURSOR = CURSOR + 1 )) 
    MARK=0
    __regstart=0
    __regend=0
    zle .vi-cmd-mode
}
zle -N vi-visual-exit
bindkey -M \[v\] '^[' vi-visual-exit
bindkey -M \[v\] 'v' vi-visual-exit

# Vi Visual Kill
vi-visual-kill () { 
    if [[ $CURSOR -gt $MARK ]];then
        (( CURSOR = CURSOR + 1 )) 
    elif [[ $MARK -gt $CURSOR ]];then
        (( MARK = MARK + 1 )) 
    elif [[ $MARK -eq $CURSOR ]];then 
        zle .vi-delete-char
        return 0
    fi

    zle .kill-region 
}
zle -N vi-visual-kill

# Exit Vi Visual and enter Insert mode
vi-visual-exit-to-insert () {
    region_highlight=("0 0 standout")
    MARK=0
    __regstart=0
    __regend=0
    zle .vi-insert
}
zle -N vi-visual-exit-to-insert

# Exit VISUAL mode and enter VLines Mode keeping the region
vi-visual-exit-to-vlines () {
    zle -K \[V\]
    __savepos=$CURSOR
    zle .vi-beginning-of-line -N
    __start2=$CURSOR
    zle .end-of-line -N
    __end2=$CURSOR
    CURSOR=$MARK
    zle .vi-beginning-of-line -N
    __start1=$CURSOR
    zle .end-of-line -N
    __end1=$CURSOR
    zle vi-vlines-highlight
}
zle -N vi-visual-exit-to-vlines
bindkey -M \[v\] 'V' vi-visual-exit-to-vlines

# Exit Vi Visual and open line above
vi-visual-open-above () {
    region_highlight=("0 0 standout")
    MARK=0
    zle .vi-open-line-above
}
zle -N vi-visual-open-above

# Vi Visual move to matched bracket
vi-visual-match-bracket () {
    zle .vi-match-bracket
    zle vi-visual-highlight
}
zle -N vi-visual-match-bracket
bindkey -M \[v\] '%' vi-visual-match-bracket

# Vi Visual move to column
vi-visual-goto-column () {
    zle .vi-goto-column
    zle vi-visual-highlight
}
zle -N vi-visual-goto-column
bindkey -M \[v\] '\|' vi-visual-goto-column

# Vi Visual move back to first non-blank char
vi-visual-first-non-blank () {
    zle .vi-first-non-blank
    zle vi-visual-highlight
}
zle -N vi-visual-first-non-blank
bindkey -M \[v\] '\^' vi-visual-first-non-blank

# Vi Visual repeat find
vi-visual-repeat-find () {
    zle .vi-repeat-find
    zle vi-visual-highlight
}
zle -N vi-visual-repeat-find
bindkey -M \[v\] ';' vi-visual-repeat-find

# Vi Visual reverse repeat find
vi-visual-rev-repeat-find () {
    zle .vi-rev-repeat-find
    zle vi-visual-highlight
}
zle -N vi-visual-rev-repeat-find
bindkey -M \[v\] ',' vi-visual-rev-repeat-find

# Vi Visual kill whole line and enter to viins
vi-visual-substitute-lines () {
    local EOL
    CURSOR=$__regend
    zle .vi-end-of-line -N
    EOL=$CURSOR
    CURSOR=$__regstart
    zle .vi-first-non-blank
    n=$CURSOR
    while [[ $n -lt $EOL ]];do
        zle .delete-char
        (( n++ ))
    done
    zle vi-visual-exit-to-insert
}
zle -N vi-visual-substitute-lines
bindkey -M \[v\] 'C' vi-visual-substitute-lines
bindkey -M \[v\] 'S' vi-visual-substitute-lines
bindkey -M \[v\] 'R' vi-visual-substitute-lines

# Vi Visual move backward-blank-word
vi-visual-backward-blank-word () {
    zle .vi-backward-blank-word
    zle vi-visual-highlight
}
zle -N vi-visual-backward-blank-word
bindkey -M \[v\] 'B' vi-visual-backward-blank-word

# Vi Visual move forward-blank-word
vi-visual-forward-blank-word-end () {
    zle .vi-forward-blank-word-end
    zle vi-visual-highlight
}
zle -N vi-visual-forward-blank-word-end    
bindkey -M \[v\] 'E' vi-visual-forward-blank-word-end

# Vi Visual move to prev char x
vi-visual-find-prev-char () {
    zle .vi-find-prev-char
    zle vi-visual-highlight
}
zle -N vi-visual-find-prev-char
bindkey -M \[v\] 'F' vi-visual-find-prev-char

# Vi Visual insert bol
vi-visual-insert-bol () {
    zle vi-visual-exit-to-insert
    zle .vi-insert-bol
}
zle -N vi-visual-insert-bol
bindkey -M \[v\] 'I' vi-visual-insert-bol

# Vi Visual Join Lines
vi-visual-join () {
    CURSOR=$__regstart
    while [[ $RBUFFER == *$'\n'* && $CURSOR -lt $__regend ]];do
        zle .vi-join
    done
    zle vi-visual-exit
}
zle -N vi-visual-join
bindkey -M \[v\] 'J' vi-visual-join

# Vi Visual move to prev char x and skip
vi-visual-find-prev-char-skip () {
    zle .vi-find-prev-char-skip
    zle vi-visual-highlight
}
zle -N vi-visual-find-prev-char-skip
bindkey -M \[v\] 'T' vi-visual-find-prev-char-skip

# Vi Visual move forward blank word
vi-visual-forward-blank-word () {
    zle .vi-forward-blank-word
    zle vi-visual-highlight
}
zle -N vi-visual-forward-blank-word
bindkey -M \[v\] 'W' vi-visual-forward-blank-word

# Vi Visual move backward word
vi-visual-backward-word () {
    zle .vi-backward-word
    zle vi-visual-highlight
}
zle -N vi-visual-backward-word
bindkey -M \[v\] 'b' vi-visual-backward-word

# Vi Visual change
vi-visual-change () { 
    zle vi-visual-kill
    if [[ $_clipcopy == '+' ]];then
        set-x-clipboard $CUTBUFFER
        unset _clipcopy
    fi
    zle vi-visual-exit-to-insert
}
zle -N vi-visual-change
bindkey -M \[v\] 'c' vi-visual-change

# Vi Visual Kill and enter vicmd
vi-visual-kill-and-vicmd () { 
    zle vi-visual-kill
    if [[ $_clipcopy == '+' ]];then
        set-x-clipboard $CUTBUFFER
        unset _clipcopy
    fi
    zle vi-visual-exit
}
zle -N vi-visual-kill-and-vicmd
bindkey -M \[v\] 'd' vi-visual-kill-and-vicmd
bindkey -M \[v\] 'D' vi-visual-kill-and-vicmd

# Vi Visual move forward to word end
vi-visual-forward-word-end () {
    zle .vi-forward-word-end
    zle vi-visual-highlight
}
zle -N vi-visual-forward-word-end
bindkey -M \[v\] 'e' vi-visual-forward-word-end

# Vi Visual move to next char x
vi-visual-find-next-char () {
    zle .vi-find-next-char
    zle vi-visual-highlight
}
zle -N vi-visual-find-next-char
bindkey -M \[v\] 'f' vi-visual-find-next-char

# Vi Visual move backward
vi-visual-backward-char () { 
    zle .vi-backward-char 
    zle vi-visual-highlight
}
zle -N vi-visual-backward-char
bindkey -M \[v\] 'h' vi-visual-backward-char
bindkey -M \[v\] '^?' vi-visual-backward-char

# Vi Visual move down
vi-visual-down-line () { 
    setopt extended_glob
    local NL_CHAR NL_SUM
        NL_CHAR=${RBUFFER//[^$'\n']/}
    if [[ $RBUFFER == *$'\n'* && $#NL_CHAR -ge $NUMERIC ]];then
        zle .down-line-or-history
        zle vi-visual-highlight
    else
        return 1
    fi
}
zle -N vi-visual-down-line
bindkey -M \[v\] 'j' vi-visual-down-line
bindkey -M \[v\] '+' vi-visual-down-line
bindkey -M \[v\] '^M' vi-visual-down-line

# Vi Visual move up
vi-visual-up-line () { 
    setopt extended_glob
    local NL_CHAR
        NL_CHAR=${LBUFFER//[^$'\n']/}
    if [[ $LBUFFER == *$'\n'* && $#NL_CHAR -ge $NUMERIC ]];then
        zle .up-line-or-history
        zle vi-visual-highlight
    else
        return 1
    fi    
}
zle -N vi-visual-up-line
bindkey -M \[v\] 'k' vi-visual-up-line
#bindkey -M \[v\] '-' vi-visual-up-line

# Vi Visual move forward
vi-visual-forward-char () { 
    zle .vi-forward-char 
    zle vi-visual-highlight 
}
zle -N vi-visual-forward-char
bindkey -M \[v\] 'l' vi-visual-forward-char
bindkey -M \[v\] ' ' vi-visual-forward-char

# Vi Visual Put
vi-visual-put () {
    zle vi-visual-kill
    zle vi-visual-exit
    (( CURSOR = CURSOR - 1 ))
    if [[ $_clipcopy == '+' ]];then
        local cbuf
        cbuf=$CUTBUFFER
        get-x-clipboard
        zle .vi-put-after
        unset _clipcopy
        CUTBUFFER=$cbuf
    else
        zle -U 2 && zle .vi-set-buffer 
        zle .vi-put-after
    fi
}
zle -N vi-visual-put
bindkey -M \[v\] 'p' vi-visual-put

# Vi Visual exchange start and end of region
vi-visual-exchange-points () {
    local CS_SAVE
    CS_SAVE=$CURSOR
    CURSOR=$MARK
    MARK=$CS_SAVE
    zle vi-visual-highlight
}
zle -N vi-visual-exchange-points
bindkey -M \[v\] 'o' vi-visual-exchange-points
bindkey -M \[v\] 'O' vi-visual-exchange-points

# Vi Visual move to till char x
vi-visual-find-next-char-skip () {
    zle .vi-find-next-char-skip
    zle vi-visual-highlight
}
zle -N vi-visual-find-next-char-skip
bindkey -M \[v\] 't' vi-visual-find-next-char-skip

# Vi Visual lowercase region
vi-visual-lowercase-region () {
    local LCSTART LCEND
    (( LCSTART = __regstart + 1 ))
    LCEND=$__regend

    if [[ $__regstart == $__regend ]];then
        BUFFER[${LCSTART}]=${(L)BUFFER[${LCSTART}]}
        zle vi-visual-exit
    else
        BUFFER[${LCSTART},${LCEND}]=${(L)BUFFER[${LCSTART},${LCEND}]}
        zle vi-visual-exit
    fi
}
zle -N vi-visual-lowercase-region
bindkey -M \[v\] 'u' vi-visual-lowercase-region

# Vi Visual uppercase region
vi-visual-uppercase-region () {
    local LCSTART LCEND
    (( LCSTART = __regstart + 1 ))
    LCEND=$__regend

    if [[ $__regstart == $__regend ]];then
        BUFFER[${LCSTART}]=${(U)BUFFER[${LCSTART}]}
        CURSOR=$__regstart
        zle vi-visual-exit
    else
        BUFFER[${LCSTART},${LCEND}]=${(U)BUFFER[${LCSTART},${LCEND}]}
        CURSOR=$__regstart
        zle vi-visual-exit
    fi
}
zle -N vi-visual-uppercase-region
bindkey -M \[v\] 'U' vi-visual-uppercase-region

# Vi Visual replace region
vi-visual-replace-region () {
    local LCSTART LCEND
    (( LCSTART = __regstart + 1 ))
    LCEND=$__regend

    if [[ $__regstart == $__regend ]];then
        read -k key
        BUFFER[${LCSTART}]=$key
        zle vi-visual-exit
    else
        read -k key
        n=$LCSTART
        while [[ $n -le ${LCEND} ]];do 
            if [[ ! $BUFFER[$n] == $'\n' ]] && [[ -n $BUFFER[$n] ]];then
                BUFFER[$n]=${key} 
            fi
            (( n++ ))
        done
        CURSOR=$__regstart
        zle vi-visual-exit
    fi
}
zle -N vi-visual-replace-region
bindkey -M \[v\] 'r' vi-visual-replace-region

# Vi Visual move word forward
vi-visual-forward-word () {
    zle .vi-forward-word
    zle vi-visual-highlight
}
zle -N vi-visual-forward-word
bindkey -M \[v\] 'w' vi-visual-forward-word

# Vi Visual Yank
vi-visual-yank () { 
    if [[ $__regstart == $__regend ]];then
        zle .vi-yank
        zle vi-visual-exit
    else
        zle .copy-region-as-kill $BUFFER[${__regstart}+1,${__regend}]
        zle vi-visual-exit
    fi

    if [[ $_clipcopy == '+' ]];then
        set-x-clipboard $CUTBUFFER
        unset _clipcopy
    fi
}
zle -N vi-visual-yank
bindkey -M \[v\] 'y' vi-visual-yank
bindkey -M \[v\] 'Y' vi-visual-yank

# Vi Visual move to bol
vi-visual-bol () { 
    zle .vi-digit-or-beginning-of-line
    zle vi-visual-highlight
}
zle -N vi-visual-bol
bindkey -M \[v\] '0' vi-visual-bol

# Vi Visual move to eol
vi-visual-eol () { 
    zle .vi-end-of-line 
    zle vi-visual-highlight
}
zle -N vi-visual-eol
bindkey -M \[v\] '\$' vi-visual-eol

# Some use(less|ful) keybindings
# I took this from grml's zshrc
if [[ "$TERM" != emacs ]] ; then
    [[ -z "$terminfo[kcuu1]" ]] || bindkey -M \[v\] "$terminfo[kcuu1]" vi-visual-up-line
    [[ -z "$terminfo[kcud1]" ]] || bindkey -M \[v\] "$terminfo[kcud1]" vi-visual-down-line
    [[ -z "$terminfo[kcuf1]" ]] || bindkey -M \[v\] "$terminfo[kcuf1]" vi-visual-forward-char
    [[ -z "$terminfo[kcub1]" ]] || bindkey -M \[v\] "$terminfo[kcub1]" vi-visual-backward-char
    # ncurses stuff:
    [[ "$terminfo[kcuu1]" == $'\eO'* ]] && bindkey -M \[v\] "${terminfo[kcuu1]/O/[}" vi-visual-up-line
    [[ "$terminfo[kcud1]" == $'\eO'* ]] && bindkey -M \[v\] "${terminfo[kcud1]/O/[}" vi-visual-down-line
    [[ "$terminfo[kcuf1]" == $'\eO'* ]] && bindkey -M \[v\] "${terminfo[kcuf1]/O/[}" vi-visual-forward-char
    [[ "$terminfo[kcub1]" == $'\eO'* ]] && bindkey -M \[v\] "${terminfo[kcub1]/O/[}" vi-visual-backward-char
fi

#######################################################################################################################
## VI VISUAL LINES MODE ###############################################################################################

# Create new keymap using existing vicmd keymap
bindkey -N \[V\] vicmd
bindkey -M \[V\] -r 'i'
bindkey -M \[V\] -r 'I'
bindkey -M \[V\] -r 'a'
bindkey -M \[V\] -r 'A'
bindkey -M \[V\] 'u' vi-visual-lowercase-region
bindkey -M \[V\] 'U' vi-visual-uppercase-region
bindkey -M \[V\] 'r' vi-visual-replace-region
bindkey -M \[V\] 'J' vi-visual-join
bindkey -M \[V\] 'y' vi-visual-yank
bindkey -M \[V\] 'Y' vi-visual-yank
bindkey -M \[V\] '^[' vi-visual-exit
bindkey -M \[V\] 'V' vi-visual-exit
bindkey -M \[V\] 'c' vi-visual-substitute-lines
bindkey -M \[V\] 'C' vi-visual-substitute-lines
bindkey -M \[V\] 'S' vi-visual-substitute-lines
bindkey -M \[V\] 'R' vi-visual-substitute-lines

# Highlight Lines
vi-vlines-highlight () {
    if [[ $__start1 == $__start2 ]] && [[ $__end1 == $__end2 ]];then
        __regstart=$__start1
        __regend=$__end1
        region_highlight=("${__regstart} ${__regend} standout")
        CURSOR=$__savepos
    elif [[ $__start1 -lt $__start2 ]] && [[ $__end1 -lt $__end2 ]];then
        __regstart=$__start1
        __regend=$__end2
        region_highlight=("${__regstart} ${__regend} standout")
        CURSOR=$__savepos
    elif [[ $__start1 -gt $__start2 ]] && [[ $__end1 -gt $__end2 ]];then
        __regstart=$__start2
        __regend=$__end1
        region_highlight=("${__regstart} ${__regend} standout")
        CURSOR=$__savepos
    fi
}
zle -N vi-vlines-highlight

# Vi Visual Lines Mode
vi-vlines-mode () {
    zle -K \[V\]
    __csorig=$CURSOR
    __csbefore=$CURSOR
    __savepos=$CURSOR
    zle .vi-beginning-of-line -N
    __start1=$CURSOR
    __start2=$CURSOR
    zle .end-of-line -N
    __end1=$CURSOR
    __end2=$CURSOR
    zle vi-vlines-highlight
}
zle -N vi-vlines-mode
bindkey -M vicmd 'V' vi-vlines-mode

# Exchange Start and End Point of Visual Lines Mode
vi-vlines-exchange-points () {
    local SAVE_S1 SAVE_E1

    __csbefore=$__csorig
    __csorig=$CURSOR
    __savepos=$__csbefore

    SAVE_S1=$__start1
    SAVE_E1=$__end1
    __start1=$__start2
    __start2=$SAVE_S1
    __end1=$__end2
    __end2=$SAVE_E1
    zle vi-vlines-highlight
}
zle -N vi-vlines-exchange-points
bindkey -M \[V\] 'o' vi-vlines-exchange-points
bindkey -M \[V\] 'O' vi-vlines-exchange-points

# VI Visual Lines down
vi-vlines-down-line () {
    setopt extended_glob
    local NL_CHAR NL_SUM
    NL_CHAR=${RBUFFER//[^$'\n']/}
    if [[ $RBUFFER == *$'\n'* && $#NL_CHAR -ge $NUMERIC ]];then
        zle .down-line-or-history
        __savepos=$CURSOR
        zle .vi-beginning-of-line -N
        __start2=$CURSOR
        zle .end-of-line -N
        __end2=$CURSOR
        zle vi-vlines-highlight
    else
        return 1
    fi
}
zle -N vi-vlines-down-line
bindkey -M \[V\] 'j' vi-vlines-down-line

# VI Visual Lines up
vi-vlines-up-line () {
    setopt extended_glob
    local NL_CHAR NL_SUM
    NL_CHAR=${LBUFFER//[^$'\n']/}
    if [[ $LBUFFER == *$'\n'* && $#NL_CHAR -ge $NUMERIC ]];then
        zle .up-line-or-history
        __savepos=$CURSOR
        zle .vi-beginning-of-line -N
        __start2=$CURSOR
        zle .end-of-line -N
        __end2=$CURSOR
        zle vi-vlines-highlight
    else
        return 1
    fi
}
zle -N vi-vlines-up-line
bindkey -M \[V\] 'k' vi-vlines-up-line

# Kill highlighted region in VLines
vi-vlines-kill () { 
    MARK=$__regend
    CURSOR=$__regstart
    zle .kill-region 
    if [[ $__regstart -le 1 ]];then
        zle .kill-whole-line
    else
        zle .backward-delete-char -N
        zle .forward-char -N
    fi
}
zle -N vi-vlines-kill

# Kill highlighted region in VLines
vi-vlines-kill-and-vicmd () { 
    zle vi-vlines-kill
    if [[ $_clipcopy == '+' ]];then
        set-x-clipboard $CUTBUFFER
        unset _clipcopy
    fi
    zle vi-visual-exit
}
zle -N vi-vlines-kill-and-vicmd
bindkey -M \[V\] 'd' vi-vlines-kill-and-vicmd
bindkey -M \[V\] 'D' vi-vlines-kill-and-vicmd

# Exit Visual Lines Mode and enter VISUAL Mode keeping the region
vi-vlines-exit-to-visual () {
    zle -K \[v\]
    MARK=$__csorig
    zle vi-visual-highlight
}
zle -N vi-vlines-exit-to-visual
bindkey -M \[V\] 'v' vi-vlines-exit-to-visual

# Vi VLines Put
vi-vlines-put () {
    MARK=$__regend
    CURSOR=$__regstart
    zle .kill-region 
    if [[ $_clipcopy == '+' ]];then
        local cbuf
        cbuf=$CUTBUFFER
        get-x-clipboard
        zle .vi-put-after
        unset _clipcopy
        CUTBUFFER=$cbuf
    else
        zle -U 2 && zle .vi-set-buffer 
        zle .vi-put-after
    fi
    zle vi-visual-exit
}
zle -N vi-vlines-put
bindkey -M \[V\] 'p' vi-vlines-put
bindkey -M \[V\] 'P' vi-vlines-put

##################### zsh vi misc stuff ###############################################################################
#######################################################################################################################

# Vi go to line x
vi-goto-line () {
    setopt extended_glob
    local LNL_CHAR RNL_CHAR NL_SUM CUR_LINE
    LNL_CHAR=${LBUFFER//[^$'\n']/}
    RNL_CHAR=${RBUFFER//[^$'\n']/}
    (( CUR_LINE = $#LNL_CHAR + 1 ))
    (( NL_SUM = $#LNL_CHAR + $#RNL_CHAR + 1 ))

    if [[ $NUMERIC -gt NL_SUM ]];then
        return 1
    fi

    if [[ -z $NUMERIC || $NUMERIC == 0 ]];then
        CURSOR=$#BUFFER
        zle .vi-first-non-blank
        return 0
    elif [[ -n $NUMERIC && $CUR_LINE -lt $NUMERIC ]];then
        n=$CUR_LINE
        while [[ $n -lt $NUMERIC ]];do
            zle .down-line-or-history -N
            (( n++ ))
        done
        zle .vi-first-non-blank
        return 0
    elif [[ -n $NUMERIC && $CUR_LINE -gt $NUMERIC ]];then
        n=$CUR_LINE
        while [[ $n -gt $NUMERIC ]];do
            zle .up-line-or-history -N
            (( n-- ))
        done
        zle .vi-first-non-blank
        return 0
    elif [[ -n $NUMERIC && $CUR_LINE -eq $NUMERIC ]];then
        zle .vi-first-non-blank
        return 0
    fi
}
zle -N vi-goto-line
bindkey -M vicmd 'G' vi-goto-line

# Vi go to first line
vi-goto-first-line () {
    CURSOR=0
    zle .vi-first-non-blank
}
zle -N vi-goto-first-line
bindkey -M vicmd 'gg' vi-goto-first-line

# Vi VISUAL go to line
vi-visual-goto-line () {
    zle vi-goto-line
    zle vi-visual-highlight
}
zle -N vi-visual-goto-line
bindkey -M \[v\] 'G' vi-visual-goto-line

# Vi VISUAL go to first line
vi-visual-goto-first-line () {
    zle vi-goto-first-line
    zle vi-visual-highlight
}
zle -N vi-visual-goto-first-line
bindkey -M \[v\] 'gg' vi-visual-goto-first-line

# Vi Vlines go to line
vi-vlines-goto-line () {
    zle vi-goto-line
    __savepos=$CURSOR
    zle .vi-beginning-of-line -N
    __start2=$CURSOR
    zle .end-of-line -N
    __end2=$CURSOR
    zle vi-vlines-highlight
}
zle -N vi-vlines-goto-line
bindkey -M \[V\] 'G' vi-vlines-goto-line

# Vi Vlines go to first line
vi-vlines-goto-first-line () {
    zle vi-goto-first-line
    __savepos=$CURSOR
    zle .vi-beginning-of-line -N
    __start2=$CURSOR
    zle .end-of-line -N
    __end2=$CURSOR
    zle vi-vlines-highlight
}
zle -N vi-vlines-goto-first-line
bindkey -M \[V\] 'gg' vi-vlines-goto-first-line
