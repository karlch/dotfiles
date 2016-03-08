# Fish-like fast/unobtrusive autosuggestions for zsh.
# https://github.com/tarruda/zsh-autosuggestions
# v0.1.1
#
# Copyright (c) 2013 Thiago de Arruda
# Copyright (c) 2016 Eric Freese
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

#--------------------------------#
# Global Configuration Variables #
#--------------------------------#

# Color to use when highlighting suggestion
# Uses format of `region_highlight`
# More info: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Prefix to use when saving original versions of bound widgets
ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX=autosuggest-orig-

# Widgets that clear the suggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
	history-search-forward
	history-search-backward
	history-beginning-search-forward
	history-beginning-search-backward
        history-substring-search-up
        history-substring-search-down
	accept-line
	complete-word
	menu-complete
	menu-expand-or-complete
	reverse-menu-complete
	expand-or-complete
	expand-or-complete-prefix
)

# Widgets that modify the suggestion
ZSH_AUTOSUGGEST_MODIFY_WIDGETS=(
	list-choices
	self-insert
	magic-space
	bracketed-paste
	expand-cmd-path
	accept-and-menu-complete
	backward-delete-char
	vi-backward-delete-char
	delete-char
	vi-delete-char
	delete-char-or-list
        my-backward-word
        delete-to-xsel
        change-to-xsel
        undo
        redo
        vi-swap-case
)

# Widgets that accept the entire suggestion
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
	end-of-line
	vi-forward-char
	vi-end-of-line
)

# Widgets that accept the suggestion as far as the cursor moves
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-word
        my-forward-word
	vi-forward-word
	vi-forward-word-end
	vi-forward-blank-word
	vi-forward-blank-word-end
)

#-------------------------------------#
# Handle Deprecated Variables/Widgets #
#-------------------------------------#

unset _ZSH_AUTOSUGGEST_DEPRECATED_START_WIDGET_WARNING_SHOWN

_zsh_autosuggest_check_deprecated_config() {
	if [ -n "$AUTOSUGGESTION_HIGHLIGHT_COLOR" ]; then
		_zsh_autosuggest_deprecated_warning "AUTOSUGGESTION_HIGHLIGHT_COLOR is deprecated. Use ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE instead."
		[ -z "$ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" ] && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=$AUTOSUGGESTION_HIGHLIGHT_STYLE
		unset AUTOSUGGESTION_HIGHLIGHT_STYLE
	fi

	if [ -n "$AUTOSUGGESTION_HIGHLIGHT_CURSOR" ]; then
		_zsh_autosuggest_deprecated_warning "AUTOSUGGESTION_HIGHLIGHT_CURSOR is deprecated."
		unset AUTOSUGGESTION_HIGHLIGHT_CURSOR
	fi

	if [ -n "$AUTOSUGGESTION_ACCEPT_RIGHT_ARROW" ]; then
		_zsh_autosuggest_deprecated_warning "AUTOSUGGESTION_ACCEPT_RIGHT_ARROW is deprecated. The right arrow now accepts the suggestion by default."
		unset AUTOSUGGESTION_ACCEPT_RIGHT_ARROW
	fi
}

_zsh_autosuggest_deprecated_warning() {
	>&2 echo "zsh-autosuggestions: $@"
}

_zsh_autosuggest_deprecated_start_widget() {
	if [ -z "$_ZSH_AUTOSUGGEST_DEPRECATED_START_WIDGET_WARNING_SHOWN" ]; then
		_zsh_autosuggest_deprecated_warning "The autosuggest-start widget is deprecated. Use the autosuggest_start function instead. For more info, see README at https://github.com/tarruda/zsh-autosuggestions."
		_ZSH_AUTOSUGGEST_DEPRECATED_START_WIDGET_WARNING_SHOWN=true
	fi

	autosuggest_start
}

zle -N autosuggest-start _zsh_autosuggest_deprecated_start_widget

#----------------#
# Widget Helpers #
#----------------#

# Bind a single widget to an autosuggest widget, saving a reference to the original widget
_zsh_autosuggest_bind_widget() {
	local widget=$1
	local autosuggest_function=$2
	local prefix=$ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX
	local action

	case $widgets[$widget] in
		# Already bound
		user:_zsh_autosuggest_(bound|orig)_*);;

		# User-defined widget
		user:*)
			zle -N $prefix$widget ${widgets[$widget]#*:}
			;;

		# Built-in widget
		builtin)
			eval "_zsh_autosuggest_orig_$widget() { zle .$widget }"
			zle -N $prefix$widget _zsh_autosuggest_orig_$widget
			;;

		# Completion widget
		completion:*)
			eval "zle -C $prefix$widget ${${widgets[$widget]#*:}/:/ }"
			;;
	esac

	# Set up widget to call $autosuggest_function if it exists
	# Otherwise just call the original widget
	if [ -n "$autosuggest_function" ]; then;
		action=$autosuggest_function;
	else;
		action="zle $prefix$widget \$@"
	fi

	# Create new function for the widget that highlights and calls the action
	eval "_zsh_autosuggest_bound_$widget() {
		_zsh_autosuggest_highlight_reset
		$action
		_zsh_autosuggest_highlight_apply
	}"

	# Create the bound widget
	zle -N $widget _zsh_autosuggest_bound_$widget
}

