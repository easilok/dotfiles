let g:neoformat_try_node_exe = 1 " Use project installed prettier
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
" let g:neoformat_javascript_prettier = {
"       \ 'args': ['--config .prettierrc.json'],
"       \ }
let g:neoformat_python_black = {
    \ 'exe': 'black',
    \ 'stdin': 1,
    \ 'args': ['-l 120', '-q', '-'],
    \ }

" let g:neoformat_enable_python = ['black']
" let g:neoformat_verbose = 1 " Enable neorformat debug
