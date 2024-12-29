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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete direnv docker)
profile_command "before oh-my-zsh"
source $ZSH/oh-my-zsh.sh
profile_command "oh-my-zsh"

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
profile_command "fzf"

bindkey '^I^I' autosuggest-accept
bindkey jj vi-cmd-mode

# eval "$(pyenv init -)"
# profile_command "pyenv"
eval "$(zoxide init zsh)"
profile_command "zoxide"
eval "$(atuin init zsh)"
profile_command "atuin"
eval "$(tmuxifier init -)"
profile_command "tmuxifier"

# NVM configuration (seems like its not needed)
# nvm() {
#     if ! command -v nvm &> /dev/null; then
#         # Initialize nvm if not already initialized
#         export NVM_DIR="$HOME/.nvm"
#         [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#         [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#     fi
#     # Pass arguments to the actual nvm command
#     command nvm "$@"
# }
# profile_command "nvm"

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

time {
alias cl='clear'
alias cat='bat --paging=never'
alias catc='bat -pp'
alias "cht.sh"='~/.config/cht.sh/cht.sh'
alias lg="lazygit"
}
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
