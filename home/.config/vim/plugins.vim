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
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/gv.vim'
" plugin for jumping to conflicts
Plug 'tpope/vim-unimpaired'

"colorscheme
" Plug 'flazz/vim-colorschemes'
" Plug 'doums/darcula'
" Plug 'arzg/vim-colors-xcode'
" Plug 'Mcmartelle/vim-monokai-bold'
" Plug 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
" Plug 'rakr/vim-one'
" Plug 'dracula/vim'
" Plug 'taniarascia/new-moon.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'gruvbox-community/gruvbox'
Plug 'rafi/awesome-vim-colorschemes'

"Commentary
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'

" To able to SudoEdit
" Shell Commands
Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-abolish'

" Adds objects and N objects
Plug 'wellle/targets.vim'
" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <F6> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let g:netrw_menu  = 0
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Coloresque
Plug 'ap/vim-css-color'
"Surround
Plug 'tpope/vim-surround'
" Bottom bar
Plug 'itchyny/lightline.vim'
" let g:lightline = {'colorscheme': 'wombat',}
let g:lightline = {'colorscheme': 'one',}

Plug 'mengelbrecht/lightline-bufferline'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#number_separator = '#'
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#icon_position = 'first'
let g:lightline#bufferline#shorten_path = 0
set showtabline=2
" let g:lightline                  = {}
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.tabline          = {'left': [['buffers']]}
let g:lightline.active           = {'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline.component_function = { 'gitbranch': 'FugitiveHead', 'filename':  'LightlineFilename'} " needs vim vim-fugitive

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

Plug 'airblade/vim-gitgutter'

Plug 'mhinz/vim-startify'
" latex
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plug 'christoomey/vim-tmux-navigator'

if has('nvim') 
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    " Plug 'glepnir/lspsaga.nvim'
    " Plug 'rinx/lspsaga.nvim'
    Plug 'tami5/lspsaga.nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/nvim-treesitter-context'
    " Plug 'nvim-treesitter/playground'
    Plug 'folke/which-key.nvim'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'synaptiko/xit.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ThePrimeagen/harpoon'

    " debugging
    Plug 'mfussenegger/nvim-dap'
    " Plug 'leoluz/nvim-dap-go'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'nvim-telescope/telescope-dap.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'L3MON4D3/LuaSnip'

    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
else
    Plug 'ajh17/VimCompletesMe' 
    Plug 'sheerun/vim-polyglot'
    Plug 'natebosch/vim-lsc'

    let g:lsc_server_commands = {
        \ 'python': ['~/.local/bin/pyls'],
        \ 'javascript': ['/usr/bin/typescript-language-server', '--stdio'],
        \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
        \ }

    " Complete default mappings are:
    let g:lsc_auto_map = {
        \ 'GoToDefinition': 'gd',
        \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
        \ 'FindReferences': 'gr',
        \ 'NextReference': '<C-n>',
        \ 'PreviousReference': '<C-p>',
        \ 'FindImplementations': 'gI',
        \ 'FindCodeActions': 'ga',
        \ 'Rename': 'gR',
        \ 'ShowHover': v:true,
        \ 'DocumentSymbol': 'go',
        \ 'WorkspaceSymbol': 'gS',
        \ 'SignatureHelp': 'gm',
        \ 'Completion': 'completefunc',
        \}

    " fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'ryanolsonx/vim-xit'
    Plug 'ryanoasis/vim-devicons'

    Plug 'ludovicchabant/vim-gutentags'

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " `my_snippets` is the directory we created before
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
    " Trigger configuration. Do not use <tab> if you use
    " https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger='<tab>'

    " shortcut to go to next position
    let g:UltiSnipsJumpForwardTrigger='<c-j>'

    " shortcut to go to previous position
    let g:UltiSnipsJumpBackwardTrigger='<c-k>'

    Plug 'catppuccin/vim', { 'as': 'catppuccin' }

endif

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
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Pattern based text background colorizer
Plug 'solyarisoftware/Highlight.vim'

Plug 'eliba2/vim-node-inspect'

" Initialize plugin system
call plug#end()

