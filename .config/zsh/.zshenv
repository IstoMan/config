export XDG_CONFIG_HOME="/home/$USER/.config"
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='xdg-open'
export MANPAGER='nvim +Man!'
export HISTCONTROL=ignoreboth
export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export ELECTRON_OZONE_PLATFORM_HINT=wayland
# To make scripting easy
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
export BUN_INSTALL="$HOME/.bun" 
export ODIN_ROOT="$HOME/.local/share/odin"
# for doom emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
# For node packages
export PATH=~/.npm-global/bin:$PATH
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/fvm/bin"
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH":"$HOME/.cargo/bin/"
. "$HOME/.cargo/env"
