## Install

### Clone dotfiles

Clone this repo into your home directory and run the install script.

    git clone git@github.com:mlr/dotfiles.git
    cd dotfiles
    ./install.sh

This will create symlinks for all config files in your home directory. You can
safely run this file multiple times.

There is configuration for `zsh` so switch your shell from the default `bash` to `zsh` on OS X:

    chsh -s /bin/zsh

### Setup vim-plug

Setup [vim-plug](https://github.com/junegunn/vim-plug) for managing vim plugins. Then run `:PlugInstall` within vim.

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Setup zsh-autosuggestions

Clone the repository:

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

See full install instructions at [zsh-autosuggestions/INSTALL.md](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

### Setup base16-shell

Clone the repository:

```
git clone https://github.com/tinted-theming/base16-shell.git ~/dotfiles/base16-shell
```

See full install instructions at [https://github.com/tinted-theming/base16-shell](https://github.com/tinted-theming/base16-shell)

### Fix compaudit warnings

If you are seeing warnings related to compaudit do the following.

```
for f in $(compaudit); do sudo chown $(whoami):admin $f; done
sudo chmod -R 755 /usr/local/share/zsh
sudo chmod -R 755 /usr/local/share/zsh/site-functions
```

### Xcode command line tools

```
sudo xcode-select --switch /Library/Developer/CommandLineTools
```

### Install Homebrew

https://brew.sh/

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install chruby and ruby-install

```
brew install chruby
brew install ruby-install
```

#### Install Dev environment dependencies

```
brew install automake autoconf libtool
```

##### Silver searcher aka :Ag

```
brew install the_silver_searcher
```

#### LastPass CLI

```
brew install lastpass-cli
```

##### ffi

If ffi gem fails to install try using the flag

```
-- --with-cflags="-Wno-error=implicit-function-declaration"
```

Ex:

```
gem install ffi -v '1.9.18' -- --with-cflags="-Wno-error=implicit-function-declaration"
```

Similarly you may need this for thin

```
gem install thin -v '1.7.0' -- --with-cflags="-Wno-error=implicit-function-declaration"
```

##### libv8

If libv8 fails to install try using the flag

```
-- --with-system-v8
```

Ex:

```
gem install libv8 -v '3.16.14.19' -- --with-system-v8
```

##### therubyracer

If therubyracer fails to install due to v8, try:

```
brew install v8@3.15
gem install therubyracer -v '0.12.3' -- --with-v8-dir=/usr/local/opt/v8@3.15
```

#### Install Postgresql

```
brew install postgresql@9.6
```

When installing pg gem use the flag

```
--with-pg-dir
```

Ex:
```
gem install pg -v '0.20.0' -- --with-pg-dir=/usr/local/opt/postgresql@9.6
```

##### Install psql CLI

```
brew install libpq
```

#### Install redis

```
brew install redis
brew services start redis
```

#### Other Tools

Install Homebrew vim, it's better than system vim.

```
brew install vim
```

Install tig.

```
brew install tig
```

