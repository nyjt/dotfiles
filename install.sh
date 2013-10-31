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
    ln -s $dotfiles_path/$from ~/$to && echo 'OK' || echo 'ERROR'
  fi
}

_dotfile_create_symlink vim
for file_name in profile vimrc gemrc gitignore_global rspec bashrc rubocop.yml
do
  _dotfile_create_symlink $file_name
done

git submodule init
git submodule update

curl -Sso ~/.vim/autoload/pathogen.vim \
  https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

git config --global core.excludesfile ~/.gitignore_global

solarized_color_file=$dotfiles_path/vim/colors/sampler-pack/colors/solarized.vim
[ -e $solarized_color_file ] && rm $solarized_color_file

