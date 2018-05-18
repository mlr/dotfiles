Install
-------

Clone this repo into your home directory.

    git clone git@github.com:mlr/dotfiles.git
    cd dotfiles
    git submodule update --init --recursive
    ./install.sh

This will create symlinks for all config files in your home directory. You can
safely run this file multiple times.

There is configuration for `zsh` so switch your shell from the default `bash` to `zsh` on OS X:

    chsh -s /bin/zsh

Setup vim-plug
------------

Setup [vim-plug](https://github.com/junegunn/vim-plug) for managing vim plugins. Then run `:PlugInstall` within vim.

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
