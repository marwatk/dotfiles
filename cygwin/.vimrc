call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'vim-perl/vim-perl'
Plug 'janko-m/vim-test'
"Plug 'lucastheisen/vim-test'
"Plug '~/git/pastdev-vim-test'
Plug 'krisajenkins/vim-projectlocal'
Plug 'pangloss/vim-javascript'
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-git'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'hinrik/color-scheme-literal-tango'
Plug 'thinca/vim-prettyprint'

call plug#end()

colorscheme literal_tango

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set number

autocmd FileType xml set tabstop=2|set softtabstop=2|set shiftwidth=2
autocmd FileType html set tabstop=2|set softtabstop=2|set shiftwidth=2
autocmd FileType xhtml set tabstop=2|set softtabstop=2|set shiftwidth=2

nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <tab> <C-w><C-w>

