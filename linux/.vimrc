call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/taglist.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimawesome/taglist'
Plug 'tpope/vim-sensible'
Plug 'vim-perl/vim-perl'
Plug 'PProvost/vim-ps1'
Plug 'janko-m/vim-test'
Plug 'krisajenkins/vim-projectlocal'
Plug 'pangloss/vim-javascript'
"Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-git'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'thinca/vim-prettyprint'

Plug 'hinrik/color-scheme-literal-tango'
Plug 'nanotech/jellybeans.vim'

" Typescript
"Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'jason0x43/vim-js-indent'
Plug 'Quramy/vim-dtsm'
Plug 'mhartington/vim-typings'

call plug#end()

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
  colorscheme jellybeans
else 
  colorscheme literal_tango
endif

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set number

autocmd FileType xml set tabstop=2|set softtabstop=2|set shiftwidth=2
autocmd FileType html set tabstop=2|set softtabstop=2|set shiftwidth=2
autocmd FileType xhtml set tabstop=2|set softtabstop=2|set shiftwidth=2
autocmd FileType yaml set tabstop=2|set softtabstop=2|set shiftwidth=2

nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <tab> <C-w><C-w>

"Set window sizes for tag list and nerdtree
:let g:NERDTreeWinSize=30
:let g:Tlist_WinWidth=40
:let g:Tlist_Use_Right_Window=1

"Open nerdtree
"autocmd VimEnter * NERDTree
"autocmd VimEnter * TlistToggle
"autocmd VimEnter * wincmd l

"Prevent me from using arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"Ctrl+h to nerdtree
"nnoremap <C-h> <C-w>10h

"Ctrl+l to taglist
nnoremap <C-l> <C-w>10l

"Ctrl+o to CtrlP File Plugin
"nnoremap <C-o> :CtrlPBuffer<CR>
let g:ctrlp_map='<c-o>'

"Ctrl+p to CtrlP Buffer Plugin
nnoremap <C-p> :CtrlPBuffer<CR>
