# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
typeset -g VI_MODE_SET_CURSOR=true

source ~/.antidote/antidote.zsh
antidote load

source ~/.config/zsh/colored_man_pages.zsh
# fzf integration mus be sourced after antidote
source <(fzf --zsh)
eval "$(zoxide init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
