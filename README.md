# Config
Some of my configs

# Some Prerequisites

### Create a zshenv file in ```/etc/zsh/zshenv```
In that file add this
```
ZDOTDIR=~/.config/zsh
```

For your the zshrc to work you will need this dendencies
```
exa bat trash-cli ranger neovim
```

### Emacs dependencies
For Doom emacs to work you will need this these dependencies
```
ripgrep fd emacs
```

### If you want to install Doom emacs 
Use this command to install doom emacs
```
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

#### For Realtive line numbers
 In Doom Emacs:
    in the ```~/.config/doom/config.el``` put this
   ```
   (setq display-line-numbers-type `relative)
```

In Neovim:
Put this in the ```~/.config/nvim/lua/core/init.lua```
```
vim.wo.relativenumber = true
```

### For Password Feedback 
Add this to your ```/etc/sudoers``` file
```
Defaults env_reset,pwfeedback
```
### Kitty Themes
if you want colour schemes for kitty then just run this command and choose
```
kitty +kitten themes
```
### For tmux to work run this before hand to setup TMP (tmux plugin manger)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Lf Dependencies
```bash
atool chafa diff-so-fancy lynx ffmpeg ffmpegthumbnailer fontforge glow highlight jq imagemagick perl-image-exiftool poppler transmission-cli
```
