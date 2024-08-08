[ -n "$SSH_TTY" ] && PROMPT='%{$fg[red]%}%m %B%F{cyan}%b%F{cyan}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{green}.%F{green})
❯%f%b '
[ -z "$SSH_TTY" ] && PROMPT='%B%F{cyan}%b%F{cyan}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{green}.%F{green})
❯%f%b '
#RPS1='%(?..%F{red}%? ↵%f)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
#ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""
