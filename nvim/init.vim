" Load plugins
runtime ./plug.vim

" => Functions
" ------------

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" => General
" ----------

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Colorscheme
colorscheme NeoSolarized

" Enable filetype plugins
filetype plugin on
filetype indent on

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

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
set termguicolors
set tw=500
set updatetime=300
set wildmenu
set wrap

" 1 tab = 2 spaces
set shiftwidth=4
set softtabstop=0
set tabstop=4

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

syntax on " Enable syntax highlighting

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Include keymappings
runtime ./maps.vim
