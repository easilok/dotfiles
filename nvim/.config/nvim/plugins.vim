call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/gv.vim'
" Plug 'junegunn/vim-peekaboo'
" plugin for jumping to conflicts
Plug 'tpope/vim-unimpaired'

"Commentary
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'

" To able to SudoEdit and use Shell Commands
Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-abolish'

" Adds objects and N objects
Plug 'wellle/targets.vim'

"Surround
Plug 'tpope/vim-surround'

Plug 'tpope/vim-endwise'


" Plug 'mhinz/vim-startify'
" latex
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

Plug 'christoomey/vim-tmux-navigator'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
Plug 'folke/trouble.nvim'

Plug 'ray-x/lsp_signature.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'nvim-treesitter/playground'
Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git'

let g:finder_plugin = 'fzflua'
" let g:finder_plugin = 'telescope'
Plug 'folke/which-key.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'stevearc/oil.nvim'

" debugging
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'williamboman/mason.nvim'
Plug 'jay-babu/mason-nvim-dap.nvim'

Plug 'folke/todo-comments.nvim'
" TODO: The after update hook is always failing
" Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*'}
" This one should be removed after my own snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'
Plug 'srt0/codescope.nvim'

" Prettier
Plug 'sbdchd/neoformat'

" fzf for searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Wiki
Plug 'lervag/wiki.vim'
Plug 'lervag/lists.vim'
" Wiki addons
Plug 'itchyny/calendar.vim'
" Obsidian
Plug 'epwalsh/obsidian.nvim'


" Live markdown preview
" Plug 'instant-markdown/vim-instant-markdown', {'for': ['markdown', 'wiki'], 'do': 'yarn install'}
Plug 'easilok/vim-instant-markdown', {'for': ['markdown', 'wiki'], 'do': 'npm install', 'branch' : 'wiki-filetype'}
Plug 'MeanderingProgrammer/markdown.nvim'

Plug 'godlygeek/tabular'

" Pattern based text background colorizer
Plug 'solyarisoftware/Highlight.vim'

Plug 'mbbill/undotree'

Plug 'notjedi/nvim-rooter.lua'

" Managing auto session creator
Plug 'tpope/vim-obsession'

" Database interface
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak//vim-dadbod-completion', {'for': ['sql', 'mysql', 'plsql'] }

" Plug 'sindrets/diffview.nvim'
Plug 'AndrewRadev/linediff.vim'
Plug 'mechatroner/rainbow_csv'

Plug 'skywind3000/asyncrun.vim'

" Open bif files without crashing neovim
Plug 'LunarVim/bigfile.nvim'

Plug 'folke/zen-mode.nvim'

" Tags
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'quangnguyen30192/cmp-nvim-tags'

" Triage plugins
Plug 'j-morano/buffer_manager.nvim'
Plug 'dstein64/vim-startuptime'
" lsp replacement
Plug 'pmizio/typescript-tools.nvim'

" repl
Plug 'Olical/conjure'
Plug 'PaterJason/cmp-conjure'

Plug '~/.config/nvim/lua/easilok'

" Initialize plugin system
call plug#end()

