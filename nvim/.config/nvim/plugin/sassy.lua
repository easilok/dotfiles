local M = {
    sassy_is_tracking = false,
    options = {
        default_name = 'session',
        sassy_dir = vim.fn.stdpath("data") .. '/sassy',
        old_sessions = 30
    }
}

-- Clean file and directory names to more accessible text
local clean_path = function(name)
    if not name then return nil end
    -- Replace whitespace with underscores and remove any problematic characters
    return name:gsub("%s+", "_"):gsub("[^%w_-]", "")
end

-- Get git project by root directory
local get_git_root = function()
    -- TODO: should new line trim be made using lua?
    local git_root = vim.fn.system('git rev-parse --show-toplevel | tr -d "\n"  2>/dev/null')
    if vim.v.shell_error ~= 0 then
        return nil
    end

    return vim.fn.fnamemodify(git_root, ':t')
end

-- Get root directory known to current vim instance
local get_root_directory = function()
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(cwd, ':t')
end

-- Get current git branch
local get_git_branch = function()
    -- TODO: should new line trim be made using lua?
    local branch = vim.fn.system('git branch --show-current | tr -d "\n" 2>/dev/null')
    if vim.v.shell_error ~= 0 then
        return nil
    end

    return branch
end

-- Ensure directory exists
local ensure_directory = function(path)
    vim.fn.mkdir(path, 'p')
end

-- Checks if a section for the desired project branch already exists.
local check_existing_session = function(session_path)
    if session_path == nil then
        return false
    end

    return vim.fn.filereadable(session_path)
end

-- Starts an 'Obsession' for the current project's checked out branch
-- If session file already exists, source it
M.start_session = function(self)
    local project = get_git_root() or get_root_directory()
    local session = get_git_branch() or self.options.default_name

    -- Create path for the file using sessions_dir config
    local base_dir = self.options.sassy_dir
    local project_dir = base_dir .. '/' .. clean_path(project)
    local session_path = string.format("%s/%s.vim", project_dir, clean_path(session))

    -- Ensure directories exist
    ensure_directory(project_dir)

    if check_existing_session(session_path) then
        vim.cmd('source ' .. session_path)
        self.sassy_is_tracking = true
        return
    end

    vim.cmd('Obsession ' .. session_path)
    self.sassy_is_tracking = true
end

-- Stops tracking the current session (if exists)
M.stop_session = function(self)
    if not self.sassy_is_tracking then
        vim.notify("No current tracking session", vim.log.levels.ERROR)
        return
    end

    vim.cmd('Obsession')
    self.sassy_is_tracking = false
end

-- Remove existing session files older than configuration
M.clean_sessions = function()
    local base_dir = M.options.sassy_dir
    local cmd = string.format(
        'find %s -type f -name "*.vim" -mtime +%d -exec rm -f {} \\;',
        base_dir, M.options.old_sessions
    )
    vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        vim.notify("Something went wrong cleaning old sessions", vim.log.levels.ERROR)

        return
    end
    vim.notify("Deleted old sessions.", vim.log.levels.INFO)
end

-- Setup vim commands
local setup_commands = function()
    vim.api.nvim_create_user_command('Sassy',
        function()
            M:start_session()
        end, {}
    )

    vim.api.nvim_create_user_command('SassyStop',
        function()
            M:stop_session()
        end, {}
    )

    vim.api.nvim_create_user_command('SassyClean',
        function()
            M:clean_sessions()
        end, {}
    )
end

-- Setup module for custom properties
M.setup = function(self, options)
    if options ~= nil then
        for k, v in ipairs(options) do
            self.options[k] = v
        end
    end

    setup_commands()
end

M:setup()

return M
