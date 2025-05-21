#!/bin/bash

[ ! -f ~/.oh-my-zsh/README.md ] && echo "Installing oh my zsh" &&
    mkdir $HOME/temp_omz &&
	git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/temp_omz &&
    cp -r $HOME/temp_omz/* $HOME/.oh-my-zsh/ &&
    rm -rf $HOME/temp_omz

[ ! -d ~/.fzf ] && echo "Installing junegunn fzf integration" &&
	git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

[ ! -d ~/.fzf/fzftab ] && echo "Installing fzf tab" &&
	git clone --quiet --depth 1 https://github.com/Aloxaf/fzf-tab ~/.fzf/fzftab

DIR=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
[ ! -d $DIR ] && echo "Installing zsh autosuggestions" &&
	git clone --quiet --depth 1 https://github.com/zsh-users/zsh-autosuggestions "${DIR}"

DIR=~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
[ ! -d $DIR ] && echo "Installing fast syntax highlighting" &&
	git clone --quiet --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${DIR}"

export EDITOR=nvim

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$GOBIN:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# shellcheck disable=SC2034
# p>GggG
ZSH_THEME="afowlerjulian"

# shellcheck disable=SC2034
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"

# fzf-tab
autoload -U compinit; compinit
source ~/.fzf/fzftab/fzf-tab.plugin.zsh

# zsh-syntax-highlighting causes slow start
# shellcheck disable=SC2034
plugins=(colored-man-pages zsh-autosuggestions fast-syntax-highlighting tmux git zoxide eza fzf)
# shellcheck disable=SC1091

# Automatically update without prompt
DISABLE_UPDATE_PROMPT=true
source "$ZSH"/oh-my-zsh.sh


# Setup VI mode
bindkey -v

# Different Cursors in different modes
export KEYTIMEOUT=1
function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
[[ $1 = 'block' ]]; then
echo -ne '\e[1 q'
elif [[ ${KEYMAP} == main ]] ||
[[ ${KEYMAP} == viins ]] ||
[[ ${KEYMAP} = '' ]] ||
[[ $1 = 'beam' ]]; then
echo -ne '\e[5 q'
fi
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Setup OSC52 yank
yank-osc52-buf() {
echo "$BUFFER" | ${COPY_CMD} >/dev/null 2>&1
printf "\033]52;c;%s\a" "$(printf %s "$BUFFER" | head -c 8388608 | base64 -w 0)"
}

yank-osc52-cutbuf() {
echo "$CUTBUFFER" | ${COPY_CMD} >/dev/null 2>&1
printf "\033]52;c;%s\a" "$(printf %s "$CUTBUFFER" | head -c 8388608 | base64 -w 0)"
}

zle -N yank-osc52-buf
bindkey -M vicmd 'y' yank-osc52-buf

vi-yank-osc52() { zle vi-yank; yank-osc52-cutbuf; }
zle -N vi-yank-osc52
bindkey -M visual 'y' vi-yank-osc52


# User configuration
alias v="nvim"
alias vi="nvim"
alias l="ls -al"
alias lg="lazygit"

#alias ls="eza"

alias s="ssh"

# This fixes SSH agent forwarding togehter with
# $HOME/.ssh/config
STABLE_SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
if [ ! -S "${STABLE_SSH_AUTH_SOCK}" ] && [ -S "${SSH_AUTH_SOCK-}" ]; then
  ln -sf -- "$SSH_AUTH_SOCK" "${STABLE_SSH_AUTH_SOCK}"
fi

# shellcheck disable=SC1090
FILE=~/.zshrc_system_specific
if [ -f "$FILE" ]; then
  source "$FILE"
fi
