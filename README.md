# Config
Some of my configs

# Some Prerequisites

### Create a zshenv file in ```/etc/zsh/zshenv```
In that file add this
```bash
ZDOTDIR=~/.config/zsh
```

For your the zshrc to work you will need this dendencies
```bash
exa bat trash-cli ranger neovim
```

### Setting Up Emacs
#### Emacs dependencies
For Doom emacs to work you will need this these dependencies
```bash
ripgrep fd emacs
```

#### If you want to install Doom emacs 
Use this command to install doom emacs
```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

#### Config
**For relative line numbers:**
    in the ```~/.config/doom/config.el``` put this
```emacs-lisp
   (setq display-line-numbers-type `relative)
```

**For setting up fonts**

``` emacs-lisp
(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Inter" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
```

### For Password Feedback 
Add this to your ```/etc/sudoers``` file
```bash
Defaults env_reset,pwfeedback
```

### For tmux to work run this before hand to setup TMP (tmux plugin manger)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
