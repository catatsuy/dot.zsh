## 補完関数を増やす
fpath=(~/.zsh/functions/completions/src(N-/) ${fpath})

autoload -Uz compinit
compinit -d /tmp/$USER.zcompdump

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# ignore duplication command history list
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# share command history data
setopt share_history

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
setopt pushd_ignore_dups

setopt complete_aliases

setopt list_packed

setopt nolistbeep

bindkey -e

PROMPT="%n@%m%% "
RPROMPT="[%~]"

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

# 環境ごとの設定を読み込み

[ -f $ZDOTDIR/.zshrc.`uname` ] && source $ZDOTDIR/.zshrc.`uname`

[ -f $ZDOTDIR/.zshrc.local ]   && source $ZDOTDIR/.zshrc.local

[ -f $ZDOTDIR/.zshrc.path  ]   && source $ZDOTDIR/.zshrc.path

# alias

[ -f $ZDOTDIR/.zshrc.alias  ]  && source $ZDOTDIR/.zshrc.alias

# myfunc

[ -f $ZDOTDIR/.zshrc.myfunc ]  && source $ZDOTDIR/.zshrc.myfunc

# set path of emacs

[ -f $ZDOTDIR/.zshrc.emacs ]  && source $ZDOTDIR/.zshrc.emacs

# 今いるディレクトリを補完候補から外す（cd ../）
zstyle ':completion:*' ignore-parents parent pwd ..

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# C-p C-n で検索に
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
