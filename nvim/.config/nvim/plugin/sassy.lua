local get_git_branch = function()
    if vim.fn.isdirectory('.git') then
        local branch = vim.fn.system("git branch --show-current | tr -d '\n'")

        return branch
    end

    return nil

end

print(get_git_branch())
