#!/usr/bin/env bash

# Install basic packages
sudo apt update && \
sudo apt install -y --no-install-recommends \
    zip \
    unzip \
    net-tools \
    tree \
    htop \
    iotop \
    iperf \
    dnsutils \
    whois \
    wget \
    curl \
    git \
    bash-completion \
    ncdu


curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

while true
do
    read -r -p "Do you want to setup 'zsh' as your default shell? [y/n] " input
    case $input in
        [yY])
            # Install zsh and set it as default shell
            sudo apt install -ys zsh
            chsh -s $(which zsh)
            break
            ;;
        [nN])
            break
            ;;
        *)
            echo "Please answer yes or no..."
            ;;
    esac
done
