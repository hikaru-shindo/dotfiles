# ZSH Theme - Preview: http://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based
prompt_symbols() {
    local symbols=()

    symbols+="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

    local jobs=$(jobs -l | wc -l)
    if [[ $jobs -gt 0 ]]; then
        symbols+="%{$fg_bold[magenta]%}⚙%{$reset_color%}"
    fi

    [ -n "$symbols" ] && echo -n "$symbols"
}

if [ "$(whoami)" = "root" ]; then
    PROMPT='%{$fg_bold[red]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(git_prompt_info)%{$reset_color%}'
else
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(git_prompt_info)%{$reset_color%}'
    else
        PROMPT='%{$fg_bold[blue]%}%2~%{$reset_color%} $(git_prompt_info)%{$reset_color%}'
    fi
fi

RPS1='$(prompt_symbols)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
