local ok, dap = pcall(require, "dap")
if not ok then return end
dap.set_log_level('INFO')

require("mason-nvim-dap").setup( {
    automatic_installation = true,
    ensure_installed = { "node2", "js", "python" }
})


--debugging

require("nvim-dap-virtual-text").setup({})

-- require('dap-go').setup()
local dapui = require("dapui")
dapui.setup()

local function dap_terminate_and_close()
    dap.terminate()
    dapui.close()
end

vim.keymap.set("n", "<F5>", dap.continue, { desc = 'Dap Continue' })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = 'Dap Step Over' })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = 'Dap Step Into' })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = 'Dap Step Out' })
vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = '[D]ap toggle [b]reakpoint' })
vim.keymap.set("n", "<space>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    { desc = '[D]ap [B]reakpoint condition' })
vim.keymap.set("n", "<space>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = '[D]ap set break[p]oint' })
vim.keymap.set("n", "<space>dr", dap.repl.open, { desc = '[D]ap [R]epl' })
vim.keymap.set("n", "<space>dx", dap_terminate_and_close, { desc = '[D]apui Close' })
vim.keymap.set("n", "<space>dt", dap_terminate_and_close, { desc = '[D]apui [T]erminate' })
-- vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

-- setup listeners for interact with dapui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

-- javascript/typescript
if not dap.adapters["pwa-node"] then
    require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
                vim.fn.expand('~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'),
                "${port}",
            },
        },
    }
end
if not dap.adapters["node"] then
    dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
            config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
        else
            cb(nativeAdapter)
        end
    end
end

-- python
local python_interpreter = 'python'
if os.getenv("VIRTUAL_ENV") ~= nil then
    python_interpreter = os.getenv("VIRTUAL_ENV") .. "/bin/python"
end

if not dap.adapters["python"] then
    dap.adapters.python = {
        type = 'executable',
        command = python_interpreter,
        args = { '-m', 'debugpy.adapter' },
    }
end
