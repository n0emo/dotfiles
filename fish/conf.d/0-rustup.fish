set -x CARGO_HOME $HOME/.cargo

if test -e $CARGO_HOME/env.fish
    source $CARGO_HOME/env.fish
end
