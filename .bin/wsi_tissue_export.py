#!/usr/bin/env python

# for exporting tiles automatically using the cnncore tma_lib library that can be installed as below
# usage:
#     wsi_tissue_export "/path/to/file/dir/with/ndpi" --imagesize 1000 --imageoverlap 20 --annotation_segment --prep_ml_dataset


from wsi_toolbox import (
    wsi_tissue_export,
)  # pip install --upgrade git+ssh://git@github.com/c-arthurs/wsi_toolbox.git#egg=wsi_toolbox
import sys
import argparse

if __name__ == "__main__":
    # Instantiate the parser
    parser = argparse.ArgumentParser(
        description="""for exporting tiles automatically using the cnncore tma_lib library that can be installed as
    below:
    wsi_tissue_export "/path/to/file/dir/with/ndpi" --imagesize 1000 
    --imageoverlap 20 --annotation_segment --prep_ml_dataset"""
    )

    # Required positional argument
    parser.add_argument(
        "path", type=str, help="The path to the folder of wsi ending in a /"
    )
    parser.add_argument(
        "--imagesize",
        type=int,
        default=1024,
        help="The size of the desired image patch",
    )
    parser.add_argument(
        "--imageoverlap", type=int, default=0, help="the amount tiles should overlap"
    )
    parser.add_argument(
        "--annotation_segment",
        action="store_true",
        help="whether to process and save annotation files from svs",
    )
    parser.add_argument(
        "--prep_ml_dataset",
        action="store_true",
        help="whether to save results to a single directory",
    )

    parser.add_argument(
        "--cover_percentage",
        type=float,
        default=0.9,
        help="the devimal (0.9) of each tile that should be covered in tissue for the segmentation",
    )

    args = parser.parse_args()
    choicenames = [
        "path",
        "imagesize",
        "imageoverlap",
        "annotation_segment",
        "prep_ml_dataset",
    ]
    results = [
        args.path,
        args.imagesize,
        args.imageoverlap,
        args.annotation_segment,
        args.prep_ml_dataset,
    ]
    [print(choicenames[i] + ": " + str(results[i])) for i in range(len(choicenames))]

    wsi_tissue_export.main(
        str(args.path),
        annotation_segment=bool(args.annotation_segment),
        prep_ml_dataset=bool(args.prep_ml_dataset),
        imagesize=int(args.imagesize),
        imageoverlap=int(args.imageoverlap),
        cover_percentage=float(args.cover_percentage),
    )
