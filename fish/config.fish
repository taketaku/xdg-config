set -x XDG_CONFIG_HOME ~/.config

set -x LANG en_US.UTF-8
#set -x PATH $PATH ~/Library/Android/sdk/platform-tools
set -x PATH $PATH /usr/local/bin

ulimit -n 1024

# Anyenv settings {{{
if [ -d $HOME/.anyenv ]
  set -x ANY_ENV_HOME $HOME/.anyenv
  set -x PATH $HOME/.anyenv/bin $PATH
  if [ ! -f $HOME/.anyenv/init.fish ]
    anyenv init - > $HOME/.anyenv/init.fish
  end
  source $HOME/.anyenv/init.fish
end
# }}}


# Direnv settings {{{
set -x EDITOR nvim
eval (direnv hook fish)
# }}}


# coreutils settings {{{
set COREUTILS_PATH /usr/local/opt/coreutils/libexec/gnubin
if [ -s $COREUTILS_PATH ]
  set -x PATH $COREUTILS_PATH $PATH
end
# }}}


# SSH settings {{{
if [ -s "$XDG_CONFIG_HOME/ssh/conendg" ]
  set SSH_CONFIG "-F $XDG_CONFIG_HOME/ssh/conendg"
end
if [ -s "$XDG_CONFIG_HOME/ssh/id_dsa" ]
  set SSH_ID "-i $XDG_CONFIG_HOME/ssh/id_dsa"
end
alias ssh         ssh $SSH_CONFIG $SSH_ID
alias ssh-copy-id ssh-copy-id $SSH_ID
# }}}

alias gp "cd (ghq list -p | peco)"

# cheat {{{
set -x DEFAULT_CHEAT_DIR $XDG_CONFIG_HOME/cheat
if [ ! -d $DEFAULT_CHEAT_DIR ]
  mkdir -p $DEFAULT_CHEAT_DIR
end
# }}}

# Vim settings {{{
alias vim nvim
alias vi  vim
# }}}


# Tig settings {{{
set -x TIGRC_USER $XDG_CONFIG_HOME/tig/tigrc
alias tig "tig --all"
# }}}


# PHP settings {{{
set -x XDEBUG_CONFIG  on
set -x PHP_IDE_CONFIG 'serverName=localhost'
# }}}


# Ruby settings {{{
#set -x GEM_HOME $HOME/.gem
#set -x PATH     $GEM_HOME/ruby/2.0.0/bin:$PATH
#set -x PATH     $GEM_HOME/bin/:$PATH
#[ ! -d "~/.gem" ]; and mkdir ~/.gem
#set -x GEM_HOME ~/.gem
# }}}


# Go settings {{{
set -x GOPATH $HOME/Codes
if [ ! -d $GOPATH/bin ]
  mkdir -p $GOPATH/bin
end
set -x PATH   $GOPATH/bin $PATH
function GOROOT_update
  set -x GOROOT (goenv exec go env GOROOT)
  set -x PATH   $GOROOT/bin $PATH
end
GOROOT_update
# }}}


# Term settings {{{
if [ (uname -s) = "Linux" ]
  set -x TERM "screen-256color"
end
if [ (uname -s) = "Darwin" ]; and [ ! -f ~/.cache/term/"$TERM".ti ]
  mkdir -p ~/.cache/term
  #infocmp "$TERM" | sed 's/kbs=^[hH]/kbs=\\177/' >| ~/.cache/term/"$TERM".ti
  #tic ~/.cache/term/"$TERM".ti
end
# }}}


#function brew-cask-upgrade
#  for app in (brew cask list)
#    local latest=(brew cask info $app | awk 'NR==1{print $2}');
#    local versions=(ls -1 "/usr/local/Caskroom/$app/.metadata/");
#    local current=(echo $versions | awk '{print $NF}');
#    if [ "$latest" = "latest" ]
#      echo "[!] $app: $current == $latest";
#      [ "$1" = "-f" ]; and brew cask install "$app" --force;
#      continue;
#    else if [ "$current" = "$latest" ]
#      continue;
#    end
#    echo "[+] $app: $current -> $latest";
#    brew cask uninstall "$app" --force;
#    brew cask install "$app";
#  end
#end

# Run tmux
pgrep tmux > /dev/null ^&1; or tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf
