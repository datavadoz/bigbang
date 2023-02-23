#!/usr/bin/env bash

# Install everyday packages
sudo apt-get -y update
sudo apt-get -y install fish tmux exa neovim python3-neovim

# Install fish theme
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/omf_install
fish /tmp/omf_install --noninteractive --yes
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

# Install Miniconda and initilize it
curl https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh > /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -u -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init fish 
$HOME/miniconda3/bin/conda config --set env_prompt ""

# Set fish as default shell
chsh -s /usr/bin/fish

