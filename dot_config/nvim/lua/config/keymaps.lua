local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better paste (don't replace register)
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlights
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Save
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>W", ":wa<CR>", { desc = "Save all" })

-- Quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })

-- Buffers
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Terminal escape
map("t", "<C-\\><C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open current file in browser (for HTML flight plans, etc.)
map("n", "<leader>ob", function()
  local file = vim.fn.expand("%:p")
  if file == "" then return end
  vim.fn.system({ "open", file })
end, { desc = "Open file in browser" })

-- Build project (auto-detects project type)
map("n", "<leader>mb", function()
  local cwd = vim.fn.getcwd()
  local cmd
  if vim.fn.filereadable(cwd .. "/Makefile") == 1 then
    cmd = "make"
  elseif vim.fn.filereadable(cwd .. "/go.mod") == 1 then
    cmd = "go build ./..."
  elseif vim.fn.filereadable(cwd .. "/package.json") == 1 then
    cmd = "npm run build"
  elseif vim.fn.filereadable(cwd .. "/Cargo.toml") == 1 then
    cmd = "cargo build"
  else
    vim.notify("No known build system found", vim.log.levels.WARN)
    return
  end
  vim.cmd("botright split | resize 15 | terminal " .. cmd)
end, { desc = "Build project" })

-- Run tests
map("n", "<leader>mt", function()
  local cwd = vim.fn.getcwd()
  local cmd
  if vim.fn.filereadable(cwd .. "/go.mod") == 1 then
    cmd = "go test ./..."
  elseif vim.fn.filereadable(cwd .. "/package.json") == 1 then
    cmd = "npm test"
  elseif vim.fn.filereadable(cwd .. "/Cargo.toml") == 1 then
    cmd = "cargo test"
  elseif vim.fn.filereadable(cwd .. "/Makefile") == 1 then
    cmd = "make test"
  else
    vim.notify("No known test runner found", vim.log.levels.WARN)
    return
  end
  vim.cmd("botright split | resize 15 | terminal " .. cmd)
end, { desc = "Run tests" })
