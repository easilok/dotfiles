set nocompatible              " be iMproved, required
filetype off                  " required

" This script contains plugin specific settings
source ~/.vim/plugins.vim

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
set lazyredraw                  " redraw only when need to.
set wildmenu                    " visual autocomplete for command menu

"buffers
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" This script contains windows layout settings
source ~/.vim/layout.vim

" This script contains filetype settings
source ~/.vim/file_opt.vim

" This script contains keybindings layout settings
source ~/.vim/keybindings.vim

" set autowrite 1
" set autowriteall
set autoread

"if !empty(glob("workspace.vim"))
" if filereadable(expand("./workspace.vim"))
"   silent source ./workspace.vim
" endif

if has('nvim') 
  luafile ~/.config/nvim/plugin-config/treesitter-config.lua
  luafile ~/.config/nvim/plugin-config/which-key-config.lua
  luafile ~/.config/nvim/plugin-config/config.lua
  luafile ~/.config/nvim/plugin-config/xit.lua
  luafile ~/.config/nvim/lsp/compe-config.lua
  luafile ~/.config/nvim/lsp/lspsaga-config.lua
  luafile ~/.config/nvim/plugin-config/telescope.lua
  source ~/.config/nvim/plugin-config/harpoon.vim
  luafile ~/.config/nvim/plugin-config/dap.lua
  luafile ~/.config/nvim/plugin-config/todo-comments.lua
  " LSP: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  source ~/.config/nvim/lsp/lsp-config.vim
  " Override lsp keymap
  source ~/.config/nvim/lsp/lspsaga-config.vim
  luafile ~/.config/nvim/lsp/javascript-ls.lua
  luafile ~/.config/nvim/lsp/php-ls.lua
  luafile ~/.config/nvim/lsp/python-ls.lua
  luafile ~/.config/nvim/lsp/latex-ls.lua
  luafile ~/.config/nvim/lsp/go-ls.lua
  luafile ~/.config/nvim/lsp/css-ls.lua
  luafile ~/.config/nvim/lsp/svelte-ls.lua
  luafile ~/.config/nvim/lsp/ccls-ls.lua
  luafile ~/.config/nvim/lsp/arduino-ls.lua
  luafile ~/.config/nvim/lsp/docker-ls.lua
  luafile ~/.config/nvim/lsp/yaml-ls.lua
endif
if has('nvim') || has('termguicolors')
  set termguicolors
endif

if has("gui_running")
  if has("gui_win32")
    set guifont=Ubuntu_Mono_derivative_Powerlin:h9:cANSI:qDRAFT
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fixes mouse issues using Alacritty terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (!has('nvim'))
    set ttymouse=sgr
endif

" For per folder vim-settings
set exrc
set secure
