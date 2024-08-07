#!/bin/zsh

 ####################################
 # STARTUP FILE FOR BASIC VARIABLES #
 ####################################

# DEFAULT PROGRAMS:
export EDITOR="nvim"
export BROWSER="firefox"
export TERM="wezterm"

# BASIC VARIABLES:
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache/"

# CONFIGS
export STARSHIP_CONFIG="$HOME/.config/shell/starship/config.toml"
export STARSHIP_CACHE="$HOME/.config/shell/starship/"
export WEZTERM_CONFIG_FILE="$XDG_CONFIG_HOME/wezterm/wezterm.lua"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=”$HOME/.emacs.d/bin:$PATH”
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/share/go/bin"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# CONFIG:
# export VIMINIT="source $HOME/.config/vim/.vimrc"
export ZDOTDIR="$HOME/.config/shell/zsh"
# export XAUTHORITY="$HOME/.config/xauthority"

# CACHE:
export UMPV_SOCKET="$HOME/.cache/umpv/"
export LESSHISTFILE="$HOME/.cache/lesshst"

# DATA:
export GOPATH="$XDG_DATA_HOME"/go

# LF ICONS:
export LF_ICONS="\
tw=󰪺 :\
st=󰉋 :\
ow=󱁿 :\
dt=󰉋 :\
di=󰉋 :\
fi=󰈔 :\
ln=󰪹 :\
or=󱀱 :\
ex=󱁻:\
*.c=󰙱 :\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=󰙲 :\
*.css=󰌛 :\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=󰟓 :\
*.h=󰙲 :\
*.hh=󰙲 :\
*.hpp=:\
*.hs=:\
*.html= :\
*.java= :\
*.jl=:\
*.js= :\
*.json= :\
*.lua=󰢱 :\
*.md=󰗚 :\
*.php=󰌟 :\
*.pl=:\
*.pro=:\
*.py= :\
*.rb=󰴭 :\
*.rs=:\
*.scala=:\
*.ts=󰛦 :\
*.vim=:\
*.cmd=󱁼 :\
*.ps1=󱁼 :\
*.sh=󱁼 :\
*.bash=󱁼 :\
*.zsh=󱁼 :\
*.fish=󱁼 :\
*.tar=󰏗 :\
*.tgz=󰏗 :\
*.arc=:\
*.arj=:\
*.taz=󰏗 :\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=󰏗 :\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=󰿺 :\
*.z=󰏗 :\
*.dz=:\
*.gz=󰏗 :\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=󰏗 :\
*.zst=:\
*.tzst=:\
*.bz2=󰏓 :\
*.bz=󰏓 :\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=󰣚 :\
*.rpm=:\
*.jar=󰬷 :\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=󱉟 :\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=󰗄 :\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=󰋩 :\
*.jpeg=󰋩 :\
*.mjpg=󰋩 :\
*.mjpeg=󰋩 :\
*.gif=󰵸 :\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=󰋩 :\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=󰿎 :\
*.webm=󰎁 :\
*.ogm=:\
*.mp4=󰿎 :\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=󰎁 :\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=󰎁 :\
*.avi=󰎁 :\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=󰎆 :\
*.m4a=󰎆 :\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=󰎆 :\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=󰎁 :\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=󰈥 :\
*.nix=:\
*.iso=󰨆 :\
*.gba=󱎓 :\
*.xcf=󱇣 :\
*.docx=󰈬 :\
*.dotx=󰈬 :\
*.txt=󰈙 :\
*.srt=󰨖 :\
*.gitignore=󰊢 :\
*.zshrc=󰒔 :\
*.download=󰇚 :\
*.part=󰇚 :\
*.yml=󰒔 :\
*.tex=󰈛 :\
*.tp=󱉬 :\
*.doc=󱁯 :\
*.todo=󰝖 :\
*.ttf=󰙩 :\
*.otf=󰙩 :\
*.torrent=󰅢 :\
"
