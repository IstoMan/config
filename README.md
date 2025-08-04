# Dotfiles

These are my personal dotfiles for various applications. Each directory contains a `README.md` with more information about the configuration and its dependencies.

## Installation

First you would need `git` and `stow`

```bash
sudo pacman -Syu git stow
```

To install these dotfiles, you can use a tool like `stow`.

```bash
stow -d ~/Repos/Dotfiles -t ~/ .
```

This will create symbolic links from the files in this repository to your home directory.

## Dependencies

Each application has its own dependencies, which are listed in the `README.md` file within its respective directory. Please refer to those files for installation instructions.
