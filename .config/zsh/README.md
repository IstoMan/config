# Zsh

The Z shell (Zsh) is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting.

## Config location (`~/.config/zsh`)

By default zsh looks for startup files in `$HOME` (`~/.zshrc`, `~/.zshenv`, etc.). This setup keeps everything under **`~/.config/zsh`** (XDG-style) so it can live in this repo as `.config/zsh` and be installed with **stow** (see the top-level `README.md`).

zsh uses **`ZDOTDIR`** for where to load `.zprofile`, `.zshrc`, and most other zsh-specific files. Only **`~/.zshenv`** is read from your home directory first (with the usual default `ZDOTDIR=$HOME`), so you need a **tiny stub** there that points zsh at this directory and loads the real env file.

Create **`~/.zshenv`** with:

```zsh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
[[ -r "$ZDOTDIR/.zshenv" ]] && . "$ZDOTDIR/.zshenv"
```

After stow, `~/.config/zsh` is a symlink into this repository; `ZDOTDIR` resolves to that path. History and completion dumps stay under the same directory (see `.gitignore` there).

If you prefer not to use a stub, you can set `ZDOTDIR` system-wide (for example in `/etc/zsh/zshenv`) instead—only use one approach so startup order stays predictable.

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
