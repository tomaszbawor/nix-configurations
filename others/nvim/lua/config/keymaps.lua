-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ZK mappings
map("n", "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
map("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
map("n", "<leader>zt", "<cmd>ZkTags<CR>", opts)
map("n", "<leader>zl", "<cmd>ZkLinks<CR>", opts)
map("i", "jj", "<Esc>", opts)
