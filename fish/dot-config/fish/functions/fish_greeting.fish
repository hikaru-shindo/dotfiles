function fish_greeting
    if command -sq fastfetch
        fastfetch --config greeting
    else
        uname -a
    end
end