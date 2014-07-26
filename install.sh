#!/bin/bash
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
    to=".$1"
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
    rm ~/$to
    ln -s $dotfiles_path/$from ~/$to && echo 'OK' || echo 'ERROR'
  fi
}

echo 'Creating missing symlinks.'
_dotfile_create_symlink vim
for file_name in profile vimrc gemrc gitignore_global rspec bashrc rubocop.yml
do
  _dotfile_create_symlink $file_name
done

echo 'Initializing and upgrading git submodules.'
git submodule init
git submodule update

echo 'Installing pathogen.vim.'
curl -Sso ~/.vim/autoload/pathogen.vim \
  https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo 'Setting global gitignore as ~/.gitignore_global.'
git config --global core.excludesfile ~/.gitignore_global
