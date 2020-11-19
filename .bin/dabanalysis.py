#!/usr/bin/env python

from dab.dab_analysis import main
import sys

path = sys.argv[1]
value = sys.argv[2]
print(f"analysing {path} with threshold {value}")
main(path, value, segmented_image=False)
