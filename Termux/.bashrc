
# Termux Prompt
PS1="\[\e[1;38;2;255;166;0m\]Yasin\[\e[01;37m\] at \[\e[01;33m\]Termux\[\e[0m\] \[\e[1;37m\]in \[\e[01;36m\]\W\n\[\e[1;37m\]$ \[\e[0m\]"

# Shortcuts for Most Used Directories
phone="/data/data/com.termux/files/home/storage/shared"
etc="/data/data/com.termux/files/usr/etc"
usr="/data/data/com.termux/files/usr"
download="/data/data/com.termux/files/home/storage/shared/Download"
font="/data/data/com.termux/files/usr/share/fonts"

# Directing to .bash_aliases file for aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# LS_COLORS - Set colors for ls output
eval "$(dircolors ~/.dircolors)"

# USER for Starship
export USER="Yasin"

# Starship init (config file in ~/.config)
eval "$(starship init bash)"
# Custom Login Prompt for Termux Sessions:

# Source the initial prompt script
bash $HOME/.loginScripts/initial_prompt.sh

# Exit Termux if exit signal file exists
if [ -f ~/.exit_termux ]; then
    rm ~/.exit_termux  # Remove the signal file
    exit  # Exit Termux
fi
