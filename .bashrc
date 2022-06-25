# Startx immediately if in a login shell
shopt -q login_shell && startx

# prompt
export PS1="[\u@\[\e[36;40m\]\h\[\e[m\]\[\e[40m\]\[\e[m\] \W]$ "

# add the scripts directory to $PATH
export PATH="$PATH:$HOME/scripts"

# aliases
alias ll='ls -l'
