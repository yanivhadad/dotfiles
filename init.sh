# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl https://get.volta.sh | bash

# update bat theme
bat cache --build

# install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s