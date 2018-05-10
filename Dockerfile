FROM alpine:3.7
MAINTAINER Dan Itsara <dan@glazziq.com>

RUN apk --update --no-cache add \
    bash \
    ctags \
    curl \
    git \
    ncurses-terminfo \
    vim

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  ~/.bash_it/install.sh --silent && \
  ln -s ~/.bash_it/aliases/available/git.aliases.bash ~/.bash_it/enabled/150---git.aliases.bash && \
  ln -s ~/.bash_it/aliases/available/vim.aliases.bash ~/.bash_it/enabled/150---vim.aliases.bash && \
  mkdir /app

ADD dotfiles /root

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
  vim -E -u NONE -S ~/.vimrc +PluginInstall +qall > /dev/null || true

WORKDIR /app
ENTRYPOINT bash
