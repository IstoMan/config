# Doom Emacs

Doom Emacs is a configuration framework for GNU Emacs tailored for Emacs bankruptcy veterans who want to get things done.

## Dependencies

To use this configuration, you'll need to install:
- `emacs`
- `doom-emacs`

### Arch Linux Installation
```bash
sudo pacman -S emacs fd ripgrep
git clone https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

## Tips
- Run `doom sync` after changing `init.el` or `packages.el`.
- Use `doom upgrade` to update Doom Emacs.
