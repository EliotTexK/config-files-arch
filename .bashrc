# prompt
export PS1="[\u@\[\e[36m\]\h\[\e[m\]\[\e[37m\] \[\e[m\]\w] "

# add directories to $PATH
export PATH="$HOME/scripts:$HOME/.local/bin:$PATH"

# wrapper function for lf to change directory on quitout
LFCD="/home/eliot/scripts/lfcd.sh"
if [ -f "$LFCD" ]; then
	source "$LFCD"
fi

# aliases
alias ll='ls -l'
alias stopx='killall xinit'

# Startx immediately if in a login shell
shopt -q login_shell && startx
