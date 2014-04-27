setopt nobeep
setopt promptsubst
setopt append_history          # append rather than overwrite history file.
setopt hist_expire_dups_first  # allow dups, but expire old ones when I hit HISTSIZE
setopt extended_history        # save timestamp and runtime information
setopt autocd
setopt autopushd
setopt extended_glob

export HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
export HISTSIZE=1200                  # lines of history to maintain memory
export SAVEHIST=1000                  # lines of history to maintain in history file.
export KEYTIMEOUT=1
export CLICOLOR=1
export EDITOR=vim

autoload -U colors && colors
autoload -U edit-command-line && zle -N edit-command-line

bindkey -v

bindkey -M vicmd v edit-command-line

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^r' history-incremental-search-backward

source "$HOME/.zsh/prompt.zsh"
source "$HOME/.zsh/plugins/opp.zsh/opp.zsh"
source "$HOME/.zsh/plugins/opp.zsh/opp"/*.zsh

alias ll='ls -al'
alias la='ls -a'
alias lt='ls -lt'

function p { ps auxwww | grep "$*" }
