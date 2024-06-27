### INSTALL DEPENDENCIES ###############################
oh_my_zsh_dir=~/.oh-my-zsh
if [ ! -d $oh_my_zsh_dir ]; then
    echo "Installing ohmyzsh"
    git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

fzf_dir=~/.fzf
if [ ! -d $fzf_dir ]; then
    echo "Installing junegunn fzf integration"
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi


# Function to install a oh-my-zhs plugin if it doesn't exist
omz_install_resource() {
  local resource_type="$1"
  local resource_name="$2"
  local resource_url="$3"
  local oh_my_zsh_resource_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/$resource_type/$resource_name
  
  # Check if the plugin already exists
  if [ ! -d "$oh_my_zsh_resource_dir" ]; then
    echo "Installing $resource_name of type $resource_type in path: $oh_my_zsh_resource_dir"
    git clone --quiet --depth 1 "$resource_url" "$oh_my_zsh_resource_dir"
  fi
}
########################################################

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


omz_install_resource "plugins" "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
omz_install_resource "plugins" "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
omz_install_resource "plugins" "fzf" "https://github.com/junegunn/fzf"

plugins=(vi-mode colored-man-pages zoxide zsh-autosuggestions zsh-syntax-highlighting)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
typeset -g VI_MODE_SET_CURSOR=true

source $HOME/.oh-my-zsh/oh-my-zsh.sh
# fzf integration mus be sourced after ohmyzsh
source <(fzf --zsh)
eval "$(starship init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
