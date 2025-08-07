-- since this is just an example spec, don't actually load anything here and return an empty spec
-- 由于这只是一个示例规范，实际上不要在这里加载任何内容并返回一个空规范
-- stylua: ignore
-- stylua: 忽略
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
-- "plugins" 目录下的每个规范文件都将被 lazy.nvim 自动加载
--
-- In your plugin files, you can:
-- 在你的插件文件中，你可以：
-- * add extra plugins
-- * 添加额外的插件
-- * disable/enabled LazyVim plugins
-- * 禁用/启用 LazyVim 插件
-- * override the configuration of LazyVim plugins
-- * 覆盖 LazyVim 插件的配置
return {
  -- add gruvbox
-- 添加 gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
-- 配置 LazyVim 加载 gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
-- 更改 trouble 配置
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
-- opts 将与父规范合并
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
-- 禁用 trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
-- 覆盖 nvim-cmp 并添加 cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
-- 更改一些 telescope 选项和一个键映射来浏览插件文件
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
-- 添加一个键映射来浏览插件文件
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
       -- desc = "Find Plugin File",
-- desc = "查找插件文件",
      },
    },
    -- change some options
-- 更改一些选项
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
-- 添加 pyright 到 lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
-- pyright 将通过 mason 自动安装并通过 lspconfig 加载
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
-- 添加 tsserver 并使用 typescript.nvim 而不是 lspconfig 进行设置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
-- 你可以在这里进行任何额外的 lsp 服务器设置
      -- return true if you don't want this server to be setup with lspconfig
-- 如果你不想让这个服务器通过 lspconfig 设置，则返回 true
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
-- 使用 typescript.nvim 设置的示例
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
-- 指定 * 以使用此函数作为任何服务器的回退
        -- ["*"] = function(server, opts) end,
-- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
-- 对于 typescript，LazyVim 还包含额外的规范来正确设置 lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
-- treesitter、mason 和 typescript.nvim。因此，你可以使用以下替代上面的内容：
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
-- 添加更多 treesitter 解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
-- 由于 `vim.tbl_deep_extend` 只能合并表而不能合并列表，上面的代码
  -- would overwrite `ensure_installed` with the new value.
-- 会用新值覆盖 `ensure_installed`。
  -- If you'd rather extend the default config, use the code below instead:
-- 如果你想要扩展默认配置，请使用下面的代码：
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
-- 添加 tsx 和 treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
-- opts 函数也可以用来更改默认的 opts：
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
-- 或者你可以返回新的选项来覆盖所有默认值
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
--[[在这里添加你的自定义 lualine 配置]]
      }
    end,
  },

  -- use mini.starter instead of alpha
-- 使用 mini.starter 替代 alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
-- 添加 jsonls 和 schemastore 包，并为 json、json5 和 jsonc 设置 treesitter
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
-- 在下面添加你想要安装的任何工具
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
