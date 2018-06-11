if [[ "Msys" == "$SYS_" ]]; then
    if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
        . /usr/share/git/completion/git-prompt.sh
    fi
    if [[ -f /e/zmy/workspace/git/git-flow-completion/git-flow-completion.bash ]]; then
        . /e/zmy/workspace/git/git-flow-completion/git-flow-completion.bash
    fi
    export PATH=/mingw64:/c/Program\ Files\ \(x86\)/Calibre2:/d/Program\ Files\ \(x86\)/Graphviz2.38/bin:$PATH
    export CPATH=/e/zmy/workspace/git/vcpkg/installed/x64-windows/include:$CPATH
    export LD_LIBRARY_PATH=/e/zmy/workspace/git/vcpkg/installed/x64-windows/lib:$LD_LIBRARY_PATH
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

stty stop ""
export HISTFILE=~/.bash_history
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=500000
export HISTSIZE=5000
export HISTIGNORE="&:[ ]*:exit"
shopt -s histappend
shopt -s cmdhist
shopt -s nocaseglob # 补全不区分大小写

# check the hash before searching the PATH directories
# open file faster
# eliminate long Window$ pathnames from the PATH
#   export PATH='/usr/bin:/usr/local/bin':$PATH
# check the hash before searching the PATH directories
shopt -s checkhash
# do not search the path when .-sourcing a file
shopt -u sourcepath

# source /etc/bash_completion.d/git
PS1='\[\e]0;\w\a\]\[\033[01;32m\]\u@\h\[\033[01;31m\]\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[01;35m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

export TERM=xterm-color
# export LC_ALL='C'
export LANG=zh_CN.UTF-8

