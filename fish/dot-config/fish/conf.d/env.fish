#!/usr/bin/env fish

# allow vi mode
fish_hybrid_key_bindings

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

if command -sq fzf
    # Set colours to catppuccin mocha
    set -x -g FZF_DEFAULT_OPTS "\
        --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
        --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
        --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
        --color=selected-bg:#45475A \
        --color=border:#6C7086,label:#CDD6F4"
end

if command -sq eza
    alias ls="eza --git --header --icons"
end

if command -sq zoxide
    zoxide init fish | source
    alias cd="z"
end

if command -sq bat
    alias cat="bat --paging=never"
end
