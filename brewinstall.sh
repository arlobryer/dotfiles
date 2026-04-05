#!/bin/sh

brew update

# Casks
brew install --cask iterm2 spotify visual-studio-code claude-code meetingbar rectangle

# Shell tools
brew install zsh git tig vim wget watch

# Modern CLI replacements
brew install ripgrep   # better grep (replaces ag)
brew install bat       # better cat
brew install eza       # better ls
brew install fd        # better find
brew install fzf       # fuzzy finder
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Dev tools
brew install python
brew install gh        # GitHub CLI
brew install jq        # JSON processor

# Shell enhancements
brew install atuin     # shell history (searchable, synced)
brew install zoxide    # smart cd

# LLM in the shell
brew install llm

brew cleanup
