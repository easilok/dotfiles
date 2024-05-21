local ls = require "luasnip"

local s = ls.s
local sn = ls.sn
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

local function get_filename()
    local filenameParts = vim.split(vim.fn.expand('%:t'), '.', { plain = true })
    return filenameParts[1] or ""
end

local start_from_filename = function(position)
    return d(position, function()
        return sn(nil, i(position, get_filename()))
    end, {})
end

ls.add_snippets("typescriptreact", {
    s(
        "fc",
        fmt(
            [[
import React from 'react'

const {}: React.FC = () => {{
    return (
        {}
    );
}}

export default {};
            ]],
            {
                start_from_filename(1),
                i(0),
                rep(1),
            }
        )
    ),
    s(
        "async",
        fmt(
            [[
const {} = async () => {{
    try {{
        {}
    }} catch(err) {{
        // eslint-disable-next-line no-console
        console.log(err);
    }}
}}
            ]],
            {
                i(1),
                i(0),
            }
        )
    )
})
