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


source ~/.antidote/antidote.zsh
function zvm_config() {
   ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
   ZVM_VI_HIGHLIGHT_BACKGROUND=#83a598
}

antidote load

eval "$(starship init zsh)"
# fzf integration mus be sourced after antidote
source <(fzf --zsh)
eval "$(zoxide init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
