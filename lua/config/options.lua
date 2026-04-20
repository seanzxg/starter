-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- 删除/修改操作不写入剪贴板（使用黑洞寄存器）
vim.keymap.set({"n", "v"}, "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set({"n", "v"}, "D", '"_D', { noremap = true })
vim.keymap.set({"n", "v"}, "c", '"_c', { noremap = true })
vim.keymap.set("n", "cc", '"_cc', { noremap = true })
vim.keymap.set({"n", "v"}, "C", '"_C', { noremap = true })
vim.keymap.set({"n", "v"}, "x", '"_x', { noremap = true })
vim.keymap.set({"n", "v"}, "X", '"_X', { noremap = true })
vim.keymap.set({"n", "v"}, "s", '"_s', { noremap = true })
