# dotfiles

`fighterjock`'s dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

This repository is chezmoi's **source state**, not a set of loose dotfiles. Each
entry maps to a live file on the machine (e.g. `dot_zshrc` installs to
`~/.zshrc`, `dot_config/nvim/` installs to `~/.config/nvim/`).

## What is managed

- Shell: `~/.zshrc`, `~/.zprofile`
- Git: `~/.gitconfig`
- Neovim: `~/.config/nvim/` (init.lua, lua/ modules, plugin lockfile)
- Crush: `~/.config/crush/crushrc`

Not tracked here: `~/.crush_env` (holds API keys, loaded by `crushrc` via
environment variables).

## Setting up a new machine

1. Install chezmoi: `brew install chezmoi`
2. Pull and apply: `chezmoi init --apply fighterjock`
3. Install Neovim plugins on first launch (`:Lazy sync`)

## Daily workflow

- Edit a live file, then record it: `chezmoi add ~/.zshrc`
- Preview what would change: `chezmoi diff`
- Apply changes from the source repo: `chezmoi apply`
- Commit changes: `chezmoi cd` then `git add -A && git commit`
