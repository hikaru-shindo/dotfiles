#!/usr/bin/env fish

# Activate kubeswitch if it is present
if command -sq switcher
    switcher init fish | source

    function ks --wraps switcher
        kubeswitch $argv;
    end
end
