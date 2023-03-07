# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=/opt/wine-stable/bin:$PATH

export PATH=$HOME/bin/android/sdk/platform-tools:$PATH
export PATH=$HOME/bin/gitextras/bin:$PATH
export PATH=$HOME/bin/idealgraph/bin:$PATH
export PATH=$HOME/bin/terraform:$PATH
export PATH=$HOME/.guix-profile/bin:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH=$HOME/bin/activitywatch/:$PATH
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=$HOME/TensorRT-7.0.0.11/lib/${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PYTHONPATH=/usr/lib/python3.6/dist-packages:$PYTHONPATH

if [ -f "$HOME/vulkan/1.2.148.1/setup-env.sh" ]; then source $HOME/vulkan/1.2.148.1/setup-env.sh; fi
export PATH=$VULKAN_SDK/bin:$PATH
export VULKAN_SDK=$HOME/vulkan/1.2.148.1/x86_64
export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

export PATH=$HOME/bin/trex/:$PATH
export PATH=$HOME/bin/platform-tools/:$PATH
export PATH=$HOME/android/sdk/platform-tools/:$PATH

export MDLOADER_CLI=$HOME/bin/ctrl/qmk_firmware/mdloader_linux
export PROTOC=$HOME/protobuf/bin/protoc
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

export SAM_CLI_TELEMETRY=0

alias sh="bash"
alias upgrade="sudo apt update -y && sudo apt upgrade -y"
alias zshconfig="code $HOME/.zshrc"
alias ohmyzsh="code $HOME/.oh-my-zsh"
alias cave="cat $HOME/Documents/api | xclip -selection clipboard"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias list="colorls -lA --sd"
alias entropy="head /dev/urandom | tr -dc A-Za-z0-9 | head -c"
alias mlserver="xxh +I xxh-plugin-zsh-ohmyzsh && source xxh.zsh -o PreferredAuthentications=publickey -i .ssh/auc_rsa 'ahmeds@10.7.60.150' +q"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@'
alias fix="fuck"

# Work stuff
export PATH="$PATH:/home/workspace/bin/git-duet"
export GIT_DUET_AUTHORS_FILE=/home/workspace/bin/git-authors

export GIT_EDITOR=vim
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi

if [ -f "$HOME/.cargo/env" ]; then source "$HOME/.cargo/env"; fi
if [ -f "$HOME/.nvm/nvm.sh" ]; then source "$HOME/.nvm/nvm.sh"; fi
if [ -f "/usr/share/autojump/autojump.zsh" ]; then source /usr/share/autojump/autojump.zsh; fi
