set -U FLYCTL_INSTALL "/home/albert/.fly"

set -U fish_user_paths $HOME/.cargo/bin \
    $FLYCTL_INSTALL/bin \
    $fish_user_paths

source ~/.xmake/profile
