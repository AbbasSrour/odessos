#################################################################################################################################################
############################################################## FISHER SHELL #####################################################################
#################################################################################################################################################

if status is-interactive
	neofetch
end

# General 
set -x ARCHFLAGS "-arch x86_64"
set -x LANG "en_US.UTF-8"

# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Enable Wayland support for different applications
if [ "$XDG_SESSION_TYPE" = "wayland" ]
    set -gx WAYLAND 1
    set -gx QT_QPA_PLATFORM 'wayland;xcb'
    set -gx GDK_BACKEND 'wayland,x11'
    set -gx MOZ_DBUS_REMOTE 1
    set -gx MOZ_ENABLE_WAYLAND 1
    set -gx _JAVA_AWT_WM_NONREPARENTING 1
    set -gx BEMENU_BACKEND wayland
    set -gx CLUTTER_BACKEND wayland
    set -gx ECORE_EVAS_ENGINE wayland_egl
    set -gx ELM_ENGINE wayland_egl
    set WARP_ENABLE_WAYLAND 1
    set WINIT_UNIX_BACKEND x11
end

## Environment setup

# Fish Profile
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Greeting
function fish_greeting
    fortune -a 
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

# Fish backup command
function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# nohup
function run --argument process
  nohup $process >> /tmp/nohup.log 2>&1
end

# Source starship prompt
if type -q starship
    starship init fish | source
else
    echo "Starship is not installed. Please install starship to use it."
end


# Warp Terminal
printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'

# Source zoxide
if type -q zoxide
    zoxide init fish | source
    alias cd='z'
else
    echo "Zoxide is not installed. Please install zoxide to use it."
end

# Setup pyenv
#if type -q pyenv
#    pyenv init - | source
#else
#    echo "Pyenv is not installed. Please install pyenv to use it."
#end


# Source Gcloud
bass source /etc/profile.d/google-cloud-cli.sh

# DEFAULT PROGRAMS:
set -gx EDITOR "nvim"
set -gx BROWSER "zen-browser"
#set -gx TERM "linux" ## this is causing an issue

# BASIC VARIABLES:
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache/"

# CONFIGS
set -gx STARSHIP_CONFIG "$HOME/.config/shell/starship/config.toml"
set -gx STARSHIP_CACHE "$HOME/.config/shell/starship/"
set -gx WEZTERM_CONFIG_FILE "$XDG_CONFIG_HOME/wezterm/wezterm.lua"
set -gx VOLTA_HOME "$HOME/.volta"
#set -gx VIMINIT "source $HOME/.config/vim/.vimrc"
set -gx GOPATH "$HOME/.local/share/go"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx ANDROID_HOME "$HOME/Android/sdk"
set -gx OLLAMA_MODELS "$HOME/.ollama/models"

# CACHE:
set -gx UMPV_SOCKET "$HOME/.cache/umpv/"
set -gx LESSHISTFILE "$HOME/.cache/lesshst"

# System Path
set -gx PATH "/usr/local/bin" $PATH
set -gx PATH "$HOME/bin" $PATH
set -gx PATH "$HOME/.emacs.d/bin" $PATH
set -gx PATH "$HOME/.local/bin:$GOPATH/bin" $PATH
set -gx PATH "$HOME/.local/share/go/bin" $PATH
set -gx PATH "$HOME/.local/share/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "$HOME/.dotnet/tools" $PATH
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$PNPM_HOME" $PATH

# CUDA configuration
set -gx CUDA_PATH "/opt/cuda"

# Add CUDA paths to PATH
# If append_path doesn't exist yet, define it first:
function append_path
    set dir $argv[1]
    if test -d $dir
        if not contains -- $dir $PATH
            set -gx PATH $PATH $dir
        end
    end
end

# Add CUDA paths
append_path "/opt/cuda/bin"
append_path "/opt/cuda/nsight_compute"
append_path "/opt/cuda/nsight_systems/bin"

# Set the default host compiler for nvcc
set -gx NVCC_CCBIN "/usr/bin/g++-13"

## Useful aliases
# Replace ls with eza
if command -q eza
	alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
	alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
	alias ll='eza -l --color=always --group-directories-first --icons'  # long format
	alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
	alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles
else
	echo "Eza the ls replace is not installed. Please install eza to use it."
end

# Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias please='sudo'
alias updatepkgs='sudo pacman -Syu'
alias cleanpkgs='sudo pacman -Rns (pacman -Qtdq)'
alias rmpkg="sudo pacman -Rdd"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias ripkgs="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -1000 | nl"
alias jctl="journalctl -p 3 -xb"
alias upd='/usr/bin/update'
alias helpme='cht.sh --shell'
alias tb='nc termbin.com 9999'
alias vi="nvim"
alias doom='.emacs.d/bin/doom'
alias task='go-task'
alias rm='rm -i'


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/ares/.lmstudio/bin
# End of LM Studio CLI section

