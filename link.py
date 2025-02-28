#!/bin/python3

import json
import os
from os.path import islink
import sys


def get_path(s):
    p = os.path.expanduser(s)
    return os.path.abspath(p)


def create_symlink(src, dst, is_dir):
    parent = os.path.dirname(dst)
    os.makedirs(parent, exist_ok = True)
    os.symlink(src, dst, is_dir)
    print(f"Created symlink: '{dst}' -> '{src}'")


def process_links(links):
    for link in links:
        if isinstance(link, list):
            src = link[0]
            dst = link[1]
            is_dir = link[2] if len(link) > 2 else False
        else:
            src = link["target"]
            dst = link["link"]
            is_dir = link["dir"]

        src = get_path(src)
        dst = get_path(dst)

        if '-f' in sys.argv:
            try:
                if os.path.islink(dst) and os.readlink(dst) == src:
                    print(f"Already exists: '{dst}' -> '{src}'")
                else:
                    if os.path.exists(dst):
                        print(f"Moved: '{dst}' to '{src}.bak'")
                        os.rename(dst, dst + ".bak")
                    create_symlink(src, dst, is_dir)
            except FileNotFoundError:
                create_symlink(src, dst, is_dir)
        else:
            try:
                create_symlink(src, dst, is_dir)
            except FileExistsError:
                print(f"Already exists: '{dst}'")


def main():
    try:
        with open("manifest.json") as f:
            manifest = json.load(f)

    except IOError:
        print("Error reading manifest. Make sure 'manifest.json' exists and available for reading.")
        exit(1)
    except json.decoder.JSONDecodeError as e:
        print(f"Error parsing manifest: {e}")
        exit(1)
    except KeyError as e:
        print(f"Error parsing manifest: missing key {e}")
        exit(1)

    tags = (manifest.get("tags") or []) + ["default"]
    sources = manifest.get("sources")
    if sources == None:
        print(f"No sources defined in the manifest.")
        exit(1)

    for s in sources:
        try:
            with open(s["file"]) as f:
                source = json.load(f)

            for tag in tags:
                if links := source.get(tag):
                    process_links(links)

        except IOError:
            print(f"Error reading source. Make sure '{s.file}' exists and available for reading.")
            exit(1)
        except json.decoder.JSONDecodeError as e:
            print(f"Error parsing source: {e}")
            exit(1)
        except KeyError as e:
            print(f"Error parsing source: missing key {e}")
            exit(1)


if __name__ == '__main__':
    main()
