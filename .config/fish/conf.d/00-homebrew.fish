#!/usr/bin/env fish

# Setup homebrew environment if needed
if test -x /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    set -x -g HOMEBREW_NO_INSECURE_REDIRECT 1
    set -x -g HOMEBREW_CASK_OPTS "--require-sha"
    set -x -g HOMEBREW_NO_ANALYTICS 1
end
