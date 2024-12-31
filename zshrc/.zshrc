export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/tmux/plugins/tmuxifier/bin:$HOME/dotfiles/bin:$PATH
export LANG=en_US.UTF-8

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::dirhistory
zinit snippet OMZP::copyfile
zinit snippet OMZP::copypath
zinit snippet OMZP::copybuffer

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza --icons=always --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'ls_preview ${(Q)realpath}'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

fpath=(~/dotfiles/completions $fpath)

autoload -Uz compinit && compinit

zinit cdreplay -q

# FZF
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
export FZF_TMUX_OPTS=" -p90%,70% "  # fzf preview for tmux

bindkey '^E' fzf-cd-widget
bindkey '^I^I' autosuggest-accept
bindkey jj vi-cmd-mode

HISTFILE=$HOME/.zhistory
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_verify

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
# eval "$(tmuxifier init -)"
source $HOME/.config/zshrc/aliases.zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/omp/config.toml)"
fi
