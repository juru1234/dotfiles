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


# This block is moved to zsh-vi-mode.zsh
# read line </etc/os-release
# distro=${${${line#*=}#*\"}%\"*}
# if [ "$distro" = "openSUSE Tumbleweed" ]
# then
# 	source /usr/share/fzf/shell/key-bindings.zsh
# 	source /usr/share/fzf/shell/completion.zsh
# else
# 	source ~/.local/share/fzf/key-bindings.zsh
# 	source ~/.local/share/fzf/completion.zsh
# fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$HOME/.cargo/bin:$HOME/.local/bin:$GOBIN:$PATH
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export EDITOR=nvim
# For sway Gnome keyring
# Must be part of system private config
# export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

source $HOME/.config/zsh/colored_man_pages.zsh
source $HOME/.config/zsh/syntax_highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#if plugins dont work correctly, source them
#in zsh-vi-mode.zsh in my_init()
source $HOME/.config/zsh/zsh-vi-mode.plugin.zsh

FILE=~/.zshrc_system_specific && test -f $FILE && source $FILE
