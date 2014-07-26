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


# Original author: Michalis Georgiou <mechmg93@gmail.comr>
# Modified by Andrew http://www.webupd8.org <andrew@webupd8.org>
function install_google_fonts {
  sudo apt-get install -y mercurial

  _hgroot='https://googlefontdirectory.googlecode.com/hg/'
  _hgrepo='googlefontdirectory'

  echo 'Connecting to Mercurial server....'
  if [ -d $_hgrepo ]; then
    cd $_hgrepo
    hg pull -u || return 1
    echo 'The local files have been updated.'
    cd ..
  else
    hg clone $_hgroot $_hgrepo || return 1
  fi
  echo 'Mercurial checkout done or server timeout'
  sudo mkdir -p /usr/share/fonts/truetype/google-fonts/
  find $PWD/$_hgrepo/ -name '*.ttf' -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
  fc-cache -f >/dev/null
  echo 'done.'
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

if uname -a | grep Ubuntu
then
  echo 'Installing Google fonts.'
  install_google_fonts
fi

