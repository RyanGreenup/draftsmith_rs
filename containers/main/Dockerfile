FROM archlinux:latest

# Install deps
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm curl git postgresql-libs postgresql rustup gcc just

# Flask Deps
# NOTE gunicorn will not inherit the poetry environment
# I could setup a manual venv, but for now I'll just install the packages globally
RUN pacman -S --noconfirm python-pydantic python-flask python-pydantic \
                          gunicorn python-flask-wtf poetry python-pipx \
                          python-typer python-flask-wtf python-poetry-plugin-export

# Other nice to haves for development / interactive use
RUN pacman -S --noconfirm neovim emacs nushell fish tmux bat ripgrep fd fzf less tree jq tealdeer yazi broot && \
    tldr --update

# Add rustup and cargo to the PATH
ENV PATH="/root/.cargo/bin:${PATH}"
ENV PATH="/usr/local/bin:${PATH}"
ENV PATH="$HOME/.local/bin:${PATH}"

RUN rustup default stable

# Verify installations
RUN rustc --version && \
    cargo --version && \
    git --version && \
    pg_config --version

# Install Diesel
RUN pacman -S --noconfirm openssl make pkg-config perl
RUN cargo install diesel_cli --no-default-features --features postgres-bundled


# Set the container's working directory
WORKDIR /usr/src/app

# Build the REST API
RUN git clone --recurse-submodules https://github.com/RyanGreenup/draftsmith_rs $HOME/draftsmith_rs && \
cd $HOME/draftsmith_rs/draftsmith_rs_api && \
cargo build --release && \
cp ../target/release/cli /usr/local/bin/draftsmith

RUN mkdir -p $HOME/.local/share/virtualenvs/
ENV FLASK_VENV="$HOME/.local/share/virtualenvs/draftsmith_flask"

# Build Flask
# Must use venv for gunicorn, doesn't inherit poetry environment
RUN cd $HOME/draftsmith_rs/draftsmith_flask && \
poetry export -f requirements.txt -o requirements.txt && \
python3 -m venv ${FLASK_VENV} && \
source ${FLASK_VENV}/bin/activate && \
pip install -r requirements.txt

# Make sure the container continues to be interactive
CMD ["/bin/sh"]

