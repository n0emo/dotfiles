if status is-interactive
    # Commands to run in interactive sessions can go here
	set -U fish_user_paths $HOME/.juliaup/bin $fish_user_paths
	alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
end
