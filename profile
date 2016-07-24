# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export LC_ALL=en_US.UTF-8
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]
then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/Downloads/RubyMine/bin" ]
then
  export PATH="$HOME/Downloads/RubyMine/bin:$PATH"
fi

if [ -d '/Applications/Postgres.app/Contents/Versions/9.4/bin' ]
then
  export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.rvm/bin

alias gst='git status'
alias gdf='git diff --color'
alias gdc='git diff --color --cached'
alias ga='git add'
alias gaa='git add .'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias less='less -R'
alias tmux='tmux -2'

if [ -e /usr/share/terminfo/x/xterm+256color ]
then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

source ~/.git-prompt.bash
source ~/.git-completion.bash
source ~/.ssh-completion.bash

mkdir -p /tmp/$USER/.vimundo

MYSQL=/usr/local/mysql/bin
if [ -e $MYSQL ]
then
  export PATH=$PATH:$MYSQL
  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
fi

eval $(docker-machine env 2>/dev/null)
