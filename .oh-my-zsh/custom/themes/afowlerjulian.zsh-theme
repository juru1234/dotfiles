[ -n "$SSH_TTY" ] && PROMPT='%{$fg[yellow]%}%m %B%F{cyan}%b%F{cyan}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{green}.%F{green})
%(?:%{$fg_bold[green]%}%1{❯%} :%{$fg_bold[red]%}%1{❯%} )'
[ -z "$SSH_TTY" ] && PROMPT='%B%F{cyan}%b%F{cyan}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{green}.%F{green})
%(?:%{$fg_bold[green]%}%1{❯%} :%{$fg_bold[red]%}%1{❯%} )'

#RPS1='%(?..%F{red}%? ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
#ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""
