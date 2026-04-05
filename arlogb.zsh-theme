#-*-sh-*-

PROMPT='%n% @%m%{$reset_color%}$(git_prompt_info)%{$fg_bold[green]%} ${PWD/#$HOME/~}%{$reset_color%}:'
RPROMPT='%{$fg_bold[black]%}%T % %w%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" git:%{$fg[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"