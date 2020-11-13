# godcuts (god shortcuts)
alias tm="tmux"
alias c="clear"
alias e="exit"

# dotfiles
alias godot="cd ~/dotfiles";
alias udot="godot && gst && gc; echo '\nYOU ARE NOW IN DOTFILES! PLEASE CHECK CHANGES ABOVE.'";

# zsh
alias zshr="echo 'Restarting ZSH...'; source ~/.zshrc; echo '[DONE]';";
alias als="vim ~/.zsh_aliases"

# ebp ssh
alias ebpdev="echo 'Connecting to EBP...'; autossh -M 5000:22 lmsadmin@151.106.38.236"

# convenience
alias zshc="vim ~/.zshrc"
alias vimc="vim ~/.vimrc"
alias tmuxc="vim ~/.tmux.conf"

# replace docker with podman
#alias docker="podman"

# replace docker-compose with podman-compose
#alias docker-compose="podman-compose"

# ssh to aws
alias awssh="ssh -i /home/luntian/gorillaprep-key.pem mike@13.52.209.52"

# youtube-dl
alias ydlm="youtube-dl --extract-audio --audio-format mp3"

# aws-cli
alias awscc="aws codecommit"
alias awscp="awscc create-pull-request"

# notes
NOTES_FILENAME="notes-$(date +%Y%m%d).txt"
alias notes="mkdir ~/notes; touch ~/notes/${NOTES_FILENAME}; cd ~/notes; vim ~/notes/${NOTES_FILENAME}"

# jekyll
alias jk="jekyll"

# git
alias gg="git grep"

# dbm
alias wpw="cat ~/Dropbox/Michael\ Buyco/PW/passwords"
alias dbm="ssh -p 9080 gnoldbm@dbmarketer.net"

# digitalocean droplet pw
alias dpw="echo 0e9bb2706b90024a39ba3f3f57"
alias dpc="ssh root@128.199.100.104"
