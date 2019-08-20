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

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/texlive/2013basic/bin/universal-darwin:~/.cabal/bin:$GEMS
export PATH=/usr/local/opt/python/libexec/bin:$PATH
source $ZSH/oh-my-zsh.sh
#this is for the venv wrappers
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

export EDITOR=nano
export JAVA_HOME=$(/usr/libexec/java_home)
export GEMS=/usr/local/opt/ruby/bin
export GNUBIN=/usr/local/opt/coreutils/libexec/gnubin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
#Aliases
alias rm='rm -i'
alias bc='bc -l'
alias grep='grep -i'
alias ag='ag -i'
alias gf='git flow'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
