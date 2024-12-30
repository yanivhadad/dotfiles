PROFILING_ENABLE=0

if [[ "$PROFILING_ENABLE" == "1" ]]; then
  zmodload zsh/datetime
  prof_start=$EPOCHREALTIME
  echo "Profiling enabled. Log: ~/.zshrc_profile.log" > ~/.zshrc_profile.log
fi

# Function to log timestamps for each executed command
profile_command() {
  if [[ "$PROFILING_ENABLE" == "1" ]]; then
    zmodload zsh/datetime
    local now=$EPOCHREALTIME
    local duration=$(echo "$now - $prof_start" | bc)
    echo "[${duration}s] $1" >> ~/.zshrc_profile.log
    prof_start=$now
  fi
}

profile_command "zshrc start"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# oh my zsh plugins (fast-syntax-highlighting has performance issues if sourcing multiple times)
# zsh-autocomplete
plugins=(direnv)
profile_command "before oh-my-zsh"
source $ZSH/oh-my-zsh.sh
profile_command "oh-my-zsh"

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_E_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_CTRL_E_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

bindkey '^E' fzf-cd-widget

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "  
profile_command "fzf"

bindkey '^I^I' autosuggest-accept
bindkey jj vi-cmd-mode

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"
profile_command "zoxide"
eval "$(atuin init zsh)"
profile_command "atuin"
eval "$(tmuxifier init -)"
profile_command "tmuxifier"

# git
alias gaa="git add -A"
alias gc="git commit -m"
alias gpl="git pull"
alias gps="git push"

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

# cat
alias cat='bat --paging=never'
alias catc='bat -pp'

# misc
alias cl='clear'
alias "cht.sh"='~/.config/cht.sh/cht.sh'
alias lg="lazygit"
alias fman="compgen -c | fzf | xargs man"
alias nlof="~/dotfiles/scripts/fzf_listoldfiles.sh"

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

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/omp/config.toml)"
fi
