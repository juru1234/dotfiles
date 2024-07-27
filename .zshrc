#!/bin/bash

[ ! -d ~/.oh-my-zsh ] && (echo "Installing oh my zsh"
	git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh)

[ ! -d ~/.fzf ] && (echo "Installing junegunn fzf integration"
	git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf)

DIR=~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
[ ! -d $DIR ] && (echo "Installing zsh autosuggestions"
	git clone --quiet --depth 1 https://github.com/zsh-users/zsh-autosuggestions "${DIR}")

DIR=~/.oh-my-zsh/custom/plugins/zsh-vi-mode
[ ! -d $DIR ] && (echo "Installing zsh vi mode"
	git clone --quiet --depth 1 https://github.com/jeffreytse/zsh-vi-mode "${DIR}")

DIR=~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
[ ! -d $DIR ] && (echo "Installing fast syntax highlighting"
	git clone --quiet --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${DIR}")

export EDITOR=nvim

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$GOBIN:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="afowler"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"

typeset -g VI_MODE_SET_CURSOR=true
function zvm_after_init() {
	source <(fzf --zsh)
}

function zvm_config() {
	ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
	ZVM_VI_HIGHLIGHT_BACKGROUND=#83a598
}

zvm_yank_no_cursor_move() {
	#copy of zvm_yank function without cursor move
	local ret=($(zvm_calc_selection $1))
	local bpos=${ret[1]} epos=${ret[2]} cpos=${ret[3]}
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}
	if [[ ${1:-$ZVM_MODE} == $ZVM_MODE_VISUAL_LINE ]]; then
		CUTBUFFER=${CUTBUFFER}$'\n'
	fi
}

zvm_osc52() {
	BUF64=$(echo -n "$CUTBUFFER" | base64)
	OSC52="'\e]52;c;${BUF64}\e\\'"
	echo -e -n "${OSC52}"
}

my_zvm_visual_yank() {
	zvm_yank_no_cursor_move
	zvm_osc52
	zvm_exit_visual_mode ${1:-true}
}

my_zvm_cmd_yank() {
	zvm_yank_no_cursor_move
	zvm_osc52
	zvm_highlight clear
}

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_cmd_yank
  zvm_define_widget my_zvm_visual_yank
  zvm_bindkey vicmd 'y' my_zvm_cmd_yank
  zvm_bindkey visual 'y' my_zvm_visual_yank
} 

#Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins+=(colored-man-pages)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-vi-mode)
plugins+=(fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
alias v="nvim"
alias vi="nvim"
alias l="ls -al"
alias cat="bat"
alias lg="lazygit"

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gc="git commit"

alias ls="eza"
eval "$(zoxide init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
