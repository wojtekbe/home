PROMPT_COMMAND='hasjobs=$(jobs -p)'
PS1="\[\e[0;34m\][\[\e[0m\] \[\e[1;90m\]\h \[\e[1;32m\]\w\[\e[0m\] \${hasjobs:+\[\e[0;31m\]\j \[\e[0m\]}\[\e[0;34m\]]\[\e[0m\]\$ "

PATH=$PATH:~/.bin:/usr/local/bin

export EDITOR=vim
export MOZ_DISABLE_PANGO=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=none'
export XDG_CURRENT_DESKTOP=KDE

#man colors
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_so=$'\E[01;37;41m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

alias alsamixer='alsamixer -c 0'
alias db='cd ~/Dropbox'
alias avrdude='avrdude -p m8 -c usbasp'
alias vim='vim -p'
alias vi='vim -p'
alias shut="sudo shutdown -h now"
alias reboot="sudo reboot"
alias pdf="evince"
alias ls="ls --color -lha"
alias octave="octave -q"
alias 3='mplayer -cache 128 http://stream.polskieradio.pl/program3'
alias mc='TERM=screen-256color mc'
alias fm='pcmanfm -n . &'
alias grep='grep --color'
alias packer='packer --noedit'
alias mocp='mocp -T transparent-background'
alias ag='ag --color-path "1;30" --color-match "1;31" --color-line "1;30" --nogroup'

function termtitle {
	echo -ne "\033]0;${1}\007"
}

export KIGITHUB=https://github.com/KiCad
export KISYSMOD=/usr/shar/kicad/modules

if [ -f /etc/bash_completion ]; then
	 . /etc/bash_completion
fi
export LD_LIBRARY_PATH=/usr/local/lib/:

source /home/wojtekbe/.config/broot/launcher/bash/br
