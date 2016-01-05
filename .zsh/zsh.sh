# Initializes Zsh

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all of the config files in lib
for config_file ($ZSH/lib/*.zsh); do
    source $config_file
done


is_plugin() {
    local base_dir=$1
    local name=$2
    test -f $base_dir/plugins/$name/$name.plugin.zsh \
        || test -f $base_dir/plugins/$name/_$name
}
# Add all defined plugins to fpath. This must be done before running compinit.
for plugin ($plugins); do
    fpath=($ZSH/plugins/$plugin $fpath)
done

# Figure out the SHORT hostname
SHORT_HOST=${HOST/.*/}

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Load and run compinit
autoload -U compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
done

# Load the theme
source "$ZSH/themes/$ZSH_THEME.zsh-theme"

# Load aliases and functions
source ~/.zsh/aliases
source ~/.zsh/functions
