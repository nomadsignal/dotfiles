#!/bin/bash

CONFIG_DIR=$HOME/.config
APP_DIRS=( termite zsh tmux nvim i3 rofi i3status )

# Install all packages
sudo pacman -Syu
sudo pacman -S termite zsh tmux neovim i3-gaps i3status rofi ruby python python2 python-pip python2-pip 
# Make config directory
if [ ! -d $CONFIG_DIR ]; then
  mkdir $CONFIG_DIR
fi

# Make app directories
for application in "${APP_DIRS[@]}"; 
do
  if [ ! -d $CONFIG_DIR/$application ];
  then
    mkdir $CONFIG_DIR/$application
  fi
done

# Setup hardlinks dotfiles->configdir 
CONFIG_FILES=
( 
  termite/config
  tmux/tmux.conf
  nvim/init.vim
  i3/config
  i3status/config
  rofi/dracula.rasi
)

for configFile in "${CONFIG_FILES[@]}";
do
  if [ ! -h $CONFIG_DIR/$configFile];
  then
    ln $config_file $CONFIG_DIR/$configFile
  fi
done

# Setup hardlinks for zsh
ln zsh/*        $HOME/.config/zsh
ln zsh/.zshrc   $HOME/.config/zsh
ln zsh/.zshenv  $HOME/.zshenv

# .xinitrc
ln .xinitrc $HOME/.xinitrc

# Setup global packages npm

if [ ! -d $CONFIG_DIR/npm-global ]; 
then
  mkdir $CONFIG_DIR/npm-global
fi

npm config set prefix '/home/nomadsignal/.config/npm-global'


# Python/Node/Ruby support neovim 
pip install --user neovim
pip2 install --user neovim
npm install -g neovim
gem install neovim

# Install vim-plug
curl -fLo $CONFIG_DIR/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
nvim +:PlugInstall +qall


