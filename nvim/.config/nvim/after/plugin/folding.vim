" This was setup on folding.lua file in order to use treesitter for context
" augroup myJsFolds
"     autocmd!
"     autocmd FileType javascript,javascriptreact,typescript,json echom "Run myJsFolds augroup after plugin"
"     autocmd FileType javascript,javascriptreact,typescript,json syntax region braceFold start="{" end="}" transparent fold
"     autocmd FileType javascript,javascriptreact,typescript,json syntax region bracketFold start="\[" end="\]" transparent fold
"     autocmd FileType javascript,javascriptreact,typescript,json syntax sync fromstart
"     autocmd FileType javascript,javascriptreact,typescript,json set foldmethod=syntax
" augroup end
