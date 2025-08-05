-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Insert模式下的bash风格键位映射
map("i", "<C-a>", "<ESC>^i")
map("i", "<C-e>", "<End>")
map("i", "<C-h>", "<BS>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-d>", "<Del>")
map("i", "<C-o>", "<C-\\><C-o>O")
map("n", "<ESC>", "<cmd>noh<CR>")

-- 窗口切换（仅在非VSCode环境下）
-- 基础键位设置
local opts = {
    noremap = true,
    silent = true
}

map("i", "jj", "<ESC>", opts)
-- Insert模式下使用jk���并保存
map("i", "jk", "<ESC>:w<CR>", opts)


-- 保存文件
map("n", "<D-s>", ":w<CR>", opts)
map("i", "<D-s>", "<Esc>:w<CR>", opts)
