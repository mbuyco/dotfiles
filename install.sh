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

	echo "apt"
}

function install_node() {
	if [ -s "$HOME/.nvm" ]; then
		return 0
	fi

	# Install nvm with curl
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

	# Load nvm
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

	# Install latest node version
	nvm install --lts

	abort_if_error
}

function install_shell() {
	# Install oh-my-zsh
	git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

	if [ -s "$HOME/.zshrc" ]; then
		return 0
	fi

	sudo ln -s "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
	sudo ln -s "$HOME/dotfiles/zsh/.zsh_aliases" "$HOME/.zsh_aliases"

	source "$HOME/.zshrc"

	chsh -s $(which zsh)
}

function install_tmux() {
	# Install tmux plugin manager
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

	# Copy tmux config
	sudo ln -s "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

	# Set tmux config
	tmux source "$HOME/.tmux.conf"

	# Install tmux plugins
	tmux start-server && \
	tmux new-session -d && \
	sleep 1 && \
	~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
	tmux kill-server
}

function install_vim() {

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim config and plugins
sudo ln -s "$HOME/dotfiles/vim/.vimrc" "$HOME/.vimrc"
vim +PlugInstall

}

if [ $(package_manager) = "apt" ]; then
	powerline_fonts="fonts-powerline"
else
	powerline_fonts="powerline-fonts"
fi

# Install prerequisites
sudo $(package_manager) install -y curl git vim tmux zsh xclip $powerline_fonts

echo "Setting up node environment..."
install_node

echo "Installing tmux..."
install_tmux

# Install vim
echo "Installing vim..."
install_vim

echo "Installing zsh shell..."
install_shell
