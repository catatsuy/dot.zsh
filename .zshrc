autoload -Uz compinit
compinit -d /tmp/$USER.zcompdump

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -e

setopt nolistbeep

PROMPT="%n@%m%% "
RPROMPT="[%~]"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

source $ZDOTDIR/.zshrc.`uname`
[ -f $ZDOTDIR/.zshrc.local ] && source $ZDOTDIR/.zshrc.local

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias time='/usr/bin/time -p'

# 今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_pushd
setopt pushd_ignore_dups
setopt list_packed

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

function textopdf(){
    file=$1
    if platex $file
    then
        echo "\n--platex exit--\n"
        if dvipdfmx ${file%tex}dvi
        then
	        echo "\n--dvipdfmx exit--\n"
        else
	        echo "Look ${file%tex}log"
        fi
    fi
}
