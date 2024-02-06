let g:wiki_root = '~/Nextcloud/vimwiki'
let g:wiki_root_journal = '~/Nextcloud/vimwiki/journal'

let g:wiki_export = {
            \ 'args' : '-V papersize=A4 -V geometry:margin=1in -V mainfont="Arial" --number-sections',
            \ 'from_format' : 'markdown',
            \ 'ext' : 'pdf',
            \ 'link_ext_replace': v:false,
            \ 'view' : v:false,
            \ 'output': fnamemodify(tempname(), ':h'),
            \}

let g:wiki_journal = {
          \ 'name': 'journal',
          \ 'root': '',
          \ 'frequency': 'daily',
          \ 'date_format': {
          \   'daily' : '%Y/%m/%d',
          \   'weekly' : '%Y/week_%V',
          \   'monthly' : '%Y/%m/summary',
          \ },
          \}

let g:lists_filetypes = ['markdown', 'wiki', 'md']

augroup EnableLists
  autocmd!
  autocmd BufNew *.md echom "Enabling Lists"
  autocmd BufEnter *.md ListsEnable
augroup END
