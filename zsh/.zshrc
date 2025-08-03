# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Enable colors and change prompt:
autoload -U colors && colors	# Load color

# To make scripting easy
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# for doom emacs
export PATH="$HOME/.config/emacs/bin:$PATH"

# For node packages
export PATH=~/.npm-global/bin:$PATH

[ ! -d $XDG_CONFIG_HOME/oh-my-posh ] && mkdir -p $XDG_CONFIG_HOME/oh-my-posh
[ ! -f $XDG_CONFIG_HOME/oh-my-posh/mocha.omp.json ] && wget https://raw.githubusercontent.com/maxstolly/catppuccin.omp/main/mocha.omp.json -P ~/.config/oh-my-posh
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/mocha.omp.json)"

stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# The following lines were added by compinstall

# Basic auto/tab complete:
autoload -U compinit
# zstyle ':completion:*' menu select
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
compinit

# Emacs bindings
bindkey -e

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

zinit cdreplay -q

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

eval "$(zoxide init --cmd cd zsh)"
