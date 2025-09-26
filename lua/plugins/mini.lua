---@class Mini.ai.loc
---@field line number
---@field col number
---@class Mini.ai.region
---@field from Mini.ai.loc
---@field to Mini.ai.loc
local M = {}

-- Line text object (like vim-textobj-line)
---@param ai_type string "a" for around, "i" for inside
---@return Mini.ai.region|nil
function M.ai_line(ai_type)
    local line = vim.fn.line('.')
    local text = vim.fn.getline(line)

    if ai_type == 'i' then
        -- 获取非空白字符的起始和结束位置
        local from_col = text:match("^%s*()%S")
        local to_col = text:match(".*%S()%s*$")

        if not from_col then
            -- 如果行全是空白，返回nil
            return nil
        end

        return {
            from = {
                line = line,
                col = from_col
            },
            to = {
                line = line,
                col = to_col - 1
            }
        }
    else -- ai_type == 'a'
        -- 选择整行
        return {
            from = {
                line = line,
                col = 1
            },
            to = {
                line = line,
                col = #text
            }
        }
    end
end

return {{
    "nvim-mini/mini.ai",
    opts = {
        mappings = {
            around_last = 'aN',
            inside_last = 'iN'
        },
        custom_textobjects = {
            p = require("mini.ai").gen_spec.treesitter({
                a = "@parameter.outer",
                i = "@parameter.inner"
            }),
            m = require("mini.ai").gen_spec.treesitter({
                a = "@attribute.outer",
                i = "@attribute.inner"
            }),
            l = M.ai_line
        }
    }
}}
