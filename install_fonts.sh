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

if uname -a | grep Ubuntu
then
  echo 'Installing Google fonts.'
  install_google_fonts
fi
