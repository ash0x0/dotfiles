# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin/activitywatch/:$PATH
export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# export LD_LIBRARY_PATH=/home/ahmed/TensorRT-7.0.0.11/lib/${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PYTHONPATH=/usr/lib/python3.6/dist-packages:$PYTHONPATH
source $HOME/vulkan/1.2.148.1/setup-env.sh
# export VULKAN_SDK=$HOME/vulkan/1.2.148.1/x86_64
# export PATH=$VULKAN_SDK/bin:$PATH
# export LD_LIBRARY_PATH=$VULKAN_SDK/lib:$LD_LIBRARY_PATH
# export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin/trex/:$PATH
export PATH=$HOME/android/sdk/platform-tools/:$PATH
export PATH=$HOME/bin/platform-tools/:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ahmed/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
# ZSH_THEME="agnosterzak"
# ZSH_THEME="kayid"
# ZSH_THEME="zsh2000/zsh2000"
# ZSH_THEME="bullet-train"
# ZSH_THEME="powerline"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages colorize command-not-found safe-paste web-search autojump jump passgen docker docker-compose poetry gitignore)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias upgrade="sudo apt update -y && sudo apt upgrade -y"
alias cave="cat ~/Documents/api | xclip -selection clipboard"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias list="colorls -lA --sd"
alias entropy="head /dev/urandom | tr -dc A-Za-z0-9 | head -c"
alias mlserver="xxh +I xxh-plugin-zsh-ohmyzsh && source xxh.zsh -o PreferredAuthentications=publickey -i .ssh/auc_rsa 'ahmeds@10.7.60.150' +q"
alias sh="bash"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export SAM_CLI_TELEMETRY=0
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /home/ahmed/.cargo/env
source /usr/share/autojump/autojump.zsh

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

# source ~/.oh-my-zsh/custom/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle unixorn/git-extra-commands
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# Fish autosuggestion bundle.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle 'wfxr/forgit'

# Load the theme.
# antigen theme robbyrussell
# antigen theme eendroroy/alien alien
antigen theme romkatv/powerlevel10k
# antigen theme bhilburn/powerlevel9k powerlevel9k

# Tell Antigen that you're done.
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete3 pipx)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ahmed/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ahmed/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ahmed/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ahmed/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/home/ahmed/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# added by travis gem
[ ! -s /home/ahmed/.travis/travis.sh ] || source /home/ahmed/.travis/travis.sh
