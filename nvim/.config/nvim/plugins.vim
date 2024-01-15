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
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'

" Plug 'glepnir/lspsaga.nvim'
" Plug 'rinx/lspsaga.nvim'
" Plug 'tami5/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'nvim-treesitter/playground'
Plug 'liuchengxu/vista.vim'

Plug 'folke/which-key.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'nvim-neo-tree/neo-tree.nvim'
" Plug 'MunifTanjim/nui.nvim' " required by neo-tree
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

" Wiki
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'
Plug 'lervag/lists.vim'
" Wiki addons
Plug 'itchyny/calendar.vim'
" fzf for searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Live markdown preview
" Plug 'shime/vim-livedown'
" Plug 'instant-markdown/vim-instant-markdown', {'for': ['markdown', 'wiki'], 'do': 'yarn install'}
Plug 'easilok/vim-instant-markdown', {'for': ['markdown', 'wiki'], 'do': 'yarn install', 'branch' : 'wiki-filetype'}

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Pattern based text background colorizer
Plug 'solyarisoftware/Highlight.vim'

Plug 'eliba2/vim-node-inspect'

Plug 'metakirby5/codi.vim'

Plug 'mbbill/undotree'

Plug 'notjedi/nvim-rooter.lua'

" Managing auto session creator
Plug 'tpope/vim-obsession'

" Database interface
" Plug 'tpope/vim-dadbod'
" Plug 'kristijanhusak/vim-dadbod-ui'

" Plug 'github/copilot.vim'
Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
" Plug 'eandrju/cellular-automaton.nvim'

" Plug 'vlime/vlime', {'rtp': 'vim/'}

Plug 'AndrewRadev/linediff.vim'

Plug 'skywind3000/asyncrun.vim'

" Open bif files without crashing neovim
Plug 'LunarVim/bigfile.nvim'

" Plug 'freitass/todo.txt-vim'
" Plug 'arnarg/todotxt.nvim'
" " Required by todotxt.nvim
" Plug 'MunifTanjim/nui.nvim'

Plug '~/.config/nvim/easilok'

" Initialize plugin system
call plug#end()

