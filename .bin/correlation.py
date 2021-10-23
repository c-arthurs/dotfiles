#!/usr/bin/env python

# this is for making a correlation matrix from data in a sheet in excel
# for this to work the newest seaborn needs to be installed - core env has this
# the excel that it points to needs the data all in the correlation matrix sheet
# the output is an eps file
# the name is the second arg

import sys
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib import rcParams

rcParams.update({"figure.autolayout": True})

path = sys.argv[1]
title = sys.argv[2]
sheet = "correlation matrix"
print(f"creating confusion matrix for {path}")

d = pd.read_excel(path, sheet_name=sheet)

sns.set_theme(style="white")

# Compute the correlation matrix
corr = d.corr()

# Generate a mask for the upper triangle
mask = np.triu(np.ones_like(corr, dtype=bool))

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(9, 9))

# Generate a custom diverging colormap
cmap = sns.diverging_palette(230, 20, as_cmap=True)

# Draw the heatmap with the mask and correct aspect ratio
sns.heatmap(
    corr,
    mask=mask,
    cmap=cmap,
    vmax=1,
    vmin=-1,
    center=0,
    square=True,
    linewidths=0.5,
    cbar_kws={"shrink": 0.6},
).set_title(title, fontsize=18)

plt.savefig(
    path[:-4] + "_correlation_matrix.pdf",
)
plt.close()
