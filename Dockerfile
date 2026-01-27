# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive frontend for package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
  sudo \
  git \
  gnupg \
  zsh \
  curl \
  neovim \
  stow \
  && rm -rf /var/lib/apt/lists/*

# Create a non-root user with sudo privileges
RUN useradd -m -s /bin/zsh -G sudo het
RUN echo "het:het" | chpasswd
RUN echo "het ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER het
WORKDIR /home/het

# Install Oh My Zsh unattended
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Clone the dotfiles repo to somewhere hidden
RUN git clone https://github.com/harryterkelsen/dotfiles.git /home/het/dotfiles

# Change working directory to dotfiles and run stow
WORKDIR /home/het/dotfiles
RUN rm /home/het/.zshrc
RUN stow git gnupg nvim zsh

# Set the default command to launch zsh
CMD ["/bin/zsh"]
