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
alias cht='~/.config/cht.sh/cht.sh'
alias lg="lazygit"
alias fman="compgen -c | fzf | xargs man"
alias nlof="~/dotfiles/scripts/fzf_listoldfiles.sh"

# network
ports-ls() { sudo lsof -i -P -n | grep LISTEN | grep "*:" | awk '{split($9, arr, ":"); print $1, arr[2]}' | sort | uniq | sort -k2 -n }

# machine maintenance
alias uz="source $HOME/.zshrc"
alias um="brew update && brew upgrade && omz update"
alias bb="brew update && brew bundle --file=~/.config/brew/Brewfile"