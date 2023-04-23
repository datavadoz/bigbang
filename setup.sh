#!/usr/bin/env bash

# Install everyday packages
sudo add-apt-repository -y ppa:fish-shell/release-3
sudo apt-get -y update
sudo apt-get -y install fish tmux exa neovim python3-neovim build-essential

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

set -Ua fish_user_paths \$HOME/.cargo/bin
END

# Install Miniconda and initilize it
curl https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh > /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -u -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init fish 
$HOME/miniconda3/bin/conda config --set env_prompt ""

# Set fish as default shell
chsh -s /usr/bin/fish

# Install Docker
sudo apt-get install ca-certificates curl gnupg lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER

# Install Rust
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh
