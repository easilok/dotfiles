" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> -d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> -D <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> -r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> -i <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> -K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-h> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ]d <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> [d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <space>e <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> -f <cmd>lua vim.lsp.buf.format({async = true})<CR>
nnoremap <silent> <space>ws <cmd>lua vim.lsp.workspace_symbol()<CR>

" auto-format
" autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.js Neoformat prettier
autocmd BufWritePre *.jsx Neoformat prettier
autocmd BufWritePre *.tsx Neoformat prettier
autocmd BufWritePre *.ts Neoformat prettier
autocmd BufWritePre *.css lua vim.lsp.buf.format({async = true})
autocmd BufWritePre *.scss lua vim.lsp.buf.format({async = true})

" Add lsp diagnostic messages to quickfix list
" By Primeagen
fun! LspLocationList()
  " lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
  lua vim.diagnostic.setloclist({open = false})
endfun

nnoremap <space>qll :call LspLocationList()<CR>

" augroup LSP_AUTO_COMMANDS
"   autocmd!
"   autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
" augroup END
