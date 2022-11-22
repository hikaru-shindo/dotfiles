export PATH="${HOME}/bin:/usr/local/sbin:${PATH}"

# Aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
if [ -x "$(command -v most)" ]; then
    export PAGER="most"
fi

if [ -x "$(command -v vim)" ]; then
    export EDITOR="vim"
    export VISUAL="vim"
fi
