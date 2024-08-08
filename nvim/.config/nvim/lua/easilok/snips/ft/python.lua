local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
    s(
        "plintnext",
        fmt(
            [[
            # pylint: disable-next={}
            ]],
            {
                i(0),
            }
        )
    ),
    s(
        "plint",
        fmt(
            [[
            # pylint: disable={}
            ]],
            {
                i(0),
            }
        )
    ),
})
