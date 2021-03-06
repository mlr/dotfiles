## Install

### 1. Clone dotfiles

Clone this repo into your home directory and run the install script.

    git clone git@github.com:mlr/dotfiles.git
    cd dotfiles
    ./install.sh

This will create symlinks for all config files in your home directory. You can
safely run this file multiple times.

There is configuration for `zsh` so switch your shell from the default `bash` to `zsh` on OS X:

    chsh -s /bin/zsh

### 2. Setup vim-plug

Setup [vim-plug](https://github.com/junegunn/vim-plug) for managing vim plugins. Then run `:PlugInstall` within vim.

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 3. Setup zsh-autosuggestions

Clone the repository:

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

See full install instructions at [zsh-autosuggestions/INSTALL.md](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
