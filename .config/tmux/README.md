# Tmux

Tmux is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal.

## Dependencies

To use this configuration, you'll need to install:
- `tmux`
- `tpm` (Tmux Plugin Manager)

### Arch Linux Installation

```bash
git clone --single-branch https://github.com/gpakosz/.tmux.git ~/Repos/oh-my-tmux
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -s ~/Repos/oh-my-tmux/.tmux.conf "$XDG_CONFIG_HOME/tmux/tmux.conf"
cp ~/Repos/oh-my-tmux/.tmux.conf.local "$XDG_CONFIG_HOME/tmux/tmux.conf.local"
```

## Tips
- Press `prefix + I` to install plugins.
- You can change the prefix key in `tmux.conf`.
