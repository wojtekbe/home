HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt INC_APPEND_HISTORY
PATH=$PATH:/home/wojtekbe/.bin
setopt autocd extendedglob
unsetopt beep
bindkey -v

zstyle :compinstall filename '/home/wojtekbe/.zshrc'
zstyle ':completion:*' menu select
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit promptinit
compinit
promptinit

PROMPT='%F{4}[%f %F{8}%m%f %F{10}%0~%f %F{red}%(1j.%j .)%f%F{4}]%f%# '

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

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
alias rg='rg -i --no-heading --vimgrep'
alias ip='ip -c a'
alias redshift='redshift 52.41:16.93'

alias -s pdf=mupdf

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[5~" beginning-of-history

bindkey '^R' history-incremental-search-backward

source /home/wojtekbe/.config/broot/launcher/bash/br
