## 補完関数を増やす
fpath=($ZDOTDIR/functions/completions/src(N-/) $ZDOTDIR/functions/misc-completion(N-/) ${fpath})

autoload -Uz compinit
compinit -u

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt auto_menu
setopt auto_pushd
setopt complete_aliases
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_save_no_dups
setopt list_packed
setopt nolistbeep
setopt nonomatch
setopt notify
setopt pushd_ignore_dups
setopt share_history
setopt transient_rprompt

# バックグラウンドジョブも等しい優先度で実行
# バックグラウンドジョブを実行し続ける
# http://www.kyogoku.biz/docs/Shell/Zsh/customize
unsetopt bg_nice
unsetopt hup

bindkey -e

PROMPT="%n@%m%% "

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

# 今いるディレクトリを補完候補から外す（cd ../）
zstyle ':completion:*' ignore-parents parent pwd ..

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# C-p C-n で検索に
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Shift-Tabで補完候補を逆順する（"\e[Z"でも動作する）
bindkey "^[[Z" reverse-menu-complete

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# 補完候補をハイライトする
zstyle ':completion:*:default' menu select=2

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# load .zshrc_*
[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_external ] && . $ZDOTDIR/.zshrc_external
[ -f $ZDOTDIR/.zshrc_alias    ] && . $ZDOTDIR/.zshrc_alias
[ -f $ZDOTDIR/.zshrc_misc     ] && . $ZDOTDIR/.zshrc_misc
[ -f $ZDOTDIR/.zshrc_local    ] && . $ZDOTDIR/.zshrc_local
