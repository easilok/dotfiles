let g:wiki_root = '~/Nextcloud/vimwiki'

let g:wiki_export = {
            \ 'args' : '-V papersize=A4 -V geometry:margin=1in -V mainfont="Arial" --number-sections',
            \ 'from_format' : 'markdown',
            \ 'ext' : 'pdf',
            \ 'link_ext_replace': v:false,
            \ 'view' : v:false,
            \ 'output': fnamemodify(tempname(), ':h'),
            \}
