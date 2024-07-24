omz_dir=~/.oh-my-zsh
if [ ! -d $omz_dir ]; then
    echo "Installing oh my zsh"
    git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

fzf_dir=~/.fzf
if [ ! -d $fzf_dir ]; then
    echo "Installing junegunn fzf integration"
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

as_dir=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
if [ ! -d $as_dir ]; then
    echo "Installing zsh autosuggestions"
    git clone --quiet --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

vi_mode=~/.oh-my-zsh/custom/plugins/zsh-vi-mode
if [ ! -d $vi_mode ]; then
    echo "Installing zsh vi mode"
    git clone --quiet --depth 1 https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
fi

fsh=~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
if [ ! -d $fsh ]; then
    echo "Installing fast syntax highlighting"
    git clone --quiet --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
fi
#
#
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$GOBIN:$PATH

export EDITOR=nvim
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="afowler"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
typeset -g VI_MODE_SET_CURSOR=true
function zvm_after_init() {
	source <(fzf --zsh)
}

function zvm_config() {
	ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
	ZVM_VI_HIGHLIGHT_BACKGROUND=#83a598
}

my_zvm_vi_yank() {
	zvm_yank
	BUF64=$(echo -n "$CUTBUFFER" | base64)
	OSC52="'\e]52;c;${BUF64}\e\\'"
	echo -e -n ${OSC52}
	zvm_exit_visual_mode ${1:-true}
}

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_vi_yank
  zvm_bindkey visual 'y' my_zvm_vi_yank
} 
#Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins+=(colored-man-pages)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-vi-mode)
plugins+=(fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

source <(fzf --zsh)
eval "$(zoxide init zsh)"

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

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
