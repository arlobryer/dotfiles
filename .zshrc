# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme — see arlogb.zsh-theme
ZSH_THEME="arlogb"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python from Homebrew
export PATH="$(brew --prefix python)/libexec/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

source $ZSH/oh-my-zsh.sh

export EDITOR=vim

# Aliases
alias rm='rm -i'
alias bc='bc -l'
alias ll='eza --long --git'
alias la='eza --long --all --git'
alias lt='eza --tree --level=2'
alias cat='bat --paging=never'

# fzf (key bindings + completions)
eval "$(fzf --zsh)"

# Atuin (shell history)
eval "$(atuin init zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"
