# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python from Homebrew
export PATH="$(brew --prefix python)/libexec/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

export EDITOR=vim

# Colors — shared between ls, eza, and zsh tab completion
# LSCOLORS: macOS ls (bold blue dirs, bold cyan symlinks, bold green executables)
export CLICOLOR=1
export LSCOLORS=ExGxxxxxCxxxxxxxxxxxxx
# LS_COLORS: zsh tab completion
export LS_COLORS='di=1;34:ln=1;36:ex=1;32'

# Aliases
alias rm='rm -i'
alias bc='bc -l'
alias ls='eza'
alias ll='eza --long --git'
alias la='eza --long --all --git'
alias lt='eza --tree --level=2'
alias cat='bat --paging=never'

# fzf (key bindings + completions)
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# Atuin (shell history)
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

# zoxide (smart cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Completions — must come after tools that register completions
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Claude Code — export CLAUDE_ACTIVE into the shell while a session is running
# This lets Starship show an indicator in the right prompt
function claude() {
  CLAUDE_ACTIVE=1 command claude "$@"
  unset CLAUDE_ACTIVE
}

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"
