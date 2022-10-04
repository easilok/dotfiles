set nocompatible              " be iMproved, required
filetype off                  " required

" This script contains plugin specific settings
source ~/.config/nvim/plugins.vim

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set shiftround
set softtabstop=4               " number of spaces in tab when editing
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" set lazyredraw                  " redraw only when need to.
set wildmenu                    " visual autocomplete for command menu

"buffers
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" This script contains windows layout settings
source ~/.config/nvim/layout.vim

" This script contains filetype settings
source ~/.config/nvim/file_opt.vim

" This script contains keybindings layout settings
source ~/.config/nvim/keybindings.vim

set autoread

source ~/.config/nvim/lsp/init.vim
source ~/.config/nvim/plugin-config/init.vim


if has('termguicolors')
  set termguicolors
endif

" For per folder vim-settings
set exrc
set secure
