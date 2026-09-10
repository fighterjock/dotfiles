-- Claude integration
return {
  "hangarbay/claude.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  keys = {
    { "<leader>cl", desc = "Toggle Claude" },
    { "<leader>cs", desc = "Toggle terminal" },
    { "<leader>cv", mode = "v", desc = "Claude: run on selection" },
    { "<leader>cx", desc = "Claude: send file to Claude" },
  },
  opts = {
    keymaps = {
      toggle = "<leader>cl",
      shell = "<leader>cs",
      selection = "<leader>cv",
      file = "<leader>cx",
    },
  },
}