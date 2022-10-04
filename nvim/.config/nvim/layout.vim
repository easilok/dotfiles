" colorscheme onedark
luafile ~/.config/nvim/plugin-config/theme.lua

set laststatus=2
" set statusline+=%{gutentags#statusline()}
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
" set noshowmode

"Line numbers
set number
set relativenumber
set cursorline                  " hightligh current line
set modelines=1
set list
set listchars=trail:-,tab:>\>

" highlight ColorColumn ctermbg=0 guibg=#1b1b1b
" highlight ColorColumn ctermbg=0 guibg=grey
" For transparency
highlight Normal ctermbg=NONE guibg=NONE

" Used this for st-terminal
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
