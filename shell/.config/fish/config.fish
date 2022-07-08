if status is-interactive
	source "./.config/shell/zsh/aliasrc"
	clear
	neofetch
end

function fish_greeting
	fortune -a 
end

starship init fish | source
