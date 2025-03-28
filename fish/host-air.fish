set -x FLYCTL_INSTALL $HOME/.fly
set -x VCPKG_ROOT $HOME/Software/vcpkg

set -U fish_user_paths \
    /opt/homebrew/bin \
    $HOME/.juliaup/bin \
    $FLYCTL_INSTALL/bin \
    $VCPKG_ROOT \
    /Applications/WezTerm.app/Contents/MacOS \
    $HOME/.local/bin \
    $fish_user_paths

alias clang++ "clang++ -std=gnu++11"

source "$HOME/.cargo/env.fish"

