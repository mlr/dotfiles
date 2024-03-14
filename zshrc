# Path
export PATH=/usr/local/bin:/opt/local/bin:/Users/ronnie/bin:/usr/local/sbin:$PATH

# add v8 to path
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"

# add psql to path
export PATH="/usr/local/opt/libpq/bin:$PATH"

# add base16-shell
BASE16_SHELL="$HOME/dotfiles/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

function base16_random() {
  themes=$(find -f ~/dotfiles/base16-shell/scripts | cut -d/ -f7 | sed 's/\.sh//' | sed 's/base16-/base16_/g')

  # Allow setting a random theme based on a grep.
  # ex:
  # base16_random light
  # base16_random dark
  # base16_random material
  # base16_random solarize
  if [ ! -z "$1" ]; then
    themes=$(echo $themes | grep $1)
  fi

  randomtheme=$(echo $themes | shuf -n1)
  echo "$randomtheme"
  eval $randomtheme
}

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

# expand functions in the prompt
setopt prompt_subst

# disable flow control commands
stty start undef
stty stop undef

# prompt
# export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%1~%{$reset_color%}] '

# keep tons of history and share between terminals
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
setopt share_history
bindkey "^[[A" history-beginning-search-backward # Use up to search history using partially entered command
bindkey "^[[B" history-beginning-search-forward  # Use down to search history using partially entered command

# ignore duplicate history entries
setopt histignoredups
setopt inc_append_history

# look for ey config in project dirs
export EYRC=./.eyrc

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT

# Exceptions to the correct command
alias tmux='nocorrect tmux'
alias brew='nocorrect brew'

# Enable extended globbing
setopt EXTENDED_GLOB

# Setup chruby for managing ruby versions
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.7.6
source /usr/local/share/chruby/auto.sh

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Automatically use .nvmrc file in current directory
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path=".nvmrc"

  if [ -f "$nvmrc_path" ]; then
    local node_version="$(nvm version)"

    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# zsh autocompletion setup
[[ -s $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# tmuxinator setup
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# fzf fuzzy search setup
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Machine-specific zsh aliases
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Disable SAM metrics
export SAM_CLI_TELEMETRY=0

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

# Composer
alias composer='php /Users/ronnie/bin/composer.phar'

# jenv (Java version manager)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Android Studio
export ANDROID_HOME=/Users/ronnie/Library/Android/sdk
export PATH=/Users/ronnie/Library/Android/sdk/platform-tools:$PATH
