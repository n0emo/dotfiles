if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting

    set -U fish_user_paths $HOME/go/bin $fish_user_paths

    if test -e $HOME/.config/fish/host.fish
        source $HOME/.config/fish/host.fish
    end
end
