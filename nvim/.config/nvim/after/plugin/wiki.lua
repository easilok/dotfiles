local wiki_root = '~/Nextcloud/vimwiki'

if vim.fn.isdirectory(vim.fn.expand(wiki_root)) ~= 0 then
    vim.g.wiki_root = vim.fn.expand(wiki_root)
    vim.g.wiki_root_journal = vim.fn.expand(wiki_root .. '/journal')

    vim.g.wiki_export = {
        args = '-V papersize=A4 -V geometry:margin=1in -V mainfont="Arial" --number-sections',
        from_format = 'markdown',
        ext = 'pdf',
        link_ext_replace= false,
        view = false,
        output= vim.fn.fnamemodify(vim.fn.tempname(), ':h'),
    }

    vim.g.wiki_journal = {
        name= 'journal',
        root= '',
        frequency= 'daily',
        date_format= {
            daily = '%Y/%m/%d',
            weekly = '%Y/week_%V',
            monthly = '%Y/%m/summary',
        },
    }

    vim.g.lists_filetypes = {'markdown', 'wiki', 'md'}
end
