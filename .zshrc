# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="arlogb"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx python brew)

source $ZSH/oh-my-zsh.sh
#this is for the venv wrappers
source /usr/local/bin/virtualenvwrapper.sh
# Customize to your needs...

export EDITOR=macvim
#This is for java env in Palantir. 
export PALANTIR_JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export PGPATH=/usr/local/Cellar/palantir-gotham-39/3.9.1
export QSPATH=$PGPATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/texlive/2012basic/bin/universal-darwin:~/.cabal/bin/
#Aliases
alias rm='rm -i'
alias aqua='aquamacs'
alias bc='bc -l'
alias preview='open -a Preview'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'
alias palandir='cd /usr/local/Cellar/palantir-gotham-39/3.9.1'
alias mongostart="mongod -f /usr/local/Cellar/mongodb/1.8.2-x86_64/mongod.conf"
alias mongostop="mongostop_func"


mongostop_func () {

#  local mongopid=`ps -o pid,command -ax | grep mongod | awk '!/awk/ && !/grep/{print $1}'`;
#  just find a simpler way
    local mongopid=`less /usr/local/var/mongodb/mongod.lock`;
    if [[ $mongopid =~ [[:digit:]] ]]; then
        kill -15 $mongopid;
        echo mongod process $mongopid terminated;
    else
        echo mongo process $mongopid not exist;
    fi
}
