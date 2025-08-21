return {{
    "ggandor/flit.nvim",
    enabled = false
}, {
    "ggandor/leap.nvim",
    enabled = false
}, {
    "folke/flash.nvim",
    opts = {
        -- modes = {
        --     char = {
        --         enabled = false -- 禁用默认的 char 模式，这通常使用 s 键
        --     }
        -- },
        label = {
            uppercase = false
        },
    },
    keys = { -- 明确禁用默认的 s 键
    {"s", false}, {"S", false}, -- 设置我们想要的键位映射
    {"t", false}, {"T", false}, -- 设置我们想要的键位映射
    {
        "f",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump({
               search = { forward = true, wrap = false, multi_window = false },
            })
        end,
        desc = "Flash Jump"
    },
    {
        "t",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump({
                search = { forward = false, wrap = false, multi_window = false },
            })
        end,
        desc = "Flash Jump"
    }, {
        "F",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
    }, {
        "T",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    }, {
        "<c-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
    }}
}}
