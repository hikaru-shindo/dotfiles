#!/bin/env fish

abbr --add -g gco -- git checkout
abbr --add -g gsw -- git switch
abbr --add -g gswc -- git switch --create
abbr --add -g ga -- git add
abbr --add -g gaa -- git add --all
abbr --add -g gapa -- git add --patch
abbr --add -g gc -- git commit -v
abbr --add -g gc! -- git commit -v --amend
abbr --add -g gca -- git commit -v --all
abbr --add -g gca! -- git commit -v --all --amend
abbr --add -g gcan! -- git commit -v --all --no-edit --amend
abbr --add -g gcans! -- git commit -v --all --signoff --no-edit --amend
abbr --add -g gcann! -- git commit -v --all --date=now --no-edit --amend
abbr --add -g gcs -- git commit --gpg-sign
abbr --add -g gcss -- git commit --gpg-sign --signoff
abbr --add -g gfa -- git fetch --all --prune
abbr --add -g gpr -- git pull --rebase
abbr --add -g gpra -- git pull --rebase --autostash
abbr --add -g gp -- git push
abbr --add -g gpf -- git push --force-with-lease --force-if-includes
abbr --add -g grb -- git rebase
abbr --add -g grba -- git rebase --abort
abbr --add -g grbc -- git rebase --continue
abbr --add -g grbi -- git rebase --interactive
abbr --add -g grbs -- git rebase --skip
abbr --add -g gss -- git status --short
abbr --add -g gsb -- git status --short --branch
abbr --add -g grh -- git reset
abbr --add -g grhh -- git reset --hard
