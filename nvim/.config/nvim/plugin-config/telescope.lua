local action_layout = require('telescope.actions.layout')

require("telescope").setup({
    defaults = {
        -- file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                width = 0.8,
                -- prompt_position = "top",
            }
        },
        mappings = {
            i = {
                ["<C-t>"] = action_layout.cycle_layout_next,
            },
            n = {
                ["<C-t>"] = action_layout.cycle_layout_next,
            }
        },
    },
    -- extensions = { },
})

local fzfLua = require('fzf-lua')

require('fzf-lua').setup({
    keymap = {
        builtin = {
            true,
            -- ["shift-ctrl-d"] = "preview-down",
            -- ["shift-ctrl-u"] = "preview-up",
            ["<c-d>"] = "preview-page-down",
            ["<c-u>"] = "preview-page-up",
        },
        fzf = {
            true,
            -- ["ctrl-d"]  = "half-page-down",
            -- ["ctrl-u"]    = "half-page-up",
            -- ["ctrl-d"]  = "preview-page-down",
            -- ["ctrl-u"]    = "preview-page-up",
            ["ctrl-q"] = "select-all+accept",
            ["ctrl-f"] = "half-page-up",
            ["ctrl-b"] = "half-page-down",
            ["ctrl-x"] = "jump",
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-u"] = "preview-page-up",
        }
    }
})

require("telescope").load_extension("fzf")

local builtin = require('telescope.builtin')

