export PATH=$HOME/homebrew/bin:$HOME/Projects/flutter/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

alias vim=nvim
alias s="kitty +kitten ssh"

## Eza aliases
alias l='eza'
alias ll='eza -lbF --git'
alias la='eza -lbhHigmuSa --time-style=long-iso --git --color-scale'
alias lx='eza -lbhHigmuSa@ --time-style=long-iso --git --color-scale'
alias llt='eza -l --git --tree'
alias lt='eza --tree --level=2'
alias llm='eza -lbGF --git --sort=modified'
alias lld='eza -lbhHFGmuSa --group-directories-first'

# For Flutter
export CHROME_EXECUTABLE=google-chrome-stable
