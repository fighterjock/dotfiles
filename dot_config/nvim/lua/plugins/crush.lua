-- Crush integration
return {
  "hangarbay/crush.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  keys = {
    { "<leader>cc", desc = "Toggle Crush" },
    { "<leader>ct", desc = "Toggle terminal" },
    { "<leader>cr", mode = "v", desc = "Crush: run on selection" },
    { "<leader>cf", desc = "Crush: send file to Crush" },
  },
  opts = {
    direction = "vertical",
    shell_direction = "vertical",
  },
}
