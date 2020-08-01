#!/bin/bash

function abort_if_error() {
	if [ $? -gt 0 ]; then
		exit $?
	fi
}

function package_manager() {
	cat /etc/*-release | grep fedora

	if [ $? -eq 0 ]; then
		echo "dnf"
		return 0
	fi

	lsb_release -a | grep "debian\|ubuntu"

	if [ $? -eq 0 ]; then
		echo "apt"
	fi
}

# Install nvm with curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install latest node version
nvm install --lts

abort_if_error

# Install pure prompt
npm i -g pure-prompt

touch ~/.zshrc

# Configure .zshrc
cat << EOF > ~/.zshrc
autoload -U promptinit; promptinit
prompt pure
EOF

# Install tmux
sudo $(package_manager) install tmux

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy tmux config
ln -s ./tmux/.tmux.conf ~/.tmux.conf

# Install tmux plugins
tmux start-server
tmux new-session -d
sleep 1
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

# Install vim
sudo $(package_manager) install vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim config and plugins
ln -s ./vim/.vimrc ~/.vimrc; vim +PlugInstall
