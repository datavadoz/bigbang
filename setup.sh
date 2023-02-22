#!/usr/bin/env bash

# Install everyday packages
sudo apt upgrade
sudo apt-get -y update
sudo apt-get -y install fish tmux exa neovim python3-neovim

# Install fish theme
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/omf_install
fish -c "fish /tmp/omf_install --path=~/.local/share/omf --config=~/.config/omf"
fish -c "omf install bobthefish"

# Fish config
tee $HOME/.config/fish/config.fish << END
set -U fish_greeting ""

alias tm='TERM=screen-256color-bce tmux'

if type -q exa
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g theme_display_virtualenv yes
    set -g theme_color_scheme gruvbox
    set -g theme_date_format "+%a %d/%m/%y %H:%M:%S"
    set -g theme_nerd_fonts yes
end
END

# Set fish as default shell
chsh -s /usr/bin/fish

