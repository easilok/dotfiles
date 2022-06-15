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

" Show all open buffers and their status
nmap <leader>bl :ls<CR>


if has('nvim') 
  nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
  nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <leader>fb <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending"})<cr>
  nnoremap <leader>gl <cmd>lua require('telescope.builtin').live_grep()<cr>
  nnoremap <leader>gs <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<cr>
  nnoremap <leader>gw <cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<cr>
  nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>bl <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader>ge <cmd>lua require('telescope.builtin').diagnostics()<cr>
  nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
  nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
  nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
  nnoremap <leader>ga <cmd>Telescope harpoon marks<cr>
else 
  "Fzf
  nmap <Leader>fg :GFiles<CR>
  nmap <Leader>Ff :Files<CR>
  nmap <Leader>fb :Buffers<CR>
  nmap <Leader>gh :History<CR>
  nmap <Leader>gt :BTags<CR>
  nmap <Leader>gT :Tags<CR>
endif


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
vnoremap K :m '>-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
" nnoremap <leader>j :m .+1<CR>==
" nnoremap <leader>k :m .-1<CR>==
" End of Primeagen TOP 5 maps

map <F7> :Explore<CR>
