set -x PATH $PATH ~/.bin ~/compilers/gcc-arm-none-eabi-9-2019-q4-major/bin/ ~/xtensa/XtDevTools/install/tools/RI-2021.8-linux/XtensaTools/bin
set -U fish_greeting

set -U  EDITOR vim

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
alias fm='pcmanfm -n . > /dev/null 2>&1 &'
alias grep='grep --color'
alias packer='packer --noedit'
alias mocp='mocp -T transparent-background'
alias ag='ag --color-path "1;30" --color-match "1;31" --color-line "1;30" --nogroup'
alias rg='rg -i --no-heading --vimgrep'
alias redshift='redshift -l 52.41:16.93'
alias cal='cal -3m'
alias pmount='udisksctl mount -b'
alias pumount='udisksctl unmount -b'
alias ncdu='ncdu --color dark'
alias gw='gwenview'
alias konsole='QT_SCALING_FACTOR=1 konsole'
alias tree='tree -A'
alias j='jobs'
alias t='tree -C -L 3'
alias tree='tree -C'
alias cdf='cd (find -type d | fzf)'
alias pacmanf='pacman -Slq | fzf --multi --preview \'pacman -Si {1}\' | xargs -ro sudo pacman -S'
alias vif='vim -p (fzf --multi)'
alias dus='du -ah . | sort -h | tail -n 100'
alias openf='xdg-open (fzf) &'

switch (tty)
    case "/dev/tty*"
        cowsay (fortune -s)
end

set -U fish_prompt_pwd_dir_length 0

export EDITOR=vim
export BROWSER=chromium
