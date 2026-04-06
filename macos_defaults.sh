#!/bin/bash
# macos_defaults.sh — sensible macOS defaults
# Usage: ./macos_defaults.sh [--dry-run]
#
# Tested on macOS Tahoe (15.x). Some settings require a logout/restart.
# Opinionated — review before running on a new machine.

set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "Dry run mode — no changes will be made."
  echo ""
fi

run() {
  if $DRY_RUN; then
    echo "  $*"
  else
    "$@"
  fi
}

echo "Applying macOS defaults..."

###############################################################################
# General / Global                                                            #
###############################################################################

echo "  General..."

# Show all filename extensions in Finder
run defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expand save panel by default
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
run defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Full keyboard access for all controls (tab through dialogs etc)
run defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys (enable key repeat)
run defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable auto-correct
run defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart dashes and smart quotes (annoying in terminals/code)
run defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable "natural" scroll direction
run defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Quit printer app once print jobs complete
run defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Don't reopen windows on login
run defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Enable spring loading for directories
run defaults write NSGlobalDomain com.apple.springing.enabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

echo "  Finder..."

# Show hidden files
run defaults write com.apple.finder AppleShowAllFiles TRUE

# Show status bar and path bar
run defaults write com.apple.finder ShowStatusBar -bool true
run defaults write com.apple.finder ShowPathbar -bool true

# Use list view by default
run defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Search current folder by default
run defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable extension change warning
run defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Allow quitting Finder
run defaults write com.apple.finder QuitMenuItem -bool true

# Disable animations
run defaults write com.apple.finder DisableAllAnimations -bool true

# Show drives and media on desktop
run defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
run defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
run defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Avoid creating .DS_Store files on network and USB volumes
run defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
run defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

echo "  Dock..."

# Position on left
run defaults write com.apple.dock orientation "left"

# Icon size
run defaults write com.apple.dock tilesize -int 36

# Scale minimise effect
run defaults write com.apple.dock mineffect -string "scale"

# Minimise windows into app icon
run defaults write com.apple.dock minimize-to-application -bool true

# Show hidden app icons as translucent
run defaults write com.apple.dock showhidden -bool true

# Show process indicators
run defaults write com.apple.dock show-process-indicators -bool true

# Don't rearrange spaces based on most recent use
run defaults write com.apple.dock mru-spaces -bool false

# Remove autohide delay
run defaults write com.apple.dock autohide-delay -float 0
run defaults write com.apple.dock autohide-time-modifier -float 0

# Speed up Mission Control animation
run defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable launch animation
run defaults write com.apple.dock launchanim -bool false

# Enable spring loading for Dock items
run defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

###############################################################################
# Screen & Security                                                           #
###############################################################################

echo "  Screen & Security..."

# Save screenshots to Desktop as PNG
run defaults write com.apple.screencapture location -string "${HOME}/Desktop"
run defaults write com.apple.screencapture type -string "png"

# Disable screenshot shadow
run defaults write com.apple.screencapture disable-shadow -bool true

# Disable floating screenshot thumbnail
run defaults write com.apple.screencapture show-thumbnail -bool false

# Require password immediately after sleep/screensaver
run defaults write com.apple.screensaver askForPassword -int 1
run defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Trackpad                                                                    #
###############################################################################

echo "  Trackpad..."

# Tracking speed (0-3, default 1.5)
run defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

# Enable tap to click — covers both built-in (Apple Silicon) and Bluetooth trackpads
run defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
run defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
run defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
run defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Right-click (two-finger tap)
run defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
run defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Scrolling and gestures
run defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
run defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -bool true
run defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -bool true
run defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
run defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
run defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool true

# Three-finger swipe for app exposé / spaces (2 = three-finger swipe)
run defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
run defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2

# Four-finger swipe for Mission Control / spaces
run defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
run defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
run defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
run defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2

# Click threshold (0=light, 1=medium, 2=firm)
run defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
run defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

# Key repeat speed (lower = faster; macOS default is 6/25)
run defaults write NSGlobalDomain KeyRepeat -int 2
run defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "  Activity Monitor..."

run defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
run defaults write com.apple.ActivityMonitor IconType -int 5
run defaults write com.apple.ActivityMonitor ShowCategory -int 0
run defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
run defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Time Machine                                                                #
###############################################################################

echo "  Time Machine..."

# Don't offer new disks for Time Machine backup
run defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Wrap up                                                                     #
###############################################################################

if $DRY_RUN; then
  echo ""
  echo "Dry run complete. Run without --dry-run to apply."
else
  echo ""
  echo "Done. Some changes require a logout/restart to take effect."
  echo "Restarting affected system processes..."
  for app in Finder Dock SystemUIServer; do
    killall "$app" &>/dev/null || true
  done
fi
