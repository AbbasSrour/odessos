if status is-interactive
	source "./.config/shell/zsh/aliasrc"
	neofetch
  	printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'
end

function fish_greeting
 	fortune -a 
end

starship init fish | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set WINIT_UNIX_BACKEND x11
set WARP_ENABLE_WAYLAND=1
zoxide init fish | source
