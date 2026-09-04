# dotfiles

Personal Neovim configuration with [Crush](https://github.com/anthropics/crush) AI integration.

## Setup

```bash
# Clone
git clone https://github.com/fighterjock/dotfiles.git ~/dotfiles

# Symlink nvim config
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Launch (plugins auto-install on first run)
nvim
```

## Requirements

- Neovim >= 0.12
- [Crush](https://github.com/anthropics/crush) installed
- ripgrep (`brew install ripgrep`) for Telescope live grep
- A [Nerd Font](https://www.nerdfonts.com/) for icons

## Key Bindings

### Crush (AI)
| Key | Action |
|---|---|
| `Space cc` | Toggle Crush popup |
| `Space ct` | Toggle shell terminal |
| `Space cr` | Pipe visual selection to Crush |
| `Space cf` | Send current file to Crush |

### Navigation
| Key | Action |
|---|---|
| `Space ff` | Find files |
| `Space fg` | Live grep |
| `Space fb` | Buffers |
| `Space ft` | Find TODOs |
| `Space e` | Toggle file tree |
| `Space o` | Reveal file in tree |

### Build
| Key | Action |
|---|---|
| `Space mb` | Build project |
| `Space mt` | Run tests |

### LSP
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `Space rn` | Rename |
| `Space ca` | Code action |

## Plugins

- [crush.nvim](https://github.com/hangarbay/crush.nvim) -- Crush AI integration
- [lazy.nvim](https://github.com/folke/lazy.nvim) -- Plugin manager
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) -- Fuzzy finder
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) -- File tree
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) -- Syntax highlighting
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) -- LSP
- [blink.cmp](https://github.com/saghen/blink.cmp) -- Completion
- [catppuccin](https://github.com/catppuccin/nvim) -- Colorscheme
- [trouble.nvim](https://github.com/folke/trouble.nvim) -- Diagnostics panel
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) -- TODO highlighting
