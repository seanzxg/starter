-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set
local opts = {
    noremap = true,
    silent = true
}

vim.keymap.set("i", "<C-a>", "<ESC>^i")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-h>", "<BS>")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-d>", "<Del>")
vim.keymap.set("i", "<C-o>", "<C-\\><C-o>O")
vim.keymap.set("n", "<ESC>", "<cmd>noh<CR>")

-- 选择模式退出
vim.keymap.set("n", "<Space>", "<Esc>", opts)
vim.keymap.set("s", "<Space>", "<Esc>", opts)
vim.keymap.set("x", "<Space>", "<Esc>", opts)
vim.keymap.set("v", "<Space>", "<Esc>", opts)

vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("i", "jk", "<ESC>:w<CR>", opts)

-- 保存文件
-- map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "x", "n", "s" }, "<D-s>", "<Esc>:w<CR>", { desc = "Save File" })

-- 文件树快捷键 (使用 Snacks Explorer - 項目根目錄)
vim.keymap.set("n", "<D-b>", function()
    Snacks.explorer({
        cwd = LazyVim.root()
    })
end, opts)

-- VSCode 風格快捷鍵
-- Command+P: 快速搜索文件 (使用 Snacks Picker)
vim.keymap.set("n", "<D-p>", function()
    Snacks.picker.files({
        cwd = LazyVim.root()
    })
end, {
    desc = "Find Files (Root Dir)",
    noremap = true,
    silent = true
})

-- Command+Shift+P: 命令面板 (使用 Snacks Picker)
vim.keymap.set("n", "<D-S-p>", function()
    Snacks.picker.commands()
end, {
    desc = "Command Palette",
    noremap = true,
    silent = true
})

vim.keymap.set("n", "<D-w>", "<cmd>:bdelete!<CR>", opts) -- 关闭当前buffer

-- 添加简化的文本操作映射
local operators = {"c", "d", "y", "v"}
local text_objects = {
    -- 基础文本对象
    q = "aq", -- '"
    w = "aw", -- word
    e = "ae", -- case
    o = "io", -- return
    t = "at", -- tag
    p = "aa", -- 段落 
    u = "au", -- call
    m = "am", -- 参数
    b = "ab", -- 括号
    g = "ag", -- all
    ['"'] = 'i"', -- 引号
    ["'"] = "i'", -- 单引号
    ["`"] = "i`", -- 反引号
    ["("] = "i(", -- 圆括号
    [")"] = "i)",
    ["{"] = "i{", -- 大括号
    ["}"] = "i}",
    ["["] = "i[", -- 方括号
    ["]"] = "i]",
    ["<"] = "i<", -- 尖括号
    [">"] = "i>"
}

-- 为每个操作符和文本对象创建映射
for _, operator in ipairs(operators) do
    for key, mapping in pairs(text_objects) do
        vim.keymap.set("n", operator .. key, operator .. mapping, {
            silent = true,
            remap = true
        })
    end
end

-- Terminal Mappings
map("n", "<D-j>", function()
    Snacks.terminal(nil, {
        cwd = LazyVim.root()
    })
end, {
    desc = "Terminal (Root Dir)"
})
map("t", "<D-j>", "<cmd>close<cr>", {
    desc = "Hide Terminal"
})

map("n", "M", "<cmd>bprevious<cr>", opts)
map("n", "m", "<cmd>bnext<cr>", opts)

if vim.g.vscode then
    vim.keymap.set('n', "M", "<Cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>", opts)
    vim.keymap.set('n', "m", "<Cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>", opts)
    
    -- vim.keymap.set('n', "M", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opts)
    -- vim.keymap.set('n', "m", "<Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>", opts)

    vim.keymap.set('i', "<C-j>", "<Cmd>call VSCodeNotify('jumpToNextSnippetPlaceholder')<CR>", opts)
    vim.keymap.set('i', "<C-k>", "<Cmd>call VSCodeNotify('jumpToPrevSnippetPlaceholder')<CR>", opts)
    
    vim.keymap.set('n', "<leader>.", "<Cmd>call VSCodeNotify('workbench.action.reloadWindow')<CR>", opts)
end

vim.keymap.set({ 'n', 'v' }, '<S-h>', '^', opts)
vim.keymap.set({ 'n', 'v' }, '<S-l>', '$', opts)
