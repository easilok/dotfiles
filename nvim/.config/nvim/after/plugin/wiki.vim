augroup EnableLists
  autocmd!
  autocmd BufNew *.md echom "Enabling Lists"
  autocmd BufEnter *.md ListsEnable
augroup END
