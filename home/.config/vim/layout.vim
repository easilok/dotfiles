" colorscheme monokai-bold
" colorscheme xcodedark
" colorscheme darcula
" colorscheme minimalist
" colorscheme badwolf
" colorscheme challenger_deep
colorscheme one

" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
set statusline+=%{gutentags#statusline()}
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
set background=dark
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

"Line numbers
set number
set relativenumber
set cursorline                  " hightligh current line
set modelines=1

highlight ColorColumn ctermbg=0 guibg=#1b1b1b
