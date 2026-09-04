-- Treesitter — syntax highlighting and code understanding
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "go", "gomod", "gosum",
        "lua",
        "javascript", "typescript", "tsx",
        "html", "css", "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "bash",
        "proto",
        "vim", "vimdoc",
        "gitcommit", "diff",
      },
      auto_install = true,
    })
  end,
}
