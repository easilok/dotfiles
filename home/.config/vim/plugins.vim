" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'junegunn/gv.vim'

"colorscheme
" Plugin 'flazz/vim-colorschemes'
" Plugin 'doums/darcula'
" Plugin 'arzg/vim-colors-xcode'
" Plugin 'Mcmartelle/vim-monokai-bold'
" Plugin 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
Plugin 'rakr/vim-one'

"Commentary
Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-repeat'

" To able to SudoEdit
" Shell Commands
Plugin 'tpope/vim-eunuch'

Plugin 'tpope/vim-abolish'

" Adds objects and N objects
Plugin 'wellle/targets.vim'
" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let g:netrw_menu  = 0
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plugin 'ryanoasis/vim-devicons'

"Coloresque
Plugin 'gorodinskiy/vim-coloresque'
"Surround
Plugin 'tpope/vim-surround'
" Bottom bar
Plugin 'itchyny/lightline.vim'
" let g:lightline = {'colorscheme': 'wombat',}
let g:lightline = {'colorscheme': 'challenger_deep',}

Plugin 'mengelbrecht/lightline-bufferline'
set showtabline=2
let g:lightline                  = {}
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.tabline          = {'left': [['buffers']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" fzf
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

Plugin 'sheerun/vim-polyglot'

Plugin 'ludovicchabant/vim-gutentags'
Plugin 'ajh17/VimCompletesMe' 

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" `my_snippets` is the directory we created before
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

Plugin 'airblade/vim-gitgutter'

Plugin 'mhinz/vim-startify'
" latex
Plugin 'lervag/vimtex'
let g:tex_flavor = 'latex'

Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plugin 'christoomey/vim-tmux-navigator'

if has('nvim') 
    Plugin 'neovim/nvim-lspconfig'
    Plugin 'hrsh7th/nvim-compe'
else
    Plugin 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    " Automatically start language servers.
    let g:LanguageClient_autoStart = 1

    let g:LanguageClient_serverCommands = {
        \ 'python': ['~/.local/bin/pyls'],
        \ 'javascript': ['/usr/bin/typescript-language-server', '--stdio'],
        \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
        \ }

    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

endif

" Use release branch (recommend)
" Plugin 'neoclide/coc.nvim', {'branch': 'release'}
" Wiki
Plugin 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '/mnt/coisas/nextcloud/vimwiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
