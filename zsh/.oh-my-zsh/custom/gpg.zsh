# Symlink GPG agent config based on OS
# This ensures the correct pinentry program is used on macOS vs. Linux.

if [[ "$(uname)" == "Darwin" ]]; then
    # Use pinentry-mac for a GUI password prompt on macOS
    ln -sf $HOME/dotfiles/gnupg/.gnupg/gpg-agent.conf.macos $HOME/.gnupg/gpg-agent.conf
else
    # Use pinentry-tty for a terminal-based prompt on Linux
    ln -sf $HOME/dotfiles/gnupg/.gnupg/gpg-agent.conf.linux $HOME/.gnupg/gpg-agent.conf
fi

# Symlink GPG config based on OS
if [[ "$(uname)" == "Darwin" ]]; then
    ln -sf $HOME/dotfiles/gnupg/.gnupg/gpg.conf.macos $HOME/.gnupg/gpg.conf
else
    ln -sf $HOME/dotfiles/gnupg/.gnupg/gpg.conf.linux $HOME/.gnupg/gpg.conf
fi
