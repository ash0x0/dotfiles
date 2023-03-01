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

export PATH=/home/ahmed/bin/android/sdk/platform-tools:$PATH
export PATH=/home/ahmed/.local/bin:$PATH
export PATH=/home/ahmed/bin:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=/home/ahmed/bin/gitextras/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=/home/ahmed/bin/idealgraph/bin:$PATH
export PATH=/home/ahmed/.guix-profile/bin:$PATH
export PATH=/home/ahmed/bin/terraform:$PATH
export PATH=/opt/wine-stable/bin:$PATH

export MDLOADER_CLI=/home/ahmed/bin/ctrl/qmk_firmware/mdloader_linux
export PROTOC=/home/ahmed/protobuf/bin/protoc
export GOPATH=/home/ahmed/bin/go
export GUIX_LOCPATH=/home/ahmed/.guix-profile/lib/locale

export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

alias sh="bash"
. "$HOME/.cargo/env"
