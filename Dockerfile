FROM alpine:3.7
MAINTAINER Dan Itsara <dan@glazziq.com>

RUN apk --update --no-cache add \
    bash \
    ctags \
    curl \
    git \
    less \
    ncurses-terminfo \
    neovim \
    neovim-doc

# load bash-it and set aliases
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  ~/.bash_it/install.sh --silent && \
  ln -s ~/.bash_it/aliases/available/git.aliases.bash ~/.bash_it/enabled/150---git.aliases.bash && \
  ln -s ~/.bash_it/aliases/available/vim.aliases.bash ~/.bash_it/enabled/150---vim.aliases.bash && \
  # set default shell to bash
  sed -i 's/ash/bash/g' /etc/passwd && \
  mkdir /app

ADD home /root

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
  nvim -E -u NONE -S ~/.config/nvim/init.vim +PlugInstall +qall > /dev/null || true

WORKDIR /app
CMD nvim
