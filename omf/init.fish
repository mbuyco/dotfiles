# initialize aliases
bass source $HOME/dotfiles/aliases/main
bass source $HOME/dotfiles/aliases/docker
bass source $HOME/dotfiles/aliases/git

# export path
export PATH="$PATH:$HOME/.local/bin"

# export rbenv
if [ -d "$HOME/.rbenv/bin" ];
    export PATH="$PATH:$HOME/.rbenv/bin"
end
