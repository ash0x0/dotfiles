#!/usr/bin/env bash

NC='\033[0m'
RED='\033[1;31m'
GREEN='\033[0;32m'
CYAN='\033[1;36m'

info() {
    echo -e "${CYAN}*** $* ***${NC}"
}

error() {
    echo -e "${RED}$*"
    exit $ERRCODE
}

confirm() {
    while true; do
        read -p "$*? [Yy/Nn]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) error "Please answer Yy/N";;
        esac
    done
}

apt-mod() {
    sudo apt-get $*
}

mkdir -p $HOME/bin
cd $HOME/bin

info "Update and upgrade"
apt-mod update -y
apt-mod upgrade -y

if confirm "Run dist upgrade"; then apt-mod dist-upgrade -y; fi;

info "Remove the Canonical-monopolized snapd"
apt-mod autoremove --purge snapd -y

info "Install important system packages"
apt-mod install -y software-properties-common apt-transport-https wget curl ca-certificates gnupg-agent apt-transport-https ca-certificates gnupg lsb-release build-essential
apt-mod install -y ubuntu-restricted-extras zip unzip rar unrar p7zip-full p7zip-rar aptitude net-tools flatpak network-manager rpm

info "Install development tools and toolkits"
apt-mod install -y gcc g++ make build-essential git cmake autotools-dev autoconf automake libtool clang
apt-mod install -y git-extras silversearcher-ag graphviz doxygen doxygen-gui

info "Install fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

info "Install Ruby"
apt-mod install -y ruby-full

info "Install NodeJS LTS with NVM"
apt-mod remove nodejs
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
if grep -Fxq "export NVM_DIR" $HOME/.bashrc
then
:
else
cat <<EOT >> $HOME/.bashrc
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOT
fi
source $HOME/.bashrc
source $HOME/.nvm/nvm.sh
nvm install --lts
nvm use --lts
corepack enable

info "Install some useful packages from NPM"
npm install -g http-server yarn add-gitignore dockly tldr

info "Install JDK"
apt-mod install -y openjdk-8-jdk

info "Install firejail"
apt-mod install -y firejail

info "Install Github CLI"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt-mod update
apt-mod install gh -y

info "Install favorite utilities"
apt-mod install -y lm-sensors psensor psensor-server cpu-checker iotop lm-sensors conky hardinfo
apt-mod install -y zsh redshift dialog jq xclip autojump fonts-powerline python3-argcomplete thefuck qemu nmap ninja-build httpie gparted xclip htop filezilla ranger pavucontrol gnome-disk-utility tlp tlp-rdw file tilda googler openvpn
sudo gem install colorls
mkdir -p $HOME/.antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

info "Install Ohmyzsh"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

info "Install VSCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt-mod update -y
apt-mod install -y code

info "Install Docker CE"
apt-mod remove docker docker-engine docker.io containerd runc
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg
apt-mod update -y
apt-mod install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

info "Docker postinstall steps"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo getent group || sudo groupadd docker
sudo usermod -aG docker $USER
npm install -g dockly

info "Install kubectl"
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-mod update -y
apt-mod install -y kubectl

if confirm "Install Python dev"
then
    apt-mod install -y python3 python3-pip python3-dev python3-tk
    python3 -m pip install --user pipx pipenv virtualenv
    python3 -m pipx ensurepath
    python3 -m pipx completions
    
    echo "eval \"\$(register-python-argcomplete pipx)\"" >> $HOME/.bashrc
    echo "autoload -U bashcompinit" >> $HOME/.zshrc
    echo "bashcompinit" >> $HOME/.zshrc
    echo 'eval "$(register-python-argcomplete pipx)"' >> $HOME/.zshrc
fi

if confirm "Install Go"; then apt-mod install -y golang; fi;

if confirm "Install Rust"
then 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
fi

info "Install Homebrew"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew install pyenv

if confirm "Install minikube"
then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    apt-mod install -y ./minikube_latest_amd64.deb
    minikube start
fi

if confirm "Install Helm"
then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
fi

if confirm "Install LXC"
then
    apt-mod install -y lxc
    echo "$USER veth lxcbr0 10" | sudo tee /etc/lxc/lxc-usernet
    mkdir $HOME/.config/lxc
    cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
    printf "lxc.idmap = u 0 100000 65536\nlxc.idmap = g 0 100000 65536" | tee $HOME/.config/lxc/default.conf
fi

if confirm "Install gcloud sdk"
then
    wget -O google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-313.0.1-linux-x86_64.tar.gz
    tar xzvf google-cloud-sdk.tar.gz
    ./google-cloud-sdk/install.sh
fi

if confirm "Install Travis CLI"; then sudo gem install travis --no-document; fi;

if confirm "Install AVR & ARM development tools"; then apt-mod install -y gcc-avr binutils-avr avr-libc dfu-programmer dfu-util gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi; fi;

if confirm "Install Latex Tools"
then
    if confirm "Install texlive full"
    then
        apt-mod install texlive-full
    else
        apt-mod install -y texlive texlive-latex-extra texlive-latex-recommended texlive-science doxygen-latex
        apt-mod install -y latex2html latex2rtf kbibtex kile
        apt-mod install -y latexila texworks
    fi
fi

if confirm "Install graphical apps"
then
    apt-mod install -y vlc alacarte gimp redshift-gtk vim-gtk3

    if confirm "Install KDE"
    then
        apt-mod install -y kde-full ark yakuake
        
        info "Install Papirus theme"
        sudo add-apt-repository -y ppa:papirus/papirus
        apt-mod update -y
        apt-mod install -y papirus-icon-theme papirus-folders
        apt-mod install -y --install-recommends materia-kde
    fi

    if confirm "Install graphic editing tools"; then apt-mod install blender kdenlive openshot inkscape; fi;

    info "Install OBS"
    sudo add-apt-repository -y ppa:obsproject/obs-studio
    apt-mod update -y
    apt-mod install -y ffmpeg obs-studio

    info "Install Jetbrains Toolbox"
    wget -O jetbrains.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz
    tar xzvf jetbrains.tar.gz

    info "Install Chrome"
    wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    apt-mod install -y ./chrome.deb

    info "Install Slack"
    wget -O slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.10.0-amd64.deb"
    apt-mod install ./slack.deb

    info "Install GitKraken"
    wget -O gitkraken.deb "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
    apt-mod install ./gitkraken.deb

    info "Install Discord"
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    apt-mod install ./discord.deb

    info "Install Mailspring"
    wget -O mailspring.deb "https://updates.getmailspring.com/download?platform=linuxDeb"
    apt-mod install ./mailspring.deb

    info "Install JabRef"
    wget -O jabref.deb "https://www.fosshub.com/JabRef.html?dwl=jabref_5.1-1_amd64.deb"
    apt-mod install ./jabref.deb

    info "Install Mendeley"
    wget -O mendeley.deb "https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest"
    apt-mod install ./mendeley.deb
fi

read -p "Enter email for github SSH key: " email

info "Generate github ssh key"
ssh-keygen -t ed25519 -C "$email" -f $HOME/.ssh/github
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/github

read -p "Enter email for work SSH key: " workemail

info "Generate work ssh key"
ssh-keygen -t ed25519 -C "$workemail" -f $HOME/.ssh/work
ssh-add $HOME/.ssh/work

info "Change shell to zsh"
chsh -s $(which zsh)
