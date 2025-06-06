set -U fish_user_paths $HOME/go/bin $fish_user_paths

if test -e $HOME/.config/fish/host.fish
    source $HOME/.config/fish/host.fish
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    if type -q zoxide
        zoxide init fish | source
        alias cd=z
    end

    if type -q eza
        alias ls="eza --icons --hyperlink --group-directories-first"
        alias la="ls --long"
    end

    alias rg="rg --hyperlink-format=kitty"

    if type -q nvim
        export EDITOR=nvim
    end

    if type -q zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
