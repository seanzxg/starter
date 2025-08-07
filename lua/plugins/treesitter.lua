return {{
    "nvim-treesitter/nvim-treesitter",
    opts = {
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<cr>",
                node_incremental = "<cr>",
                scope_incremental = false,
                node_decremental = "<bs>"
            }
        }
    }
}, {
    "echasnovski/mini.ai",
    opts = {
        custom_textobjects = {
            p = require("mini.ai").gen_spec.treesitter({
                a = "@parameter.outer",
                i = "@parameter.inner"
            }),
            m = require("mini.ai").gen_spec.treesitter({
                a = "@attribute.outer",
                i = "@attribute.inner"
            })
        }
    }
}}
