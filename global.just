home := env('HOME')

[private]
list:
    just --list

migrate-directories out: \
    (migrate-single-directory "Pictures" out) \
    (migrate-single-directory "Music" out) \
    (migrate-single-directory "Downloads" out) \
    (migrate-single-directory "Code" out) \
    (migrate-single-directory "Videos" out) \
    (migrate-single-directory "Faugus" out)

migrate-single-directory dir out:
    #!/usr/bin/env bash
    set -euxo pipefail

    test -L {{ home / dir }} && exit 0
    mkdir -pv {{ home / dir }}
    mkdir -pv {{ out / dir }}
    cp -rv --no-preserve=mode,ownership {{ home / dir / "." }} {{ out / dir }}
    rm -rfv {{ home / dir }}
    ln -sv {{ out / dir }} {{ home / dir}}
