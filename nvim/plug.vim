call plug#begin(stdpath('data') . '/plugged')
    " General
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'hashivim/vim-terraform'
    Plug 'mattn/emmet-vim'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'posva/vim-vue'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'vimwiki/vimwiki'
    Plug 'jwalton512/vim-blade'

    " Colors
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'joshdick/onedark.vim'
    Plug 'mhartington/oceanic-next'
    Plug 'morhetz/gruvbox'
    Plug 'overcache/NeoSolarized'
    Plug 'sainnhe/everforest'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'tomasiser/vim-code-dark'
    Plug 'tribela/vim-transparent'
    Plug 'vigoux/oak'

    if has('nvim')
        Plug 'hoob3rt/lualine.nvim'
        Plug 'ibhagwan/fzf-lua'
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
        Plug 'windwp/nvim-autopairs'
    endif
call plug#end()
