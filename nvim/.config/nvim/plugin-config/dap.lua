--debugging

local ok, dap = pcall(require, "dap")
if not ok then return end
dap.set_log_level('INFO')

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
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- setup dap adapters
-- node/javascript
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/git/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require 'dap.utils'.pick_process,
    },
    {
        type = 'node2',
        name = 'Run tests',
        request = 'launch',
        program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
        env = {
            NODE_ENV = "test",
            ADDVOLT_DATABASE_HOST = "localhost",
            ADDVOLT_DATABASE_PORT = "5444",
        },
        args = {
            "inspect",
            "--config",
            "${workspaceFolder}/test/.mocharc.json",
            -- "--reporter",
            -- "dot",
            "--exit",
            "--colors",
            "${workspaceFolder}/test/**/*.test.js"
        },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        restart = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {
            '<node_internals>/**',
            '**/node_modules/**',
        },
    },
    {
        type = 'node2',
        name = 'Run test on file',
        request = 'launch',
        mode = 'test',
        program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
        env = {
            NODE_ENV = "test",
            ADDVOLT_DATABASE_HOST = "localhost",
            ADDVOLT_DATABASE_PORT = "5444",
        },
        args = {
            "inspect",
            "--config",
            "${workspaceFolder}/test/.mocharc.json",
            "--file",
            "${workspaceFolder}/test/bootstrap.test.js",
            -- "--reporter",
            -- "dot",
            -- "--slow",
            -- "5000",
            "--exit",
            "--colors",
            "${file}"
        },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        restart = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {
            '<node_internals>/**',
            '**/node_modules/**',
        },
    },
}

dap.configurations.typescript = {
    {
        type = 'node2',
        name = 'Run tests',
        request = 'launch',
        mode = 'test',
        program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
        env = {
            NODE_ENV = "test"
        },
        args = {
            "--require=ts-node/register",
            "--unhandled-rejections=strict",
            "--colors",
            "src/test/**/*.test.ts",
        },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        restart = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {
            '<node_internals>/**',
            '**/node_modules/**',
        },
        outFiles = { '${workspaceFolder}/dist/**/*.js', '!**/node_modules/**' },
    },
    {
        type = 'node2',
        name = 'Run test on file',
        request = 'launch',
        mode = 'test',
        program = '${workspaceFolder}/node_modules/mocha/bin/_mocha',
        args = {
            "--require=ts-node/register",
            "--unhandled-rejections=strict",
            "--colors",
            "${file}"
        },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        restart = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {
            '<node_internals>/**',
            '**/node_modules/**',
        },
        outFiles = { '${workspaceFolder}/dist/**/*.js', '!**/node_modules/**' },
    },
}

local python_interpreter = ''
if os.getenv("VIRTUAL_ENV") ~= nil then
    python_interpreter = os.getenv("VIRTUAL_ENV") .. "/bin/python"
end

-- python
dap.adapters.python = {
    type = 'executable',
    command = python_interpreter,
    args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
    {
        type = 'python',
        name = 'Run test on file',
        request = 'launch',
        module = 'unittest',
        mode = 'test',
        env = {
            FLASK_ENV = "test",
            ADDVOLT_DATABASE_HOST = "localhost",
            ADDVOLT_DATABASE_PORT = "5444"
        },
        args = {
            "[${file}]",
        },
        cwd = '${workspaceFolder}',
        justMyCode = true,
        restart = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {
        },
    },
    {
        type = 'python',
        name = 'Run file',
        cwd = '${workspaceFolder}',
        request = 'launch',
        program = "${file}",
        -- pythonPath = function()
        --     -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        --     -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        --     -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        --     local cwd = vim.fn.getcwd()
        --     if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        --         return cwd .. '/venv/bin/python'
        --     elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        --         return cwd .. '/.venv/bin/python'
        --     else
        --         return '/usr/bin/python'
        --     end
        -- end,
    },
}