if vim.g.finder_plugin == 'fzflua' then
    -- Set new commands to better name
    vim.cmd([[command! -nargs=0 GoToFile :FzfLua files]])
    vim.cmd([[command! -nargs=0 GoToCommand :FzfLua commands]])

    vim.keymap.set('n', '<space>?', fzfLua.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<space>fg', fzfLua.git_files, { desc = '[F]ind [g]it files' })
    vim.keymap.set('n', '<space><space>', fzfLua.git_files, { desc = '[F]ind [g]it files' })
    vim.keymap.set('n', '<space>ff', fzfLua.files, { desc = '[F]ind [f]iles' })
    vim.keymap.set('n', '<C-p>', fzfLua.files, { desc = '[F]ind [f]iles' })
    vim.keymap.set('n', '<space>gs', fzfLua.grep, { desc = '[G]rep [s]earch' })
    vim.keymap.set('n', '<space>gw', fzfLua.grep_cword, { desc = '[G]rep current [w]ord' })
    vim.keymap.set('n', '<space>bl', fzfLua.buffers, { desc = '[B]uffer [l]ist' })
    vim.keymap.set('n', '<space>gl', fzfLua.live_grep, { desc = '[G]rep [l]ive' })
    vim.keymap.set('n', '<leader>gb', fzfLua.git_branches, { desc = '[G]it [b]ranches' })
    vim.keymap.set('n', '<leader>gc', fzfLua.git_commits, { desc = '[G]it [c]ommits' })
    vim.keymap.set('n', '<space>th', fzfLua.help_tags, { desc = '[T]elescope [h]elp files' })
    vim.keymap.set('n', '<space>we', fzfLua.diagnostics_workspace, { desc = '[G]rep diagnostics' })
    vim.keymap.set('n', '<leader>gr', fzfLua.lsp_references, { desc = '[G]rep [r]eferences' })
    vim.keymap.set('n', '<space>lds', fzfLua.lsp_document_symbols, { desc = '[L]sp [D]ocument [S]ymbols' })
    vim.keymap.set('n', '<space>ft', fzfLua.tags, { desc = '[F]ind [T]ags' })
    vim.keymap.set('n', '<space>tr', fzfLua.resume, { desc = '[T]elescope [r]esume' })
    vim.keymap.set('n', '<space>tk', fzfLua.keymaps, { desc = '[T]elescope [k]eymaps' })
    vim.keymap.set('v', '<leader>gs', fzfLua.grep_visual, { desc = '[G]rep visual [s]earch' })
    vim.keymap.set('v', '<space>gs', fzfLua.grep_visual, { desc = '[G]rep visual [s]earch' })
    vim.keymap.set('n', '<leader>fb', fzfLua.lgrep_curbuf, { desc = '[F]ind [b]uffer text' })
    vim.keymap.set('n', '<space>fb', fzfLua.lgrep_curbuf, { desc = '[F]ind [b]uffer text' })
    vim.keymap.set('n', '<leader>be', fzfLua.diagnostics_document, { desc = '[B]uffer diagnostics' })
    vim.keymap.set('n', '<space>be', fzfLua.diagnostics_document, { desc = '[B]uffer diagnostics' })
else
    -- Set new commands to better name
    vim.cmd([[command! -nargs=0 GoToFile :Telescope find_files]])
    vim.cmd([[command! -nargs=0 GoToCommand :Telescope commands]])

    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<space>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[F]ind [g]it files' })
    vim.keymap.set('n', '<space>fg', builtin.git_files, { desc = '[F]ind [g]it files' })
    vim.keymap.set('n', '<space><space>', builtin.git_files, { desc = '[F]ind [g]it files' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [f]iles' })
    vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = '[F]ind [f]iles' })
    vim.keymap.set('n', '<C-p>', builtin.find_files, {desc = '[F]ind [f]iles'})
    vim.keymap.set('n', '<leader>gs', function() builtin.grep_string({ search = vim.fn.input("Grep For > ") }) end, { desc = '[G]rep [s]earch' })
    vim.keymap.set('n', '<space>gs', function() builtin.grep_string({ search = vim.fn.input("Grep For > ") }) end, { desc = '[G]rep [s]earch' })
    vim.keymap.set('n', '<leader>gw', function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end, { desc = '[G]rep current [w]ord' })
    vim.keymap.set('n', '<space>gw', function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end, { desc = '[G]rep current [w]ord' })
    vim.keymap.set('n', '<leader>bl', builtin.buffers, { desc = '[B]uffer [l]ist' })
    vim.keymap.set('n', '<space>bl', builtin.buffers, { desc = '[B]uffer [l]ist' })
    vim.keymap.set('n', '<leader>gl', builtin.live_grep, { desc = '[G]rep [l]ive' })
    vim.keymap.set('n', '<space>gl', builtin.live_grep, { desc = '[G]rep [l]ive' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [b]ranches' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [c]ommits' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [h]elp files' })
    vim.keymap.set('n', '<space>th', builtin.help_tags, { desc = '[T]elescope [h]elp files' })
    vim.keymap.set('n', '<leader>ge', builtin.diagnostics, { desc = '[G]rep diagnostics' })
    vim.keymap.set('n', '<space>we', builtin.diagnostics, { desc = '[G]rep diagnostics' })
    vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[G]rep [r]eferences' })
    vim.keymap.set('n', '<space>lds', builtin.lsp_document_symbols, { desc = '[L]sp [D]ocument [S]ymbols' })
    vim.keymap.set('n', '<space>lws', builtin.lsp_dynamic_workspace_symbols, { desc = '[L]sp [W]orkspace [S]ymbols' })
    vim.keymap.set('n', '<space>ft', builtin.tags, { desc = '[F]ind [T]ags' })
    vim.keymap.set('n', '<space>tr', builtin.resume, { desc = '[T]elescope [r]esume' })
    vim.keymap.set('n', '<space>tk', builtin.keymaps, { desc = '[T]elescope [k]eymaps' })

    vim.keymap.set('n', '<leader>fb', function() builtin.current_buffer_fuzzy_find({ sorting_strategy = "ascending" }) end, { desc = '[F]ind [b]uffer text' })
    vim.keymap.set('n', '<space>fb', function() builtin.current_buffer_fuzzy_find({ sorting_strategy = "ascending" }) end, { desc = '[F]ind [b]uffer text' })
    vim.keymap.set('n', '<leader>be', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = '[B]uffer diagnostics' })
    vim.keymap.set('n', '<space>be', function() builtin.diagnostics({ bufnr = 0 }) end, { desc = '[B]uffer diagnostics' })


    local function grep_visual_selection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})

        text = string.gsub(text, "\n", "")

        builtin.grep_string({
            search = text,
        })
    end

    vim.keymap.set('v', '<leader>gs', grep_visual_selection, { desc = '[G]rep visual [s]earch' })
    vim.keymap.set('v', '<space>gs', grep_visual_selection, { desc = '[G]rep visual [s]earch' })
