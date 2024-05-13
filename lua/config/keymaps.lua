-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local opts = { silent = true }

set("n", "<Tab>", "<C-i>", { desc = "Go forward in jumplist", remap = true })
set("n", "<Leader>y", '"+y', { desc = "Yank to system buffer", remap = true })
set("n", "<Leader>p", '"+y', { desc = "Paste from system buffer", remap = true })
