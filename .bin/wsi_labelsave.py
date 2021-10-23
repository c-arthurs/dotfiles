#!/usr/bin/env python
# this script exports the labels of svs files and saves them into a 'wsi_label_export' folder
# you call the file with the target path as the first argument
# unfortunately it was not possible as openslide does not detect the label image
# in ndpi files. there is a git issue for this - https://github.com/openslide/openslide/issues/219


from os.path import join, splitext, exists
from openslide import OpenSlide
import os
import glob
import pandas as pd
from tqdm import tqdm
import logging
import argparse


def get_label(path):
    """
    gets the label image of a wsi using openslide

    :param path str: path to the wsi
    returns pil image of label or 1 for fail
    """
    try:
        image = OpenSlide(path)  # open svs image
        return image.associated_images["label"]
    except KeyError as e:
        return 1


def export_labels(root):
    """
    exports the labels of any svs files in any subfolders of the root directory

    :param root str: the path to the directory containing the svs WSI
    """
    if not exists(join(root, "wsi_label_export")):
        os.mkdir(join(root, "wsi_label_export"))
    names = []
    for path, subdirs, files in os.walk(root):  # get all svs files
        for name in files:
            if name.endswith(".svs") and not (name[0] == "0"):
                names.append(name)
    logger.info(f"Following file WSI labels will be saved - {str(names)}")
    # iterate files and export labels to target directory
    for file in tqdm(names):
        label = get_label(join(root, file))
        if label == 1:
            logger.error(f"{file} has no label")
            continue
        label.save(join(root, "wsi_label_export", splitext(file)[0]) + ".png")


def logging_setup():
    logging.basicConfig(
        level=logging.INFO,
        handlers=[
            logging.FileHandler(
                join(str(args.path), "wsi_label_export", "label_export_log.log"),
                mode="w",
            ),
            logging.StreamHandler(),
        ],
        format="%(asctime)s %(levelname)s %(name)s %(message)s",
    )
    logger = logging.getLogger(__name__)

    return logger


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Takes all of the WSI in dir and saves the labels"
    )
    parser.add_argument(
        "path", type=str, help="The path to the folder containing all svs files"
    )
    args = parser.parse_args()
    # create destination if not there
    if not exists(join(str(args.path), "wsi_label_export")):
        os.mkdir(join(str(args.path), "wsi_label_export"))
    logger = logging_setup()

    export_labels(str(args.path))
