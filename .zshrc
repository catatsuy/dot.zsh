autoload -U compinit
compinit -d /tmp/$USER.zcompdump

HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -e

setopt nolistbeep

PROMPT="%n@%m%% "
RPROMPT="[%~]"

source ~/.zshrc.`uname`

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

eval "$(rbenv init -)"
source ~/perl5/perlbrew/etc/bashrc

# 今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

setopt auto_pushd
setopt pushd_ignore_dups
setopt list_packed

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
