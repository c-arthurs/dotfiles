# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

PATH=/data/callum/CACONFIG//miniconda3/bin:$PATH
export PATH=/data/callum/CACONFIG//vim_latest/bin:$PATH
export PATH=/data/callum/CACONFIG//nodejs/bin:$PATH
