#!/usr/bin/env fish

# Activate karn if installed
if command -sq karn
    # The normal init command is not compatible with fish, so we override it ourselves
    #eval (karn init)

    function git
        karn update
        command git {$argv}
    end
end 
