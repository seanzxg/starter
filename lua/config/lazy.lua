local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
                           {"\nPress any key to exit..."}}, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = { -- add LazyVim and import its plugins
    {
        "LazyVim/LazyVim",
        import = "lazyvim.plugins"
    }, -- import/override with your plugins
    {
        import = "plugins"
    }},
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = {
        colorscheme = {"tokyonight", "habamax"}
    },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {"gzip", -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            "tarPlugin", "tohtml", "tutor", "zipPlugin"}
        }
    }
})

-- Kitty 终端集成,设置用户变量标识编辑器状态
if not vim.g.vscode then
    vim.api.nvim_create_autocmd({"VimEnter", "VimResume"}, {
        group = vim.api.nvim_create_augroup("KittySetVarVimEnter", {
            clear = true
        }),
        callback = function()
            io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
        end
    })

    vim.api.nvim_create_autocmd({"VimLeave", "VimSuspend"}, {
        group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", {
            clear = true
        }),
        callback = function()
            io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
        end
    })

end
