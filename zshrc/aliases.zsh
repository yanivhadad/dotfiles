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
alias ldock="lazydocker"
alias fman="compgen -c | fzf | xargs man"
alias nlof="~/dotfiles/scripts/fzf_listoldfiles.sh"

# network
ports-ls() { sudo lsof -i -P -n | grep LISTEN | grep "*:" | awk '{split($9, arr, ":"); print $1, arr[2]}' | sort | uniq | sort -k2 -n }

# machine maintenance
alias uz="source $HOME/.zshrc"

# python
alias python="uvx -p 3.13 python"
alias py="uvx -p 3.13 python"
alias ur="uv run"

um() {
  brew update && brew upgrade && bat cache --build
  uv tool upgrade --python 3.12 posting
  uv tool update-shell
}

bb() {
  brew update && brew bundle --file=~/.config/brew/Brewfile
  uv tool install --python 3.12 posting
}

# python
load-pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
}
