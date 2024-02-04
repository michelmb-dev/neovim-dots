-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "dw", 'vb"_d', { desc = "Delete a word backwards" })
map("n", "A", "gg<S-v>G", { desc = "Select all" })
map("n", "te", ":tabedit<CR>", { noremap = true, silent = true, desc = "New tab" })

-- Split window
map("n", "ss", ":split<CR>", opts)
map("n", "sv", ":vsplit<CR>", opts)

-- Move lines selected
map("v", "<A-k>", ":m <-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line to up" })
map("v", "<A-J>", ":m >+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line to down" })

-- Easy exit insert mode
map({ "i", "v" }, "jj", "<ESC>")
-- Diagnostics

map("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
