#!/bin/bash

for program_name in curl vim git zsh diff-so-fancy
do
  if ! command -v $program_name
  then
    echo "Please install $program_name first."
    exit 1
  fi
done

if [ -z $1 ]
then
  dotfiles_path=`pwd`
fi

function _dotfile_create_symlink {
  if [ -z $1 ]
  then
    return -1
  fi

  from=$1
  if [ -z $2 ]
  then
    to=.`basename $1`
  else
    to=$2
  fi

  if [ ! -L ~/$to ] || [ `readlink ~/$to` != $dotfiles_path/$from ]
  then
    if [ -e ~/$to ]
    then
      echo "Making backup form your current $to file"
      mv ~/$to ~/$to.old-`date +%Y%m%d-%H%M%S`
    fi
    echo -n "Creating symlink for $from ... "
    rm -f ~/$to
    ln -s $dotfiles_path/$from ~/$to && echo 'OK' || echo 'ERROR'
  fi
}

### ZSH ###

if [ -e ~/.oh-my-zsh ]
then
  echo 'Oh-My-Zsh has already installed.'
else
  echo 'Installing Oh-My-Zsh...'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo 'Installing/Updating bullet-train theme for zsh'
ZSH=~/.oh-my-zsh
mkdir -p $ZSH/custom/themes
curl -fLo $ZSH/custom/themes/bullet-train.zsh-theme http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme

### .configFiles ###

echo 'Creating missing symlinks.'
for file_name in vim vimrc gemrc gitignore_global rspec zshrc rubocop.yml ackrc tmux.conf
do
  _dotfile_create_symlink $file_name
done

### VIM ###

echo 'Installing plug.vim.'
VIM=~/.vim
if [ -e $VIM/autoload/plug.vim ]
then
  echo 'Plug.vim is already installed.'
else
  mkdir -p $VIM/autoload
  curl -fLo $VIM/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
mkdir -p $VIM/plugged
vim +PlugInstall +PlugUpdate +PlugUpgrade +qall!

### GIT ###

echo 'Setting global gitignore as ~/.gitignore_global.'
git config --global core.excludesfile ~/.gitignore_global

echo 'Setting global editor to vim'
git config --global core.editor vim

git config --global user.name 'Jozsef Nyitrai'
git config --global user.email 'nyitrai.jozsef@gmail.com'

echo 'Setting git aliases:'
echo '  git co = git checkout'
git config --global alias.co checkout
echo '  git ci = git commit'
git config --global alias.ci commit
echo '  git d  = git diff'
git config --global alias.d diff
echo '  git dt = git difftool'
git config --global alias.dt difftool
echo '  git st = git status'
git config --global alias.st status
echo '  git br = git branch'
git config --global alias.br branch
echo '  git last = git log -1 HEAD'
git config --global alias.last 'log -1 HEAD'
echo '  git unstage = git reset HEAD --'
git config --global alias.unstage 'reset HEAD --'
echo '  git restore = git checkout --'
git config --global alias.restore 'checkout --'
echo '  git patch = git --no-pager diff --no-color'
git config --global alias.patch '!git --no-pager diff --no-color'

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# improved color settings for the git diff
git config --global color.ui true

git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta "227"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "227 bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"

