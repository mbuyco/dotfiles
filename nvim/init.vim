" Load plugins
runtime ./plug.vim

" => General
" ----------

" Return to last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Colorscheme
colorscheme oak

" Enable filetype plugins
filetype plugin on
filetype indent on

" Transparent background
hi Normal ctermbg=None

let mapleader = "\<Tab>" " Set the clipboard as the default register 

set autoindent
set autoread
set background=dark
set clipboard=unnamed
set cmdheight=1
set cursorline
set encoding=utf-8
set expandtab
set ffs=unix,dos,mac
set hidden
set history=500
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set lbr
set magic
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set noswapfile
set novisualbell
set nowb
set number relativenumber
set ruler
set shortmess+=c
set si
set smartcase
set smarttab
set so=999
set t_Co=256
set tw=500
set updatetime=300
set wildmenu
set wrap

if (has("termguicolors"))
    set termguicolors
endif

" 1 tab = 2 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

syntax on " Enable syntax highlighting

" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Include keymappings
runtime ./maps.vim
