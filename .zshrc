### INSTALL DEPENDENCIES ###############################
antidote_dir=~/.antidote
if [ ! -d $antidote_dir ]; then
    echo "Installing antidote"
    git clone --quiet --depth 1 https://github.com/mattmc3/antidote.git ~/.antidote
fi

fzf_dir=~/.fzf
if [ ! -d $fzf_dir ]; then
    echo "Installing junegunn fzf integration"
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

########################################################
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
SAVEHIST=1000000000
HISTFILE=~/.zsh_history
setopt share_history

alias v="nvim"
alias vi="nvim"
alias ls="eza"
alias l="ls -al"
alias cd="z"
alias cat="bat"
alias lg="lazygit"

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gc="git commit"

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$GOBIN:$PATH

export EDITOR=nvim

# For sway Gnome keyring
# Must be part of system private config
# export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

typeset -g VI_MODE_SET_CURSOR=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"

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

source ~/.antidote/antidote.zsh
antidote load

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
