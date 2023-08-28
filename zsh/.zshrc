# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/suhas/.config/zsh/.zshrc'

autoload -Uz compinit
compinit 
setopt PROMPT_SUBST
zstyle ':completion:*' menu select

# End of lines added by compinstall
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# To make nvim default editor
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# To make scripting easy
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# For quick edits
alias nzsh="$EDITOR ~/.config/zsh/.zshrc"
alias nbsp="$EDITOR ~/.config/bspwm/bspwmrc"
alias nsx="$EDITOR ~/.config/sxhkd/sxhkdrc"








# Some useful utilitie
alias v="$EDITOR"
alias ll="exa -alh"
alias ls='exa'
alias cat='bat'
alias rm="trash -v"
alias r="ranger"
alias p="sudo pacman"

#Autojump

if [ -f "/usr/share/autojump/autojump.sh" ]; then
	. /usr/share/autojump/autojump.zsh
elif [ -f "/usr/share/autojump/autojump.bash" ]; then
	. /usr/share/autojump/autojump.zsh
else
	echo "can't found the autojump script"
fi

# For Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# For Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
