" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
" nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>k :bprevious<CR>

" Toggle between buffers
nmap <leader>bb :b #<CR> 

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
" Removed to use the quicklist shortcuts in this place
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
noremap <C-w><Left> :vertical resize +3<CR>
noremap <C-w><Right> :vertical resize -3<CR>
noremap <C-w><Up> :resize +3<CR>
noremap <C-w><Down> :resize -3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

map <Leader>- <C-w>_
map <Leader>< <C-w>\|
map <Leader>0 <C-w>=

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

map - <Nop>
map Q <Nop>

set pastetoggle=<F3>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

map <leader><space> :nohl<cr>
" replace selection
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>S :%s/\<<C-r><C-w>\>//g<Left><Left>

" Custom buffer switcher
nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

" Change motion keys to work with line wrapper
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
map <leader>wl :call ToggleWrap()<CR>

" Run markdown live preview
nmap gm :LivedownToggle<CR>

" Primeagen TOP 5 maps
" Behave VIM: makes Y behave like D and C
nnoremap Y y$
" Keeping cursor centered on search next work and concat lines
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <M-C-j> :cnext<CR>zzzv
nnoremap <M-C-k> :cprevious<CR>zzzv
" Add more undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap _ _<c-g>u
" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
" nnoremap <leader>j :m .+1<CR>==
" nnoremap <leader>k :m .-1<CR>==
" End of Primeagen TOP 5 maps

" copy to clipboard
nnoremap <leader>y  "+y
vnoremap <leader>y  "+y
nmap <leader>Y      "+Y
nnoremap <leader>p  "+p
vnoremap <leader>p  "+p
nmap <leader>P      "+P

" From prime. Paste above selected text without replacing buffer
xnoremap <leader>p "_dP

map <F7> :Explore<CR>

" define line highlight color
highlight LineHighlight ctermbg=darkgray guibg=darkgray
" highlight the current line
nnoremap <silent> <Space>ah :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Space>ch :call clearmatches()<CR>
nmap <Space>yfp :let @" = expand("%")<cr>

nnoremap <leader>gg :Git<CR>
nnoremap <leader>gf :Git fetch --all<CR>
