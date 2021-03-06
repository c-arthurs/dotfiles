path+=$HOME/.bin

# this changes the colour of my prompy 
autoload -U colors && colors
PS1="%{$fg[blue]%}%n@%{$reset_color%}%{$fg[blue]%}%m %{$fg[green]%}%~ %{$reset_color%}%% "

source ~/.bashrc

alias ls='ls -G' # set colour output for ls # set colour output for ls # set colour output for ls 

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/callum/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/callum/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/callum/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/callum/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

