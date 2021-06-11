# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi


if [[ $platform == 'linux' ]]; then
	# If not running interactively, don't do anything
	case $- in
	    *i*) ;;
	      *) return;;
	esac

	# don't put duplicate lines or lines starting with space in the history.
	# See bash(1) for more options
	HISTCONTROL=ignoreboth

	# append to the history file, don't overwrite it
	shopt -s histappend

	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	HISTSIZE=1000
	HISTFILESIZE=2000

	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# If set, the pattern "**" used in a pathname expansion context will
	# match all files and zero or more directories and subdirectories.
	#shopt -s globstar

	# make less more friendly for non-text input files, see lesspipe(1)
	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    debian_chroot=$(cat /etc/debian_chroot)
	fi

	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
	    xterm-color|*-256color) color_prompt=yes;;
	esac

	# uncomment for a colored prompt, if the terminal has the capability; turned
	# off by default to not distract the user: the focus in a terminal window
	# should be on the output of commands, not on the prompt
	#force_color_prompt=yes

	if [ -n "$force_color_prompt" ]; then
	    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	    else
		color_prompt=
	    fi
	fi

	if [ "$color_prompt" = yes ]; then
	    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	else
	    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
	unset color_prompt force_color_prompt

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
	xterm*|rxvt*)
	    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	    ;;
	*)
	    ;;
	esac

	# enable color support of ls and also add handy aliases
	if [ -x /usr/bin/dircolors ]; then
	    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	    alias ls='ls --color=auto'
	    #alias dir='dir --color=auto'
	    #alias vdir='vdir --color=auto'

	    alias grep='grep --color=auto'
	    alias fgrep='fgrep --color=auto'
	    alias egrep='egrep --color=auto'
	fi

	# colored GCC warnings and errors
	#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

	# Add an "alert" alias for long running commands.  Use like so:
	#   sleep 10; alert
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

	# Alias definitions.
	# You may want to put all your additions into a separate file like
	# ~/.bash_aliases, instead of adding them here directly.
	# See /usr/share/doc/bash-doc/examples in the bash-doc package.

	if [ -f ~/.bash_aliases ]; then
	    . ~/.bash_aliases
	fi

	# enable programmable completion features (you don't need to enable
	# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
	# sources /etc/bash.bashrc).
	if ! shopt -oq posix; then
	  if [ -f /usr/share/bash-completion/bash_completion ]; then
	    . /usr/share/bash-completion/bash_completion
	  elif [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
	  fi
	fi
fi

if [[ $HOSTNAME  == "dudley.doc.ic.ac.uk" ]];
then 
	. /data/callum/CACONFIG/miniconda3/etc/profile.d/conda.sh
	alias core="conda deactivate && conda activate pytorchenv"
	alias backup="rclone sync -P --skip-links --exclude .git/ --exclude miniconda3/ --delete-excluded /data1/callum/ box:/DUDLEY_SERVER_BACKUP/"
	alias cdh="cd /data1/callum/"
	alias notebook="jupyter notebook --no-browser --port=8889" # remote jupyter server
	alias notify="echo \"Action Finished\" | mail -s \"script finished on DUDLEY\" -- C.ARTHURS@IMPERIAL.AC.UK"


elif [[ $HOSTNAME  == "armada.doc.ic.ac.uk" ]] || [[ $HOSTNAME  == "fleet.doc.ic.ac.uk" ]];
then 
	. /data/callum/CACONFIG/miniconda3/etc/profile.d/conda.sh
	alias core="conda deactivate && conda activate pytorchenv"
	# alias backup="rclone sync -P --skip-links --exclude .git/ --exclude miniconda3/ --delete-excluded /data/callum/DATA box:/DUDLEY_SERVER_BACKUP/DATA"
	alias backupdata="rclone sync -P --skip-links --filter-from filter-list.txt /data/callum/DATA_Digi_Path box:/SERVER_BACKUPS/DATA_Digi_Path"
	alias backuphome="rclone sync -P --skip-links --filter-from filter-list.txt /data/callum/ box:/SERVER_BACKUPS/SCRIPTS/"
	alias cdh="cd /data/callum/"
	alias notebook="jupyter notebook --no-browser --port=8889" # remote jupyter server
	alias notify="echo \"Action Finished\" | mail -s \"script finished on ARMADA\" -- C.ARTHURS@IMPERIAL.AC.UK"
	alias backup="backupdata && backuphome && notify"

elif [[ $HOSTNAME  == "lynch-server1" ]];
then 
	alias core="conda deactivate && conda activate core"
	alias backup="rclone copy /hdd1/Callum/asini_deep/ProstSeg kclonedrive:/Lynch_server_backup/ProstSeg -P --filter-from /hdd1/Callum/dotfiles/filter-list.txt "
	alias cdh="cd /hdd1/Callum/"
	alias notebook="jupyter notebook --no-browser --port=8889" # remote jupyter server
fi
if [[ $platform == 'osx' ]];
then
	. /Users/callum/miniconda3/etc/profile.d/conda.sh
	alias cdh="cd ~/callum/"
	alias core="conda deactivate && conda activate core"
	alias magbook="ssh -N -f -L localhost:8889:localhost:8889 magnus" # remote jupyter server
	alias kainzbookf="ssh -N -f -L localhost:8889:localhost:8889 kainzf" # remote jupyter server
	alias kainzbooka="ssh -N -f -L localhost:8889:localhost:8889 kainza" # remote jupyter server
	alias notebook="jupyter notebook" # Jupyter 
	alias motivate="echo \"FINISH THESIS - dont be lazy\" && afplay \"/Users/callum/callum/dotfiles/goggins_work.mp3\"" 

	alias killweb="echo \"FINISH THESIS FIRST, THEN REST\" && afplay \"/Users/callum/callum/dotfiles/goggins_work.mp3\" && killall Safari && sudo vim /etc/hosts && sudo dscacheutil -flushcache"
fi

alias ll='ls -alFh'
alias la='ls -Alh'
alias l='ls -CF'
alias lsd="ls -dh */"
alias gh='history|grep' # get history
alias count='find . -type f | wc -l' # count all files in current dir
alias tmux="TERM=screen-256color-bce tmux" # added by callum to sort tmux
alias open='xdg-open'
alias smi="watch nvidia-smi"
alias removedirs="rm -Rf -- */"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias tensorboard="tensorboard --logdir=runs --max_reload_threads 4"
alias thumbnails="mkdir thumbnails; sips -Z 300 *.* --out thumbnails"
alias deact="conda deactivate"

# echo "██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗    ██╗  ██╗ █████╗ ██████╗ ██████╗ ███████╗██████╗ ";
# echo "██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝    ██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗";
# echo "██║ █╗ ██║██║   ██║██████╔╝█████╔╝     ███████║███████║██████╔╝██║  ██║█████╗  ██████╔╝";
# echo "██║███╗██║██║   ██║██╔══██╗██╔═██╗     ██╔══██║██╔══██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗";
# echo "╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗    ██║  ██║██║  ██║██║  ██║██████╔╝███████╗██║  ██║";
# echo " ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝";
# echo "                                                                                       ";

# Taskwarrior
alias t='task'
alias tsh='tasksh'
alias tt='task next limit:10'
alias ta='task add'
alias tpr='task projects'
alias tp_='task _projects'
function tp() { task "proj:$1"; } 
alias tdd='task +OVERDUE list' # Show all tasks that are overdue.
alias tan='task add +next'
alias tak='task add project:KCL'
alias tat='task add project:KCL.Thesis'
alias tah='task add project:Hammersmith'
alias tag='task add project:GOSH'

wait_for_pid () {
	check=$(ps --no-headers -p "$1" | wc -l)
	while [[ $check -ne 0 ]]
	do
		sleep 6
		check=$(ps --no-headers -p "$1" | wc -l)
	done
	echo "previous finished, running script"
	notify
}

PATH=$PATH:$HOME/.bin
conda activate
