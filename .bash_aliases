#!/usr/bin/bash

SYS=`uname|awk -F_ '{print $1}'`
if [[ "CYGWIN" == "$SYS" ]]; then
    alias we="cd /cygdrive/e/workspace"
    alias wiki="cd /cygdrive/e/workspace/git/wiki"
    export CYGWIN=nodosfilewarning
elif [[ "Linux" == "$SYS" ]];then
    alias we="cd /home/workspace"
fi

alias www="cd /srv/www/htdocs/wiki"
alias ~="cd ~"

# some more ls aliases
# alias ls='gnuls --color=auto --show-control-chars'
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -aF'
alias grep='grep --color'

alias ..='cd ..'
alias ...='cd ../..'

alias md='mkdir -p'
alias vd='vimdiff'
alias vi='vi -o'

FIGNORE=.dll
stty stop ""
export HISTFILE=~/.bash_history
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=500000
export HISTSIZE=5000
export HISTIGNORE="&:[ ]*:exit"
shopt -s histappend
shopt -s cmdhist

export GOROOT="/cygdrive/d/tools/go"
export BOOST_DLL="/cygdrive/e/workspace/boost_1_55_0/stage/lib"
export PATH=$PATH:$GOROOT/bin:$BOOST_DLL

# open file faster
# eliminate long Window$ pathnames from the PATH
export PATH='/bin:/usr/bin:/usr/local/bin':$PATH
# check the hash before searching the PATH directories
shopt -s checkhash
# do not search the path when .-sourcing a file
shopt -u sourcepath


# lua & luarocks path settings
LUA_LLIB_DIR=/usr/local/share/lua/5.1
LUA_CLIB_DIR=/usr/local/lib/lua/5.1
export LUA_PATH="./?.lua;$LUA_LLIB_DIR/?.lua;$LUA_LLIB_DIR/?/init.lua"
export LUA_CPATH="./?.so;$LUA_CLIB_DIR/?.so;$LUA_CLIB_DIR/?/?.so;./?.dll;$LUA_CLIB_DIR/?.dll;$LUA_CLIB_DIR/?/?.dll"


# git completion & PS1 branch echo
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
# source /etc/bash_completion.d/git
PS1='\[\e]0;\w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;35m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

## goagent proxy
#   export http_proxy="http://localhost:8087"
#   export https_proxy="http://localhost:8087"

export TERM=xterm-color
# export LC_ALL='C'
export LANG=zh_CN.UTF-8
export STARDICT_DATA_DIR='/usr/share/stardict/dic'
export SDCV_HISTSIZE=1000
export LOCATE_PATH=/var/locatedb
export PS1

# 快速启动emacs client
# alias er='emacsclient -s server -t -a ""'
# export EDITOR="er"

_optcomplete()
{
    COMPREPLY=( $( \
        COMP_LINE=$COMP_LINE  COMP_POINT=$COMP_POINT \
        COMP_WORDS="${COMP_WORDS[*]}"  COMP_CWORD=$COMP_CWORD \
        OPTPARSE_AUTO_COMPLETE=1 $1 ) )
}
