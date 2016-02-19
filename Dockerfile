FROM ubuntu:latest

# environment variables
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y vim git wget fontconfig curl

RUN useradd dev && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

WORKDIR /home/dev
ENV HOME /home/dev
ENV LC_ALL en_US.UTF-8

RUN chown -R dev:dev $HOME
USER dev

# setup pathogen vim plugin manager
RUN mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && \
    wget -P $HOME/.vim/autoload https://tpo.pe/pathogen.vim && \
    echo "execute pathogen#infect()" >> $HOME/.vimrc && \
    echo "syntax on" >> $HOME/.vimrc && \
    echo "set nocp" >> $HOME/.vimrc && \
    echo "filetype plugin indent on" >> $HOME/.vimrc && \
# Powerline fonts
    mkdir -p $HOME/.fonts $HOME/.config/fontconfig/conf.d && \
    wget -P $HOME/.fonts https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf && \
    wget -P $HOME/.config/fontconfig/conf.d/ https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf && \
    fc-cache -vf $HOME/.fonts/ && \
    echo "set guifont=Droid\\ Sans\\ Mono\\ 10"

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  # Install vim plugins
  cd ~/.vim/bundle && \
  git clone git://github.com/tpope/vim-sensible.git && \
  git clone https://github.com/flazz/vim-colorschemes.git && \
  git clone https://github.com/scrooloose/nerdtree.git && \
  git clone https://github.com/bling/vim-airline && \
  git clone https://github.com/kien/ctrlp.vim && \
  git clone https://github.com/scrooloose/syntastic && \
  git clone https://github.com/tpope/vim-fugitive && \
  git clone https://github.com/tpope/vim-surround && \
  git clone https://github.com/pangloss/vim-javascript && \
  git clone https://github.com/tpope/vim-rails && \
  git clone https://github.com/vim-ruby/vim-ruby && \
  git clone https://github.com/elzr/vim-json && \
  git clone https://github.com/elixir-lang/vim-elixir && \
  git clone https://github.com/moll/vim-node && \
  git clone https://github.com/airblade/vim-gitgutter

COPY vimrc_append $HOME/vimrc_append
RUN cat $HOME/vimrc_append >> $HOME/.vimrc

CMD vim
