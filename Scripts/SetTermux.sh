#!/bin/bash

# Create or overwrite the .bashrc file in the home directory
cat << 'EOF' > ~/.bashrc

# Termux Prompt
PS1="\[\e[1;38;2;255;166;0m\]Yasin\[\e[01;37m\] at \[\e[01;33m\]Termux\[\e[0m\] \[\e[1;37m\]in \[\e[01;36m\]\W\n\[\e[1;37m\]$ \[\e[0;92m\]"

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
#eval "$(starship init bash)"
EOF

# Create or overwrite the colors.properties file in the appropriate directory
mkdir -p ~/.termux
cat << 'EOF' > ~/.termux/colors.properties
# Windows terminal like blue
#background=#00008B

# Midnight Blue
background=#191970

# Ubuntu like purple
#background=#300924

# Grey with tinge of green
#background=#002b36

# Dark Green
#background=#013220
EOF

# Create .bash_aliases file
cat << 'EOF' > ~/.bash_aliases
# Open nano with softwrap by default
alias nano="nano -S"

# alias for logging in debian
alias login="proot-distro login debian --user yasin"

# ls
alias la="ls -a"
alias ll="ls -la"
EOF

# Create .dircolors file
cat << 'EOF' > ~/.dircolors
# Directory colors
DIR 01;96

# Colors for file extensions
*.sh 01;92
*.sh 0;92                                                                                           # Ensure all normal files are set to white
NORMAL 0;37
FILE 38;2;250;215;160
EOF

# Fonts
mkdir -p /data/data/com.termux/files/usr/share/fonts
mv /data/data/com.termux/files/home/storage/shared/Download/*.ttf /data/data/com.termux/files/usr/share/fonts
ln -s /data/data/com.termux/files/usr/share/fonts/JetBrainsMonoNerdFont-Medium.ttf ~/.termux/font.ttf

# Motd File
cd /data/data/com.termux/files/usr/etc
cp motd motd.bak
echo "		Welcome To Termux!
" > motd
cd ~

# Source the .bashrc file to apply the changes
source ~/.bashrc

echo "Termux setup completed."
