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
	local bpos=$ret[1] epos=$ret[2] cpos=$ret[3]
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}
	if [[ ${1:-$ZVM_MODE} == $ZVM_MODE_VISUAL_LINE ]]; then
		CUTBUFFER=${CUTBUFFER}$'\n'
	fi
}

my_zvm_visual_yank() {
	zvm_yank_no_cursor_move
	BUF64=$(echo -n "$CUTBUFFER" | base64)
	OSC52="'\e]52;c;${BUF64}\e\\'"
	echo -e -n ${OSC52}
	zvm_exit_visual_mode ${1:-true}
}

my_zvm_cmd_yank() {
	zvm_yank_no_cursor_move
	BUF64=$(echo -n "$CUTBUFFER" | base64)
	OSC52="'\e]52;c;${BUF64}\e\\'"
	echo -e -n ${OSC52}
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
alias cd="z"
alias cat="bat"
alias lg="lazygit"

alias g="git"
alias gs="git status"
alias gd="git diff"
alias gc="git commit"

source <(fzf --zsh)
alias ls="eza"
eval "$(zoxide init zsh)"

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
