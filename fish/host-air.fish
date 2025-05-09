set -x FLYCTL_INSTALL $HOME/.fly
set -x VCPKG_ROOT $HOME/Software/vcpkg
set -x CARGO_HOME $HOME/.cargo

if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

if test -e $CARGO_HOME/env.fish
    source $CARGO_HOME/env.fish
end

set -U fish_user_paths \
    /opt/homebrew/bin \
    $HOME/.juliaup/bin \
    $FLYCTL_INSTALL/bin \
    $VCPKG_ROOT \
    /Applications/WezTerm.app/Contents/MacOS \
    $HOME/.local/bin \
    $fish_user_paths

alias clang++ "clang++ -std=gnu++11"

