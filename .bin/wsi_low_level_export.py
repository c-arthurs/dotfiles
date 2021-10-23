#!/usr/bin/env python


# this is a script to take the overview image of every wsi in a directory and save it
from wsi_toolbox import wsi_low_level_export
import os
from os.path import split, join, splitext, exists
import argparse


if __name__ == "__main__":
    # Instantiate the parser
    parser = argparse.ArgumentParser(
        description="this is a script to take the overview image of every wsi in a directory and save it"
    )

    # Required positional argument
    parser.add_argument("path", type=str, help="The path to the file ending in a /")

    args = parser.parse_args()
    savedir = join(str(args.path), "low level export/")
    print(f"\n\tpath: {str(args.path)} \n\tsavepath: {savedir}\n")
    wsi_low_level_export.main(str(args.path), savedir)
