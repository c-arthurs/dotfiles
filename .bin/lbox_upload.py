#!/usr/bin/env python

# this is for making a correlation matrix from data in a sheet in excel
# for this to work the newest seaborn needs to be installed - core env has this 
# the excel that it points to needs the data all in the correlation matrix sheet
# the output is an eps file
# the name is the second arg 

import sys
from labelbox_toolbox import lbox_upload #pip install --upgrade git+ssh://git@github.com/c-arthurs/wsi_toolbox.git#egg=wsi_toolbox
import os
from os.path import split, join, splitext, exists
import argparse



if __name__ == "__main__":
    # Instantiate the parser
    parser = argparse.ArgumentParser(
            description='this is a script to take the overview image of every wsi in a directory and save it')

    # Required positional argument
    parser.add_argument('dataset_name', type=str, 
            help='what you want the dataset to be called on the lbox side')
    parser.add_argument('path', type=str, 
            help='The path to the file ending in a /')
    parser.add_argument('apikeypath', type=str, 
            help='The path to the labelbox api key')

    args = parser.parse_args()
    savedir = join(str(args.path), "low level export/")
    print(f"\n\tpath: {str(args.path)} \n\tsavepath: {savedir}\n")
    lbox_upload.upload_specific_file(dataset_name=str(args.dataset_name),
            file_path=str(args.path), apikeypath=str(args.apikeypath))

