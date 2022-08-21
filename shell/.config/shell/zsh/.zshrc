
#!/bin/sh
#################################################################################################################################################
############################################################## ZOOMER SHELL #####################################################################
#################################################################################################################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/shell/omz"

# Zsh Theme
ZSH_THEME="robbyrussell"

# Plugins To Load
plugins=(git vi-mode colorize)

# Man colours enabled
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Language Environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Personal aliases
source ~/.config/shell/zsh/aliasrc

# History configuration:
HISTFILE=~/.config/shell/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000

fish
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
neofetch

# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=001,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=014,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=012,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=004,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=006,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=004,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=200,bold
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=010,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=129,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=006
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=006
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=200
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=011
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=003
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=013,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=013,bold
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]=fg=009
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]=fg=009,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=009,bold
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
