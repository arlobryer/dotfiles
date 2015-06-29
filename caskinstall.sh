#!/bin/sh

brew udpate
brew tap caskroom/cask
brew install caskroom/cask/brew-cask

brew cask install flashlight
brew cask install hipchat
brew cask install iterm2
brew cask install evernote
brew cask install flux
brew cask install amethyst
brew cask install dropbox
brew cask install spotify
brew cask install chrome
brew cask install skype
brew cask install vlc
brew cask install itsycal
brew cask install steam

brew cask cleanup

#Some brew native things too
brew install git git-flow tig
brew install vim
brew install aspell
brew install gfortran
brew install ghc
brew install macvim
brew install wget
brew install watch
brew install ruby
brew install scons
brew install nmap
brew install sqlite
brew install wireshark
brew install dos2unix
brew install python python3 python26
