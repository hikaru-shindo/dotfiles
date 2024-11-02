#!/usr/bin/env fish

# Setup homebrew environment if needed
if test -d /opt/homebrew
    eval "$(command /opt/homebrew/bin/brew shellenv)"

    # Move homebrew bin and sbin paths to the front as they might got appended
    fish_add_path -mp "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";

    # Setup special homebrew behaviour
    set -x -g HOMEBREW_NO_INSECURE_REDIRECT 1
    set -x -g HOMEBREW_CASK_OPTS "--require-sha"
    set -x -g HOMEBREW_NO_ANALYTICS 1
end