# Map all configured widgets to the right autosuggest widgets
_zsh_autosuggest_bind_widgets() {
	local widget;

	# Find every widget we might want to bind and bind it appropriately
	for widget in ${${(f)"$(builtin zle -la)"}:#(.*|_*|orig-*|autosuggest-*|$ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX*|run-help|which-command|beep|set-local-history|yank)}; do
		if [ ${ZSH_AUTOSUGGEST_MODIFY_WIDGETS[(r)$widget]} ]; then
			_zsh_autosuggest_bind_widget $widget _zsh_autosuggest_modify
		elif [ ${ZSH_AUTOSUGGEST_CLEAR_WIDGETS[(r)$widget]} ]; then
			_zsh_autosuggest_bind_widget $widget _zsh_autosuggest_clear
		elif [ ${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[(r)$widget]} ]; then
			_zsh_autosuggest_bind_widget $widget _zsh_autosuggest_accept
		elif [ ${ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS[(r)$widget]} ]; then
			_zsh_autosuggest_bind_widget $widget _zsh_autosuggest_partial_accept
		else
			_zsh_autosuggest_bind_widget $widget
		fi
	done
}

# Given the name of a widget, invoke the original we saved, if it exists
_zsh_autosuggest_invoke_original_widget() {
	local original_widget_name="$ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX$1"

	if [ $widgets[$original_widget_name] ]; then
		zle $original_widget_name
	fi
}

#--------------#
# Highlighting #
#--------------#

# If there was a highlight, remove it
_zsh_autosuggest_highlight_reset() {
	if [ -n "$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT" ]; then
		region_highlight=("${(@)region_highlight:#$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT}")
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}

# If there's a suggestion, highlight it
_zsh_autosuggest_highlight_apply() {
	if [ $#POSTDISPLAY -gt 0 ]; then
		_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT="$#BUFFER $(($#BUFFER + $#POSTDISPLAY)) $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"
		region_highlight+=($_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT)
	else
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}

#------------------------------------#
# Autosuggest Widget Implementations #
#------------------------------------#

# Clear the suggestion
_zsh_autosuggest_clear() {
	# Remove the suggestion
	unset POSTDISPLAY

	_zsh_autosuggest_invoke_original_widget $WIDGET
}

# Modify the buffer and get a new suggestion
_zsh_autosuggest_modify() {
	# Original widget modifies the buffer
	_zsh_autosuggest_invoke_original_widget $WIDGET

	# Get a new suggestion if the buffer is not empty after modification
	local suggestion
	if [ $#BUFFER -gt 0 ]; then
		suggestion=$(_zsh_autosuggest_suggestion $BUFFER)
	fi

	# Add the suggestion to the POSTDISPLAY
	if [ -n "$suggestion" ]; then
		POSTDISPLAY=${suggestion#$BUFFER}
	else
		unset POSTDISPLAY
	fi
}

# Accept the entire suggestion
_zsh_autosuggest_accept() {
	# Only accept if the cursor is at the end of the buffer
	if [ $CURSOR -eq $#BUFFER ]; then
		# Add the suggestion to the buffer
		BUFFER="$BUFFER$POSTDISPLAY"

		# Remove the suggestion
		unset POSTDISPLAY

		# Move the cursor to the end of the buffer
		CURSOR=${#BUFFER}
	fi

	_zsh_autosuggest_invoke_original_widget $WIDGET
}

# Partially accept the suggestion
_zsh_autosuggest_partial_accept() {
	# Save the contents of the buffer so we can restore later if needed
	local original_buffer=$BUFFER

	# Temporarily accept the suggestion.
	BUFFER="$BUFFER$POSTDISPLAY"

	# Original widget moves the cursor
	_zsh_autosuggest_invoke_original_widget $WIDGET

	# If we've moved past the end of the original buffer
	if [ $CURSOR -gt $#original_buffer ]; then
		# Set POSTDISPLAY to text right of the cursor
		POSTDISPLAY=$RBUFFER

		# Clip the buffer at the cursor
		BUFFER=$LBUFFER
	else
		# Restore the original buffer
		BUFFER=$original_buffer
	fi
}

_zsh_autosuggest_widget_accept() {
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_accept
	_zsh_autosuggest_highlight_apply
        zle .accept-line
}

_zsh_autosuggest_widget_clear() {
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_clear
	_zsh_autosuggest_highlight_apply
}

zle -N autosuggest-accept _zsh_autosuggest_widget_accept
zle -N autosuggest-clear _zsh_autosuggest_widget_clear

#------------#
# Suggestion #
#------------#

# Get a suggestion from history that matches a given prefix
_zsh_autosuggest_suggestion() {
	setopt localoptions extendedglob

	# Escape the prefix (requires EXTENDED_GLOB)
	local prefix=${1//(#m)[\][()|\\*?#<>~^]/\\$MATCH}

	# Get all history items (reversed) that match pattern $prefix*
	local history_matches
	history_matches=(${history[(R)$prefix*]})

	# Echo the first item that matches
	echo ${history_matches[1]}
}

#-------#
# Start #
#-------#

# Start the autosuggestion widgets
autosuggest_start() {
	_zsh_autosuggest_check_deprecated_config
	_zsh_autosuggest_bind_widgets
}
