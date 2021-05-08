#! /bin/bash
sudo eopkg it ncdu \
  -c system.devel \
  brave \
  copyq \
  font-firacode-ttf
  fzf \
  git \
  fish \
  firefox \
  kitty \
  neovim \
  rofi \
  scrot \
  starship \
  tmux \
  vim \
  virt-manager

sudo eopkg rmf rhythmbox

# Install rustup and add env to profile
curl https://sh.rustup.rs -sSf | sh
if ! grep -q "cargo/env" $HOME/.profile ; then
       echo "source \"$HOME/.cargo/env\"" >> $HOME/.profile
fi

cargo install bottom \
  fd-find \
  bat \
  exa
