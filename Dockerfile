FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  autoconf \
  automake \
  bat \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  fzf \
  g++ \
  gcc \
  gettext \
  git \
  golang-go \
  jq \
  libtool \
  libtool-bin \
  locales \
  make \
  ninja-build \
  pkg-config \
  ripgrep \
  sudo \
  tmux \
  tree \
  zsh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /usr/bin/zsh dev
RUN chown -R dev:dev /home/dev

RUN curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
  && tar xzf nvim-linux64.tar.gz \
  && rm nvim-linux64.tar.gz \
  && mv nvim-linux64 /opt/ \
  && ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

RUN go install github.com/kinbiko/mokku/cmd/mokku@latest \
  && go install github.com/kinbiko/semver/cmd/upversion@latest

RUN git clone https://github.com/neovim/neovim.git \
  && cd neovim \
  && git checkout nightly \
  && make CMAKE_BUILD_TYPE=Release \
  && make install \
  && cd .. \
  && rm -rf neovim

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install-rust.sh
RUN sh ./install-rust.sh -y

RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN export PATH="$HOME/.cargo/bin:$PATH" && cargo install zoxide --locked && cargo install tree-sitter-cli

RUN curl -sfL https://direnv.net/install.sh | bash

COPY docker /home/dev/
COPY . /home/dev/.config/
COPY zsh /home/dev/.config/zsh/

USER dev

WORKDIR /home/dev

CMD [ "zsh" ]
