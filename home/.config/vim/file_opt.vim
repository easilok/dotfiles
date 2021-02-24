filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml,tpl setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS
au Filetype sql setl ofu=sqlcomplete#CompleteSQL
au Filetype javascript setl ofu=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.tpl set syntax=html
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.tex setlocal spell
" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }
