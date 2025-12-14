#!/usr/bin/env python3

from dataclasses import dataclass
from pathlib import Path

from PIL import Image, UnidentifiedImageError
import typer


class OutputAlreadyExistsError(Exception):
    def __init__(self, output):
        super().__init__(f"OUTPUT already exists ({output}), use --force to overwrite")


@dataclass
class AppContext:
    input: Path
    output: Path
    force: bool
    min_width: int | None
    min_height: int | None


def main(
    input: Path,
    output: Path,
    force: bool = False,
    min_width: int | None = None,
    min_height: int | None = None,
):
    try:
        ctx = AppContext(
            input=input,
            output=output,
            force=force,
            min_width=min_width,
            min_height=min_height,
        )

        process_images(ctx)

    except (NotADirectoryError, FileNotFoundError):
        print("ERORR: INPUT must be a directory")
        exit(1)

    except Exception as e:
        print("ERROR:", e)
        exit(1)


def process_images(ctx: AppContext):
    if not ctx.output.exists():
        ctx.output.mkdir()
    elif not ctx.force:
        raise OutputAlreadyExistsError(ctx.output)

    for p in ctx.input.iterdir():
        handle_image(ctx, p)


def handle_image(ctx: AppContext, path: Path):
    try:
        with Image.open(path) as image:
            width_ok = ctx.min_width is None or image.width >= ctx.min_width
            height_ok = ctx.min_width is None or image.width >= ctx.min_width
            if not width_ok or not height_ok:
                print(f"Skipping {path}: too small ({image.size=})")
                return

            image = image.convert("RGB")

            output = path.relative_to(ctx.input).with_suffix(".jpg")
            output = ctx.output.joinpath(output)
            image.save(output)

    except UnidentifiedImageError as e:
        print("WARN", e)
        return


if __name__ == "__main__":
    typer.run(main)
