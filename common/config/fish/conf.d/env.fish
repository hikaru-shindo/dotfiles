#!/usr/bin/env fish

fish_add_path -ga /usr/local/sbin
fish_add_path -gp {$HOME}/bin

if test -x (command -v most)
    set -x -g PAGER most
end

if test -x (command -v nvim)
    set -x -g EDITOR nvim
    set -x -g VISUAL nvim
else if test -x (command -v vim)
    set -x -g EDITOR vim
    set -x -g VISUAL vim
end

if command -sq eza
    alias ls="eza --git --header --icons"
end
