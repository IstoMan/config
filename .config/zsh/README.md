# Zsh

The Z shell (Zsh) is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting.

## Dependencies

This configuration uses `zinit` for plugin management. To use this configuration, you'll need to install:
- `zsh`
- `zinit`
- `oh-my-posh`
- `fzf`
- `zoxide`
- `lsd`
- `bat`
- `trash-cli`
- `neovim`

### Arch Linux Installation
```bash
sudo pacman -S zsh oh-my-posh fzf zoxide lsd bat trash-cli neovim
# Install zinit
bash -c "$(curl -fsSL https://git.io/zinit-install)"
```

## Tips
- You can add new plugins in `.zshrc`.
- You can add new aliases in `aliasrc`.