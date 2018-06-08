#!/usr/bin/bash

SYS=`uname -o`
if [[ "Cygwin" == "$SYS" ]]; then
    mount -c /
    alias src="cd /e/zmy/analyseServer/analyseServer/analyseServer/"
    alias we="cd /e/zmy/workspace"
    alias wiki="cd /e/zmy/wiki"
    export CYGWIN=nodosfilewarning
    if [[ -f /d/msys64/usr/share/git/completion/git-prompt.sh ]]; then
        . /d/msys64/usr/share/git/completion/git-prompt.sh
    fi
elif [[ "Msys" == "$SYS" ]]; then
    alias src="cd /d/workspace/analyseServer/analyseServer/analyseServer/"
    alias we="cd /d/workspace"
    alias wiki="cd /e/zmy/publish/wiki"
    alias apm="/c/Users/sh/AppData/Local/atom/bin/apm"
    export MSYS="winsymlinks:lnk"
    if [[ `uname -s|sed 's#-.*##'` == "MINGW64_NT" ]] ; then
        #   gitscript="/e/zmy/workspace/git/git-scripts"
        #   export PATH=/mingw64:$gitscript:$PATH
        export PATH=/mingw64:/d/Tools/SysinternalsSuite/:/d/Program\ Files\ \(x86\)/Conan/conan:/c/Program\ Files\ \(x86\)/Calibre2:/d/Program\ Files\ \(x86\)/Graphviz2.38/bin:$PATH
    fi
    if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
        . /usr/share/git/completion/git-prompt.sh
    fi
    if [[ -f /e/zmy/workspace/git/git-flow-completion/git-flow-completion.bash ]]; then
        . /e/zmy/workspace/git/git-flow-completion/git-flow-completion.bash
    fi
    export CPATH=/e/zmy/workspace/git/vcpkg/installed/x64-windows/include
    export LD_LIBRARY_PATH=/e/zmy/workspace/git/vcpkg/installed/x64-windows/lib
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

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias curl='curl -s'
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
shopt -s nocaseglob # 补全不区分大小写


#   export TMUX_TMPDIR=~/.tmux
#	export BOOST_DLL="/cygdrive/e/workspace/boost_1_55_0/stage/lib"
#   export EBOOK_DIR="/d/tools/go"
#   export PATH=$PATH:$EBOOK_DIR
#	export PATH=$PATH:$BOOST_DLL

# check the hash before searching the PATH directories
# open file faster
# eliminate long Window$ pathnames from the PATH
#   export PATH='/usr/bin:/usr/local/bin':$PATH
# check the hash before searching the PATH directories
shopt -s checkhash
# do not search the path when .-sourcing a file
shopt -u sourcepath


#  # lua & luarocks path settings
#  LUA_LLIB_DIR=/usr/local/share/lua/5.1
#  LUA_CLIB_DIR=/usr/local/lib/lua/5.1
#  export LUA_PATH="./?.lua;$LUA_LLIB_DIR/?.lua;$LUA_LLIB_DIR/?/init.lua"
#  export LUA_CPATH="./?.so;$LUA_CLIB_DIR/?.so;$LUA_CLIB_DIR/?/?.so;./?.dll;$LUA_CLIB_DIR/?.dll;$LUA_CLIB_DIR/?/?.dll"


# git completion & PS1 branch echo
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
# source /etc/bash_completion.d/git
SYS_NAME=`uname -s|sed 's#_.*##g;s#[A-Z]#\l&#g'`
PS1='\[\e]0;\w\a\]\[\033[01;32m\]\u@\h\[\033[01;31m\][$SYS_NAME]\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;35m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

## goagent proxy
#   export http_proxy="http://192.168.9.195:808"
#   export https_proxy="http://192.168.9.195:808"

#   export TERM=xterm-color
#   export LC_ALL='C'
#   export LANG=zh_CN.UTF-8
#   export STARDICT_DATA_DIR='/usr/share/stardict/dic'
#   export SDCV_HISTSIZE=1000
#   export LOCATE_PATH=/var/locatedb
#   export PS1

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
