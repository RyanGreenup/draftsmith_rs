FROM archlinux:latest

# Install deps
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm curl git postgresql-libs postgresql rustup gcc perl

# Other nice to haves for development / interactive use
RUN pacman -S --noconfirm neovim emacs nushell fish tmux bat ripgrep fd fzf less tree

# Add rustup and cargo to the PATH
ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup default stable

# Verify installations
RUN rustc --version && \
    cargo --version && \
    git --version && \
    pg_config --version

# Install Diesel
RUN pacman -S --noconfirm openssl make
RUN cargo install diesel_cli --no-default-features --features postgres-bundled


# Set the container's working directory
WORKDIR /usr/src/app


# Clone the API/CLI
RUN git clone --recurse-submodules https://github.com/RyanGreenup/draftsmith_rs $HOME/draftsmith_rs

# Create an empty database
ENV PGPASSWORD=postgres


# Make sure the container continues to be interactive
CMD ["/bin/bash"]

