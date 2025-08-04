# Tmux

Tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal.

## Dependencies

To use this configuration, you'll need to install:
- `tmux`
- `tpm` (Tmux Plugin Manager)

### Arch Linux Installation
```bash
sudo pacman -S tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Tips
- Press `prefix + I` to install plugins.
- You can change the prefix key in `tmux.conf`.
