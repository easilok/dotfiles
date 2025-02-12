local M = {}

local config = {
    title = 'Dump your head',
    title_pos = 'center',
    root_path = nil, -- see setup() for default value
    temp_file = vim.fn.stdpath('state') .. '/headster.md',
    startinsert = false,
}

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

---Ensure provided directory full path exists on system
---@param path string Directory path
local ensure_directory = function(path)
    vim.fn.mkdir(vim.fn.expand(path), 'p')
end

---Loads content of existing headster file.
---Empty list if no existing file.
---@param headster_path string Headster file path
---@return string[] # Content of existing Headster files as line list
local load_existing_headster = function(headster_path)
    if headster_path == nil then
        return {}
    end

    if vim.fn.filereadable(headster_path) == 1 then
        return vim.fn.readfile(headster_path)
    end

    return {}
end

---Reads content of ptovided buffer and save it to daily headster file.
---If buffer has no content, skip saving headster file.
---@param buf integer Buffer where the content should be read
local save_buffer_content = function(buf)
    local headster_path = M.get_headster_path()
    local previous_content = load_existing_headster(headster_path)
    local headster_title = '### Inserted at ' .. os.date('%H:%M:%S')

    -- Get buffer content
    local buf_content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- Check if buffer is not empty (contains non-whitespace characters)
    local has_content = false
    for _, line in ipairs(buf_content) do
        if line:match("%S") then
            has_content = true
            break
        end
    end

    if has_content then
        local content = {}
        -- Prepare content lines by putting new content on top
        vim.list_extend(content, { headster_title, '' })
        vim.list_extend(content, buf_content)
        if #previous_content > 0 then
            -- Append new line to buffer content
            -- to separate from previous content
            vim.list_extend(content, {''})
        end
        vim.list_extend(content, previous_content)

        vim.fn.writefile(content, headster_path)
        vim.notify("Content saved to " .. headster_path)
    else
        vim.notify("Skipping empty content for " .. headster_path)
    end
end

---Creates a floating window to input new content
---for the current Headster file (defined by the current date)
---@param opts table|nil Custom options for the window
---@return table # Created window and buffer identifiers
local create_headster_window = function(opts)
    opts = opts or {}

    -- Create a new buffer to collect user input
    local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    -- Set buffer type for allowing save commands
    vim.api.nvim_set_option_value('buftype', 'acwrite', { buf = buf })
    -- Set buffer hidden mode to wipe to clean everything when buffer is closed
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
    -- Set buffer type for proper syntax highlighting
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    -- Set the buffer name to temp file for enabling custom save command
    vim.api.nvim_buf_set_name(buf, config.temp_file)

    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or 5

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)


    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        -- style = 'minimal',
        border = "rounded",
        title = config.title,
        title_pos = config.title_pos,
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    -- Set up autocmd for :w with closing
    local augroup = vim.api.nvim_create_augroup("headster-buf-write", { clear = true })
    vim.api.nvim_create_autocmd("BufWriteCmd", {
        group = augroup,
        buffer = buf,
        callback = function()
            save_buffer_content(buf)
            vim.api.nvim_win_close(win, true)
            return true
        end
    })

    -- Set up autocmd for :x command
    vim.api.nvim_create_autocmd("QuitPre", {
        group = augroup,
        buffer = buf,
        callback = function()
            save_buffer_content(buf)
        end
    })

    -- Set up keymaps
    vim.keymap.set('n', 'q', function()
        save_buffer_content(buf)
        vim.api.nvim_win_close(win, true)
    end, { buffer = buf, noremap = true, silent = true })

    -- Optional start window in insert mode
    if config.startinsert then
        vim.cmd('startinsert')
    end

    return { buf = buf, win = win }
end

---Gets current headster file path based on current date
---@return string
M.get_headster_path = function()
    local headster_file = os.date('%Y%m%d') .. '.md'
    local headster_path = config.root_path .. '/' .. headster_file

    return vim.fn.expand(headster_path)
end

---Open headster capture floating window
M.capture = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_headster_window { buf = state.floating.buf }
    else
        vim.api.nvim_win_close(state.floating.win, true)
    end
end

---Open current headster file in buffer
M.view_current = function()
    local headster_path = M.get_headster_path()

    vim.cmd('edit ' .. headster_path)
end

---Headster plugin setup function
---Provides 'Headster' command for capture floating window
---Provides 'HeadsterShow' command for open current headster in buffer
---@param opts table|nil Options for customizing plugin
M.setup = function(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})
    -- Ensure a default path is always used
    config.root_path = config.root_path or vim.fn.stdpath("data") .. '/headster'
    ensure_directory(config.root_path)

    vim.api.nvim_create_user_command("Headster", M.capture, {})
    vim.api.nvim_create_user_command("HeadsterView", M.view_current, {})
end

-- M.setup()

return M
