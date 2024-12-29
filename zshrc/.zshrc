zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit


export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# oh my zsh plugins (fast-syntax-highlighting has performance issues if sourcing multiple times)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete direnv)
source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^I^I' autosuggest-accept
bindkey jj vi-cmd-mode

eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(tmuxifier init -)"

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eza
alias ls="eza --icons=always"
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# dirs
alias cd="z"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias cd..="cd .."
alias rd="rm -rf"
cx() { cd "$@" && l; }

# vim
alias ovim="/usr/bin/vim"
alias v=nvim
alias vim=nvim

alias cl='clear'
alias cat='bat --paging=never'
alias catc='bat -pp'
alias "cht.sh"='~/.config/cht.sh/cht.sh'

# network
ports-ls() { sudo lsof -i -P -n | grep LISTEN | grep "*:" | awk '{split($9, arr, ":"); print $1, arr[2]}' | sort | uniq | sort -k2 -n }

# machine maintenance
alias uz="source $HOME/.zshrc"
alias um="brew update && brew upgrade && omz update"
alias bb="brew update && brew bundle --file=~/.config/brew/Brewfile"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/omp/config.toml)"
fi
