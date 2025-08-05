-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Kitty 终端集成,设置用户变量标识编辑器状态
local autocmd = vim.api.nvim_create_autocmd
if not vim.g.vscode then
    -- 进入vim时设置标识
    autocmd({"VimEnter", "VimResume"}, {
        group = vim.api.nvim_create_augroup("KittySetVarVimEnter", {
            clear = true
        }),
        callback = function()
            io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
        end
    })
    -- 退出vim时清除标识
    autocmd({"VimLeave", "VimSuspend"}, {
        group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", {
            clear = true
        }),
        callback = function()
            io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
        end
    })
end
