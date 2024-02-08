HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt INC_APPEND_HISTORY
PATH=$PATH:/home/wojtekbe/.bin:/home/wbie/.bin:/home/wbie/local/bin:/home/wbie/.local/bin
setopt autocd extendedglob
unsetopt beep
bindkey -v

#LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
#export LS_COLORS

autoload -Uz compinit promptinit
compinit
promptinit

PROMPT='%F{#076678}%n@%m%f %F{#689D6A}%0~%f %F{#CC241D}%(1j.%j .)%f%F{#665C54}%#%f '

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^f' autosuggest-accept
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[5~" beginning-of-history

alias vim='vim -p'
alias ls='ls -lha --color'
alias grep='grep --color'
alias ag='ag --color-path "1;30" --color-match "1;31" --color-line "1;30" --nogroup'
alias vif='vim -p $(fzf)'
alias cal='cal -3m'

EDITOR=vim
GIT_EDITOR=$EDITOR
