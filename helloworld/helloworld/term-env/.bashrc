export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

export PATH=$JAVA_HOME/bin:$PATH

export PS1='\[\e[0;33m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;37m\]\$ \[\e[m\]\[\e[0;32m\]'

export CLICOLOR=1

export GREP_OPTIONS='--color=auto' 
export LS_COLORS='di=33:fi=32:ln=95:pi=5:*.so=35:*.sh=5:*.mk=36:or=32:mi=0:ex=31:*.rpm=90'

set clipboard=unnamed

#Use the history to search the previous command used
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

alias ll='ls -all --color=auto'
