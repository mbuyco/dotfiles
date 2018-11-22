# git
alias g "git"
alias gc "git commit"
alias gm "git merge"
alias gs "git status"
alias ga "git add"
alias gg "git grep --break --heading -n"
alias gd "git diff"
alias gp "git push"
alias gf "git fetch; git pull"
alias gst "git stash"
alias gco "git checkout"
alias gb "git branch"
alias gr "git reset"

alias flame_on "sudo dscl . -append /groups/admin GroupMembership mldrbuyco"
alias flame_off "sudo dscl . -delete /groups/admin GroupMembership mldrbuyco"

# virtualfish
eval (python -m virtualfish)

# set npm modules PATH
set fish_user_paths (npm config get prefix)/lib/node_modules

# set NVM_DIR
set -gx NVM_DIR $HOME/.nvm
