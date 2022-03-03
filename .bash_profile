
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function parse_hg_dirty {
  [[ $( hg status 2> /dev/null ) != "" ]] && echo '*'
}
function parse_hg_branch {
  hg branch 2> /dev/null | sed -e "s/\(.*\)/[\1$(parse_hg_dirty)]/"
}
export PS1='[%~]:$(parse_git_branch)$(parse_hg_branch)$ '
# export PS1='\h:\W \u\$'
# export PS1="[%~]$ "
# export CVS_RSH=ssh; export CVSROOT=:ext:afeinberg@timesheets.iponweb.net:/var/cvs

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

source ~/.bashrc

export PATH="$HOME/.poetry/bin:$PATH"
