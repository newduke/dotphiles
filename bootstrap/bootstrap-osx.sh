#!/bin/sh
chsh -s /bin/zsh
sudo port install coreutils +with_default_names
sudo port install screen
sudo port install elinks +col256
sudo port install mutt-devel +sasl +ssl +smtp +sidebar +headercache +tokyocabinet +gpgme
sudo port install irssi
sudo port install proctools
sudo port install mtr
sudo port install wget
sudo port install tmux
sudo port install tmux-pasteboard
sudo port install gnupg
sudo port install ipcalc
sudo port install grc
