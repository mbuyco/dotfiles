# git
alias g "git"
alias gc "git commit"
alias gm "git merge"
alias gs "git status"
alias ga "git add"
alias gg "git grep"
alias gd "git diff"
alias gp "git push"
alias gf "git fetch; git pull"
alias gst "git stash"
alias gco "git checkout"
alias gb "git branch"
alias gr "git reset"

# virtualfish
eval (python -m virtualfish)

# set npm modules PATH
set fish_user_paths (npm config get prefix)/lib/node_modules

