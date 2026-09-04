-- Markdown preview with glow
return {
  "hangarbay/glow.nvim",
  cmd = "Glow",
  ft = "markdown",
  keys = {
    { "<leader>cg", desc = "Preview markdown in glow" },
  },
  opts = {
    auto_open = true,
  },
}
