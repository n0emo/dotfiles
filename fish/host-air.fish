set -x FLYCTL_INSTALL $HOME/.fly
set -x VCPKG_ROOT $HOME/Software/vcpkg

set -U fish_user_paths \
    /opt/homebrew/bin \
    $HOME/.juliaup/bin \
    $FLYCTL_INSTALL/bin \
    $VCPKG_ROOT \
    $fish_user_paths

source "$HOME/.cargo/env.fish"

