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
plugins=(pip git osx python brew pass history-substring-search history virtualenv virtualenvwrapper)

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/texlive/2013basic/bin/universal-darwin:~/.cabal/bin:$GEMS
source $ZSH/oh-my-zsh.sh
#this is for the venv wrappers
source /usr/local/bin/virtualenvwrapper.sh

export EDITOR=nano
export JAVA_HOME=$(/usr/libexec/java_home)
export GEMS=/usr/local/opt/ruby/bin
export GNUBIN=/usr/local/opt/coreutils/libexec/gnubin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
#Aliases
alias rm='rm -i'
alias bc='bc -l'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'
alias palandir='cd $PGPATH'
alias grep='grep -i'
alias ag='ag -i'
alias gitk="/usr/bin/wish $(which gitk)"

function set_title_tab {

    function settab   {

		    # file settab  -- invoked only if iTerm or Konsole is running

		    #  Set iterm window tab to current directory and penultimate directory if the
		    #  shell process is running.  Truncate to leave the rightmost $rlength characters.
		    #
		    #  Use with functions settitle (to set iterm title bar to current directory)
		    #  and chpwd


		if [[ $TERM_PROGRAM == iTerm.app && -z "$KONSOLE_DCOP_SESSION" ]];then

			# The $rlength variable prints only the 20 rightmost characters. Otherwise iTerm truncates
			# what appears in the tab from the left.


				# Chage the following to change the string that actually appears in the tab:

					tab_label="$PWD:h:t/$PWD:t"

					rlength="20"   # number of characters to appear before truncation from the left

		            echo -ne "\e]1;${(l:rlength:)tab_label}\a"


		else

				# For KDE konsole tabs

				# Chage the following to change the string that actually appears in the tab:

					tab_label="$PWD:h:t/$PWD:t"

					rlength="20"   # number of characters to appear before truncation from the left

		        # If we have a functioning KDE console, set the tab in the same way
		        if [[ -n "$KONSOLE_DCOP_SESSION" && ( -x $(which dcop)  )  ]];then
		                dcop "$KONSOLE_DCOP_SESSION" renameSession "${(l:rlength:)tab_label}"
		        else
		            : # do nothing if tabs don't exist
		        fi

		fi
	}

    function settitle   {
		# Function "settitle"  --  set the title of the iterm title bar. use with chpwd and settab

		# Change the following string to change what appears in the Title Bar label:


			title_lab=$HOST:r:r::$PWD
				# Prints the host name, two colons, absolute path for current directory

			# Change the title bar label dynamically:

			echo -ne "\e]2;[zsh]   $title_lab\a"
	}

	# Set tab and title bar dynamically using above-defined functions

		function title_tab_chpwd { settab ; settitle }

		# Now we need to run it:
	    title_tab_chpwd

	# Set tab or title bar label transiently to the currently running command

	if [[ "$TERM_PROGRAM" == "iTerm.app" ]];then
		function title_tab_preexec {  echo -ne "\e]1; $(history $HISTCMD | cut -b7- ) \a"  }
		function title_tab_precmd  { settab }
	else
		function title_tab_preexec {  echo -ne "\e]2; $(history $HISTCMD | cut -b7- ) \a"  }
		function title_tab_precmd  { settitle }
	fi


	typeset -ga preexec_functions
	preexec_functions+=title_tab_preexec

	typeset -ga precmd_functions
	precmd_functions+=title_tab_precmd

	typeset -ga chpwd_functions
	chpwd_functions+=title_tab_chpwd

}

####################

set_title_tab


function _exists()
{
  command -v $1 > /dev/null 2>&1
  echo "$(( !$? ))"
}

# Opens files in a single MacVim server.
# Picks the first server in serverlist if there are multiple servers
function OpenInMacVim {
    server=$(mvim --serverlist | head -1)
    if [ -n "$server" ]; then
        if [ -z "$1" ]; then
            osascript -e 'tell application "MacVim" to activate'
        else
            mvim --servername $server --remote $@
        fi
    else
        mvim $@
    fi
}

if [[ $(_exists mvim) -ne 0 ]]; then
    alias vi='OpenInMacVim'
    alias vim='OpenInMacVim'
fi
