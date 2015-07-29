Install
-------

Clone this repo into your home directory.

    git clone git@github.com:mlr/dotfiles.git
    cd dotfiles
    ./install.sh

This will create symlinks for all config files in your home directory. You can
safely run this file multiple times.

There is configuration for `zsh` so switch your shell from the default `bash` to `zsh` on OS X:

    chsh -s /bin/zsh

Setup Vundle
------------

Setup vundle for vim. Then run `:BundleInstall` within vim.

     git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
