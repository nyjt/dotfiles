#!/bin/sh

# Ubuntu packages install
sudo apt-get --yes install default-jre vim curl postgresql git tig \
mosh ubuntu-desktop chromium-browser libyaml-0-2 rar octave whois \
smplayer

# RVM install
if type rvm | head -n 1
then
  echo 'RVM has already installed.'
else
  curl -sSL https://get.rvm.io | bash -s stable --rails
  source ~/.rvm/scripts/rvm
fi

