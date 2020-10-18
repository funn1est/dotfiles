let mapleader = ' '
syntax enable
set mouse=a
set clipboard=unnamed

set spell spelllang=en_us

set autoread

set number
set relativenumber
set cursorline
set scrolloff=5

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set autoindent
set smartindent

set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set autochdir
set timeoutlen=300
set updatetime=50

set nobackup
set noswapfile
set undofile
set undodir=~/.vim/.undo//

" vim-plug
call plug#begin('~/.config/nvim/plugged')
" theme
Plug 'joshdick/onedark.vim'
" code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" others
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'dominikduda/vim_current_word'
Plug 'junegunn/vim-easy-align'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" key-mappings
inoremap jj <Esc>

nnoremap H ^
nnoremap L $

nnoremap U <C-r>

nnoremap Y y$

xnoremap < <gv
xnoremap > >gv

" reset cursor last file edited line
"augroup resCur
"  autocmd!
"  autocmd BufReadPost * call setpos(".", getpos("'\""))
"augroup END

" Plugin key-mappings.
" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" theme settings
colorscheme onedark
set background=dark
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
hi Normal guibg=NONE

if has('termguicolors')
  set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif
