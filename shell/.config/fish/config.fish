if status is-interactive
	source "./.config/shell/zsh/aliasrc"
	clear
	neofetch
end

function fish_greeting
	fortune -a 
end

starship init fish | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
