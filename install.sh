#! /bin/bash
sudo eopkg it ncdu \
  fzf \
  neovim \
  -c system.devel \
  tmux \
  vim \
  kitty \
  git \
  fish \
  firefox brave \
  rofi

sudo eopkg rmf rhythmbox
curl https://sh.rustup.rs -sSf | sh

cargo install bottom \
  fd-find \
  bat \
  exa
