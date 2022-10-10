#!/usr/bin/env bash

mkdir $HOME/bin
cd $HOME/bin

echo "Update and upgrade"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo "Remove the Canonical-monopolized snapd"
sudo apt-get autoremove --purge snapd -y

echo "Install important system packages"
sudo apt-get install -y software-properties-common apt-transport-https wget curl ca-certificates gnupg-agent apt-transport-https ca-certificates gnupg lsb-release build-essential
sudo apt-get install -y ubuntu-restricted-extras zip unzip rar unrar p7zip-full p7zip-rar aptitude net-tools flatpak network-manager rpm

echo "Install development tools and toolkits"
sudo apt-get install -y gcc g++ make build-essential git cmake autotools-dev autoconf automake libtool clang
sudo apt-get install -y git-extras fzf silversearcher-ag graphviz doxygen doxygen-gui

echo "Install Ruby"
sudo apt-get install -y ruby-full

echo "Install Python"
sudo apt-get install -y python3 python3-pip python3-dev python3-tk
pip3 install --user pipx pipenv virtualenv
pipx completions

echo "Install Go"
sudo apt-get install -y golang

echo "Install Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Install NodeJS LTS & NPM"
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Install some useful packages from NPM"
sudo npm install -g http-server yarn add-gitignore dockly tldr

echo "Install JDK"
sudo apt-get install -y openjdk-8-jdk

echo "Install AppImage daemons"
systemctl --user stop appimaged.service || true
sudo apt-get -y remove appimagelauncher || true
rm "$HOME"/.local/share/applications/appimage*
sudo apt-get install -y firejail
# this won't work in zsh
wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)
chmod +x appimaged-*.AppImage
./appimaged-*.AppImage

echo "Install Github CLI"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt-get update -y
sudo apt-get install -y gh

echo "Install Travis CLI"
sudo gem install travis --no-document

echo "Install gcloud sdk"
wget -O google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-313.0.1-linux-x86_64.tar.gz
tar xzvf google-cloud-sdk.tar.gz
./google-cloud-sdk/install.sh

echo "Install AVR & ARM development tools"
sudo apt-get install -y gcc-avr binutils-avr avr-libc dfu-programmer dfu-util gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi

echo "Install personal favorite tools"
sudo apt-get install -y lm-sensors hddtemp psensor psensor-server cpu-checker iotop lm-sensors conky hardinfo
sudo apt-get install -y vlc alacarte openvpn gimp
sudo apt-get install -y zsh redshift redshift-gtk dialog jq xclip vim-gtk3 autojump fonts-powerline python3-argcomplete thefuck zsh-antigen qemu nmap ninja-build httpie gparted xclip htop filezilla ranger pavucontrol gnome-disk-utility tlp tlp-rdw clementine file tilda googler iotop
sudo gem install colorls
# sudo apt-get install refind
# sudo apt-get install blender kdenlive openshot inkscape

echo "Install Latex Tools"
# sudo apt-get install texlive-full
sudo apt-get install -y texlive texlive-latex-extra texlive-latex-recommended texlive-science doxygen-latex
sudo apt-get install -y latex2html latex2rtf kbibtex kile
sudo apt-get install -y latexila texworks

echo "Change shell to zsh"
chsh -s $(which zsh)

echo "Install Ohmyzsh"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

echo "Install Homebrew"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Install OBS"
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt-get update -y
sudo apt-get install -y ffmpeg obs-studio

echo "Install VSCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update -y
sudo apt-get install -y code
# sudo apt-get install code-insiders

echo "Install Docker CE"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo groupadd docker
sudo systemctl enable docker
sudo systemctl enable containerd
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
sudo npm install -g dockly

echo "Install kubectl"
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update -y
sudo apt install -y kubectl

echo "Install minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo apt install -y ./minikube_latest_amd64.deb 
minikube start

echo "Install Helm"
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update -y
sudo apt-get install -y helm
helm repo update
helm search repo bitnami

echo "Install LXC"
sudo apt-get install -y lxc
echo "$USER veth lxcbr0 10" | sudo tee /etc/lxc/lxc-usernet
mkdir $HOME/.config/lxc
cp /etc/lxc/default.conf $HOME/.config/lxc/default.conf
printf "lxc.idmap = u 0 100000 65536\nlxc.idmap = g 0 100000 65536" | tee $HOME/.config/lxc/default.conf

echo "Install KDE"
sudo apt-get install -y kde-full ark yakuake

echo "Install Papirus theme"
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt-get update -y
sudo apt-get install -y papirus-icon-theme papirus-folders
sudo apt-get install -y --install-recommends materia-kde

echo "Install Jetbrains Toolbox"
wget -O jetbrains.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz
tar xzvf jetbrains.tar.gz

echo "Install Chrome"
wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y ./chrome.deb

echo "Install Slack"
wget -O slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.10.0-amd64.deb"
sudo apt install ./slack.deb

echo "Install GitKraken"
wget -O gitkraken.deb "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
sudo apt install ./gitkraken.deb

echo "Install Discord"
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install ./discord.deb

echo "Install Mailspring"
wget -O mailspring.deb "https://updates.getmailspring.com/download?platform=linuxDeb"
sudo apt install ./mailspring.deb

echo "Install JabRef"
wget -O jabref.deb "https://www.fosshub.com/JabRef.html?dwl=jabref_5.1-1_amd64.deb"
sudo apt install ./jabref.deb

echo "Install Mendeley"
wget -O mendeley.deb "https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest"
sudo apt install ./mendeley.deb

echo "Install Tixati"
wget -O tixati.deb "https://download2.tixati.com/download/tixati_2.76-1_amd64.deb"
sudo apt install ./tixati.deb
