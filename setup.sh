#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Symlink pairs: "repo/path:target/path"
SYMLINKS=(
  ".zshrc:$HOME/.zshrc"
  ".zprofile:$HOME/.zprofile"
  ".gitconfig:$HOME/.gitconfig"
  ".gitignore:$HOME/.gitignore"
  ".vimrc:$HOME/.vimrc"
  ".RectangleConfig.json:$HOME/.RectangleConfig.json"
  ".claude/settings.json:$HOME/.claude/settings.json"
  "ghostty/config:$HOME/.config/ghostty/config"
  "starship/starship.toml:$HOME/.config/starship.toml"
  "vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json"
)

# Directories that need to exist before symlinking
MKDIR_TARGETS=(
  "$HOME/.claude"
  "$HOME/.config/ghostty"
  "$HOME/.config"
  "$HOME/Library/Application Support/Code/User"
)

###############################################################################
# Summary
###############################################################################

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                        dotfiles setup                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "This script will:"
echo ""
echo "  1. Symlink dotfiles from $DOTFILES_DIR to ~/"
for entry in "${SYMLINKS[@]}"; do
  target="${entry#*:}"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "       $target  (existing file will be backed up)"
  else
    echo "       $target"
  fi
done | sort
echo ""
echo "  2. Install Homebrew (if not already installed)"
echo "  3. Install packages via Brewfile (skips already-installed)"
echo "  4. Install VS Code extensions"
echo ""
echo "  Backups (if needed) → $BACKUP_DIR"
echo ""
read -rp "Continue? (y/n) " -n 1
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

###############################################################################
# Symlinks
###############################################################################

echo ""
echo "Creating symlinks..."

# Ensure parent directories exist
for dir in "${MKDIR_TARGETS[@]}"; do
  mkdir -p "$dir"
done

for entry in "${SYMLINKS[@]}"; do
  src="${entry%%:*}"
  target="${entry#*:}"
  source_path="$DOTFILES_DIR/$src"

  # Skip if source doesn't exist
  if [ ! -e "$source_path" ]; then
    echo "  [skip]    $src (not found in repo)"
    continue
  fi

  # If target exists and is already a symlink to the right place, skip
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source_path" ]; then
    echo "  [ok]      $target"
    continue
  fi

  # Back up existing file
  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
    echo "  [backup]  $target → $BACKUP_DIR/"
  fi

  ln -s "$source_path" "$target"
  echo "  [linked]  $target → $source_path"
done

###############################################################################
# Rectangle
###############################################################################

# Suppress Rectangle's first-run wizard by writing the "has launched before"
# flag and defaulting to alternate shortcuts — must be set before first launch
defaults write com.knollsoft.Rectangle SUHasLaunchedBefore -bool true
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -int 1

# If Rectangle is already running, relaunch it to pick up the config symlink
if pgrep -x Rectangle &>/dev/null; then
  echo ""
  echo "Relaunching Rectangle to load config..."
  osascript -e 'quit app "Rectangle"'
  sleep 1
  open -a Rectangle
fi

###############################################################################
# Homebrew
###############################################################################

echo ""
echo "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "  [ok] Homebrew already installed"
fi

echo ""
echo "Installing packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

###############################################################################
# VS Code extensions
###############################################################################

echo ""
echo "Installing VS Code extensions..."
if command -v code &>/dev/null; then
  while IFS= read -r ext; do
    code --install-extension "$ext" --force 2>&1 | grep -v "already installed"
  done < "$DOTFILES_DIR/vscode/extensions.txt"
else
  echo "  [skip] 'code' command not found — install VS Code first"
fi

###############################################################################
# Done
###############################################################################

echo ""
echo "Setup complete! Reload your shell or open a new terminal."
echo ""
echo "Optional next step — apply macOS defaults:"
echo "  ./macos_defaults.sh [--dry-run]"
echo ""
echo "Don't forget to initialise these apps:"
grep '# init:' "$DOTFILES_DIR/Brewfile" | while IFS= read -r line; do
  app=$(echo "$line" | sed -E 's/.*(brew|cask) "([^"]+)".*/\2/')
  note=$(echo "$line" | sed -E 's/.*# init: //')
  printf "  - %-20s %s\n" "$app" "$note"
done
echo ""
