""""""""""""
" plugins
""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dracula/vim'
    Plug 'honza/vim-snippets'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdcommenter'
    Plug 'SirVer/ultisnips'
call plug#end()


""""""""""""""""""
" general config
""""""""""""""""""
" enable filetype plugins
filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on

set autoindent              
set autoread                
set clipboard=unnamedplus   
set encoding=utf8
set expandtab               
set ffs=unix,dos,mac
set hlsearch                
set ignorecase              
set incsearch               
set lazyredraw              
set lbr
set magic                   
set mouse=a                 
set mouse=v                 
set nobackup
set nocompatible            
set noerrorbells            
set noswapfile              
set novisualbell
set nowb
set number
set number                  
set relativenumber
set ruler                   
set shiftwidth=4            
set showmatch               
set smartcase               
set so=999                  
set softtabstop=4           
set tabstop=4               
set tm=500
set tw=100
set ttyfast                 
set wildmode=longest,list   
set wrap

" line number toggle
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" ignore compiled files
set wildignore=*.o,*~,*.pyc

if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

""""""""""""""""""
" optional config
"""""""""""""""""" 
" enable spell check (may need to download language package)
" set spell                 

syntax on " syntax highlighting

""""""""""""""
" appearance
""""""""""""""
if (has("termguicolors"))
    set termguicolors
endif

colorscheme dracula

" dark background
set bg=dark

" transparent background
hi Normal ctermbg=None

" command bar height
set cmdheight=1             

" highlight cursor line
set cursorline              

""""""""""""""
" keybindings
""""""""""""""
" custom leader key
let mapleader="\<Tab>"

" fast saving
nmap <C-S> :up<CR>
vmap <C-S> <C-C>:up<CR>
imap <C-S> <C-O>:up<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null"

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>"

" map space to / (search)
map <space> /

" map ctrl+space to ? (backwards search)
map <C-space> ?

" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" window/split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" close current buffer
map <leader>bd :bd<cr>

" close all buffer
map <leader>ba :bufdo bd<cr>

" buffer navigation
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

" toggle last accessed tab
let g:lasttab = 1
nmap <leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" open new tab with current buffer path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" quickly open buffer for quick notes
map <leader>q :e ~/buffer<cr>
map <leader>x :e ~/buffer.md<cr>

""""""""""""""""""""""""""
" plugin-specific config
""""""""""""""""""""""""""

" => nerdtree
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
