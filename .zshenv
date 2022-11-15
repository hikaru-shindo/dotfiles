export PATH="${HOME}/bin:/usr/local/sbin:${PATH}"

export EDITOR="vim"
export VISUAL="vim"

if [[ -x "$(command -v most)"  ]]; then
    export PAGER="most"
else
    export PAGER="less"
fi

# Aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
