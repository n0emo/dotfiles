if status is-interactive; and type -q starship
    set -x STARSHIP_CONFIG $HOME/.config/starship/config.toml
    starship init fish | source
end
