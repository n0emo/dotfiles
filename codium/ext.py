import sys
import subprocess
import os
import json
from dataclasses import dataclass


@dataclass
class Store:
    extensions: list[str]


def main():
    if len(sys.argv) == 1:
        print_help()
        exit(64)

    match sys.argv[1:]:
        case ["sync"]:
            cmd_sync()

        case _:
            print_help()
            exit(64)


def cmd_sync():
    installed = set(
        subprocess.run(
            ["codium", "--list-extensions"], capture_output=True, check=True, text=True
        ).stdout.splitlines()
    )

    store = read_store()
    stored = set(store.extensions)

    for ext in installed.difference(stored):
        store.extensions.append(ext)

    to_install = list(stored.difference(installed))
    if len(to_install) > 0:
        subprocess.run(
            ["codium"] + [f"--install-extension={e}" for e in to_install],
            check=True,
            text=True,
        )
    store.extensions = sorted(set(store.extensions))
    write_store(store)


def print_help():
    print(f"Usage: python3 {sys.argv[0]} <command>")
    print()
    print("Available commands:")
    print("  sync - syncronize extensions between dotfiles and codium")


def read_store():
    path = get_store_path()
    if not os.path.exists(path):
        return Store(extensions=[])

    with open(get_store_path(), "r") as f:
        j = json.load(f)
        return Store(extensions=j["extensions"])


def write_store(store):
    with open(get_store_path(), "w") as f:
        j = {"extensions": store.extensions}
        json.dump(j, f, indent=2)


def get_store_path():
    if sys.platform in ["linux", "darwin"]:
        return os.path.expanduser("~/dotfiles/codium/extensions.json")
    else:
        raise NotImplementedError()


if __name__ == "__main__":
    main()
