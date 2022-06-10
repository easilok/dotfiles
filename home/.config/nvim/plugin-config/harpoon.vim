nnoremap <silent><leader>aa :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><leader>tq :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><M-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><M-j> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><M-k> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><m-l> :lua require("harpoon.ui").nav_file(4)<CR>
