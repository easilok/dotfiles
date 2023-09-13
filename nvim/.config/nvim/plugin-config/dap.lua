--debugging

local ok, dap = pcall(require, "dap")
if not ok then return end

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>dp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dx", ":lua require'dapui'.close()<CR>")
-- vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

require("nvim-dap-virtual-text").setup()
-- require('dap-go').setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.set_log_level('INFO')
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
  args = {os.getenv('HOME') .. '/git/vscode-node-debug2/out/src/nodeDebug.js'},
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
    processId = require'dap.utils'.pick_process,
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
	  };
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
	  };
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
	  };
    outFiles = { '${workspaceFolder}/dist/**/*.js', '!**/node_modules/**' };
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
	  };
    outFiles = { '${workspaceFolder}/dist/**/*.js', '!**/node_modules/**' };
  },
}

-- python
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  -- args = {os.getenv('HOME') .. '/git/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.python = {
  {
    type = 'python',
    name = 'Run test on file',
    request = 'launch',
    module = 'unittest',
    mode = 'test',
    env = {
        FLASK_ENV= "test",
        ADDVOLT_DATABASE_HOST= "localhost",
        ADDVOLT_DATABASE_PORT= "5444"
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
	  };
  },
}
