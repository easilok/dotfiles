" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> -d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> -D <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> -r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> -i <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent> <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <space>f <cmd>lua vim.lsp.buf.formatting()<CR>

" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.vue lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.go !gofmt -w %

" Add lsp diagnostic messages to quickfix list
" By Primeagen
fun! LspLocationList()
  " lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
  lua vim.diagnostic.setloclist({open = false})
endfun

nnoremap <leader>vll :call LspLocationList()<CR>

" augroup LSP_AUTO_COMMANDS
"   autocmd!
"   autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
" augroup END
