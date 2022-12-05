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

" To able to SudoEdit
" Shell Commands
" Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-abolish'

" Adds objects and N objects
Plug 'wellle/targets.vim'

"Surround
Plug 'tpope/vim-surround'

Plug 'mhinz/vim-startify'
" latex
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

Plug 'christoomey/vim-tmux-navigator'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'

" Plug 'glepnir/lspsaga.nvim'
" Plug 'rinx/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'nvim-treesitter/playground'
Plug 'folke/which-key.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'kyazdani42/nvim-tree.lua'
" NerdTree
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" map <F6> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" let NERDTreeShowLineNumbers = 1
" let NERDTreeShowHidden = 1
" let NERDTreeMinimalUI = 1
" let g:netrw_menu  = 0

" debugging
Plug 'mfussenegger/nvim-dap'
" Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Prettier
Plug 'sbdchd/neoformat'
let g:neoformat_try_node_exe = 1 " Use project installed prettier
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
" let g:neoformat_javascript_prettier = {
"       \ 'args': ['--config .prettierrc.json'],
"       \ }

" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Wiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/Nextcloud/vimwiki',
                      \ 'syntax': 'markdown', 'ext': '.wiki'}]

" Live markdown preview
" Plug 'shime/vim-livedown'
Plug 'instant-markdown/vim-instant-markdown'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Pattern based text background colorizer
Plug 'solyarisoftware/Highlight.vim'

Plug 'eliba2/vim-node-inspect'

Plug 'metakirby5/codi.vim'

Plug 'mbbill/undotree'

" Initialize plugin system
call plug#end()

