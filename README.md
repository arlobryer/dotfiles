# dotfiles

Personal macOS setup for a new machine.

## Setup

```bash
git clone git@github.com:arlobryer/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./setup.sh
```

`setup.sh` will show you what it's going to do and ask for confirmation before proceeding. It:
- Symlinks dotfiles into `~/` (backing up any existing files)
- Installs Homebrew and packages
- Installs oh-my-zsh and the zsh theme

Safe to re-run. If you move the repo, re-run `setup.sh` to update the symlinks.

## macOS defaults

After setup, optionally apply sensible macOS defaults:

```bash
./macos_defaults.sh           # apply
./macos_defaults.sh --dry-run # preview first
```

## Adding a new dotfile

1. Add the file to this repo
2. Add it to the `SYMLINKS` map in `setup.sh`
3. Re-run `setup.sh`
