#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

autoload -U compinit
compinit

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ -s "${ZDOTDIR:-$HOME}/.tmuxinator/scripts/tmuxinator" ]] && source "${ZDOTDIR:-$HOME}/.tmuxinator/scripts/tmuxinator"

if [[ -s "${ZDOTDIR:-$HOME}/.aliasrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.aliasrc"
fi

bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

echo -e "\033]P44040ff\033\\"

if [[ -s "${ZDOTDIR:-$HOME}/.zshrc-mine" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc-mine"
fi
# Customize to your needs...
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/opt/ruby/bin:$PATH"
eval "$(direnv hook $SHELL)"

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

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