end

local actions = require 'telescope.actions'
local action_state = require "telescope.actions.state"

local function files_wiki()
    builtin.find_files({
        prompt_title = "Wiki files",
        cwd = vim.g.wiki_root,
        disable_devicons = true, -- the icon is always the same
        find_command = { "rg", "--files", "--sort", "path" },
        file_ignore_patterns = {
            "%.stversions/",
            "%.git/",
            "%journal/",
        },
        path_display = function(_, path)
            local name = path:match "(.+)%.[^.]+$"
            return name or path
        end,
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace_if(function()
                return action_state.get_selected_entry() == nil
            end, function()
                actions.close(prompt_bufnr)

                local new_name = action_state.get_current_line()
                if new_name == nil or new_name == "" then
                    return
                end

                vim.fn["wiki#page#open"](new_name)
            end)

            return true
        end,
    })
end

local function files_wiki_journal()
    builtin.find_files({
        prompt_title = "Wiki Journal files",
        cwd = vim.g.wiki_root_journal,
        disable_devicons = true, -- the icon is always the same
        find_command = { "rg", "--files", "--sort", "path" },
        file_ignore_patterns = {
            "%.stversions/",
            "%.git/",
        },
        -- path_display = function(_, path)
        --     local name = path:match "(.+)%.[^.]+$"
        --     return name or path
        -- end,
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace_if(function()
                return action_state.get_selected_entry() == nil
            end, function()
                actions.close(prompt_bufnr)

                local new_name = action_state.get_current_line()
                if new_name == nil or new_name == "" then
                    return
                end

                vim.fn["wiki#page#open"](new_name)
            end)

            return true
        end,
    })
end

local function files_nvim()
    builtin.git_files({
        prompt_title = "Find Neovim Files: ",
        cwd = '~/.config/nvim/',
        find_command = { "rg", "--files", "--sort", "path" },
        file_ignore_patterns = {
            "%.stversions/",
            "%.git/",
        },
    })
end

local function wiki_content()
    builtin.live_grep({
        prompt_title = "Wiki content",
        cwd = vim.g.wiki_root,
        disable_devicons = true, -- the icon is always the same
        -- find_command = { "rg", "--files", "--sort", "path" },
        file_ignore_patterns = {
            "%.stversions/",
            "%.git/",
        },
        path_display = function(_, path)
            local name = path:match "(.+)%.[^.]+$"
            return name or path
        end,
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace_if(function()
                return action_state.get_selected_entry() == nil
            end, function()
                actions.close(prompt_bufnr)

                local new_name = action_state.get_current_line()
                if new_name == nil or new_name == "" then
                    return
                end

                vim.fn["wiki#page#open"](new_name)
            end)

            return true
        end,
    })
end

vim.keymap.set('n', '<leader>fw', files_wiki, { desc = '[Find] [W]iki files' })
vim.keymap.set('n', '<space>wc', wiki_content, { desc = '[W]iki [C]ontent' })
vim.keymap.set('n', '<leader>fc', files_wiki, { desc = '[Find] Wiki [C]ontent' })
vim.keymap.set('n', '<space>wf', files_wiki, { desc = '[W]iki [F]iles' })
vim.keymap.set('n', '<leader>fv', files_nvim, { desc = '[F]ind Neo[v]im files' })
vim.keymap.set('n', '<leader>fj', files_wiki_journal, { desc = '[Find] [J]ournal Wiki files' })
vim.keymap.set('n', '<space>wj', files_wiki_journal, { desc = '[W]iki [J]ournal files' })
