#! /bin/bash
sudo eopkg it ncdu \
  -c system.devel \
  brave \
  copyq \
  git \
  firefox \
  scrot \
  vim \
  virt-manager \
  xclip

sudo eopkg rmf rhythmbox

# Install rustup and add env to profile
curl https://sh.rustup.rs -sSf | sh
if ! grep -q "cargo/env" $HOME/.profile ; then
       echo "source \"$HOME/.cargo/env\"" >> $HOME/.profile
fi
