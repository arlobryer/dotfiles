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
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/texbin:/opt/local/bin

#ROOT options
export ROOTSYS=/opt/root
export NODE_PATH=/usr/local/lib/node_modules
#export PATH=/usr/bin/:$PATH
export EDITOR=nano
#CMSSW CVS repository
export CVSROOT=arlogb@cmscvs.cern.ch:/cvs_server/repositories/CMSSW
export CVS_RSH=ssh
#export ARCHFLAGS="-arch x86_64"
#Aliases
alias rm='rm -i'
alias aqua='aquamacs'
alias bc='bc -l'
alias preview='open -a Preview'
alias setroot='export PATH=$PATH:$ROOTSYS/bin; export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH; export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH'
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
