-- HTML preview with sheen
return {
  "hangarbay/sheen.nvim",
  cmd = "Sheen",
  ft = "html",
  keys = {
    { "<leader>ch", desc = "Preview HTML in sheen" },
  },
  opts = {
    auto_open = true,
  },
}
