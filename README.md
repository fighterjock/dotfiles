# dotfiles

`fighterjock`'s dotfiles, managed with [chezmoi](https://www.chezmoi.io/).
Targets macOS and Linux; several entries are templated and render per OS at
apply time.

This repository is chezmoi's **source state**, not a set of loose dotfiles.
Each entry maps to a live file on the machine (e.g. `dot_zshrc.tmpl` renders
and installs to `~/.zshrc`, `dot_config/nvim/` installs to
`~/.config/nvim/`).

## What is managed

- Shell: `~/.zshrc` and `~/.zprofile` (templated; macOS gets Homebrew and
  OrbStack in `zprofile`, Linux gets a local-bin PATH export)
- Prompt: `~/.config/starship.toml` (minimal one-line prompt: user, directory,
  git branch and status, all ASCII)
- Git: `~/.gitconfig`
- Neovim: `~/.config/nvim/` (init.lua, lua/ modules, plugin lockfile)
- Crush: `~/.config/crush/crushrc`
- Claude skills: `~/.claude/skills/`

Not tracked here: `~/.crush_env` (API keys, loaded by `crushrc`) and anything
else in `~/.claude` outside `skills/`.

`README.md` and `bootstrap.sh` are ignored by `.chezmoiignore` and stay in the
repo only.

## Tools installed on first apply

`run_once_install-shell-tools.sh` runs during the first `chezmoi apply` and
installs, via curl only (no package manager):

- starship (prompt)
- fzf (ctrl-R history, ctrl-T files)
- zsh-autosuggestions and zsh-syntax-highlighting into `~/.zsh/plugins/`

`.zshrc` loads each of these only if present, so a partial install never
breaks the shell.

## Setting up a new machine

Requires a POSIX shell, curl, git, and zsh (install zsh first if your Linux
distro does not ship it).

```bash
git clone https://github.com/fighterjock/dotfiles
cd dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs chezmoi with `get.chezmoi.io`, then runs
`chezmoi init --apply fighterjock/dotfiles`, which clones this repo into
`~/.local/share/chezmoi` and provisions everything. Open a new shell to pick
up the prompt, then run `:Lazy sync` in Neovim for plugins.

## Daily workflow

- Edit a live file, then record it: `chezmoi add ~/.zshrc`
- Preview what would change: `chezmoi diff`
- Apply changes from the source repo: `chezmoi apply`
- Commit changes: `chezmoi cd` then `git add -A && git commit`
