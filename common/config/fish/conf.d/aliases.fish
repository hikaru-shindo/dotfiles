#!/usr/bin/env fish

alias c="clear"
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias curltime='curl -o /dev/null -s -w "    time_namelookup:  %{time_namelookup}s
    time_connect:  %{time_connect}s
    time_appconnect:  %{time_appconnect}s
    time_pretransfer:  %{time_pretransfer}s
    time_redirect:  %{time_redirect}s
    time_starttransfer:  %{time_starttransfer}s
    ----------
    time_total:  %{time_total}s\n"'