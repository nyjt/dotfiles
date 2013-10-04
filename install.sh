#!/bin/bash

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

  if [ -e ~/$to ]
  then
    mv ~/$to ~/$to.old
  fi

  echo -n "Creating symlink for $from ... "
  ln -s ~/dotfiles/$from ~/$to && echo 'OK' || echo 'ERROR'
}

for file_name in profile vimrc gemrc gitignore rspec bashrc
do
  _dotfile_create_symlink $file_name
done

