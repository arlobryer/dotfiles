#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Symlink map: repo path -> target path
declare -A SYMLINKS=(
  [".zshrc"]="$HOME/.zshrc"
  [".zprofile"]="$HOME/.zprofile"
  [".gitconfig"]="$HOME/.gitconfig"
  [".gitignore"]="$HOME/.gitignore"
  [".vimrc"]="$HOME/.vimrc"
  [".RectangleConfig.json"]="$HOME/.RectangleConfig.json"
  [".claude/settings.json"]="$HOME/.claude/settings.json"
  ["ghostty/config"]="$HOME/.config/ghostty/config"
)

# Files that need their parent directory created first
MKDIR_TARGETS=(
  "$HOME/.claude"
  "$HOME/.config/ghostty"
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
for src in "${!SYMLINKS[@]}"; do
  target="${SYMLINKS[$src]}"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "       $target  (existing file will be backed up)"
  else
    echo "       $target"
  fi
done | sort
echo ""
echo "  2. Install Homebrew (if not already installed)"
echo "  3. Install packages via brewinstall.sh"
echo "  4. Install oh-my-zsh (if not already installed)"
echo "  5. Install zsh theme"
echo ""
echo "  Backups (if needed) → $BACKUP_DIR"
echo ""
read -p "Continue? (y/n) " -n 1
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

for src in "${!SYMLINKS[@]}"; do
  target="${SYMLINKS[$src]}"
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
sh "$DOTFILES_DIR/brewinstall.sh"

###############################################################################
# oh-my-zsh
###############################################################################

echo ""
echo "Checking oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "  [ok] oh-my-zsh already installed"
fi

echo ""
echo "Installing zsh theme..."
cp "$DOTFILES_DIR/arlogb.zsh-theme" "$HOME/.oh-my-zsh/themes/arlogb.zsh-theme"
echo "  [ok] arlogb.zsh-theme"

###############################################################################
# Done
###############################################################################

echo ""
echo "Setup complete! Reload your shell or open a new terminal."
echo ""
echo "Optional next step — apply macOS defaults:"
echo "  ./macos_defaults.sh [--dry-run]"
echo ""
