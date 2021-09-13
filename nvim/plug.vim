call plug#begin(stdpath('data') . '/plugged')
    " General
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " Colors
    Plug 'overcache/NeoSolarized'

    if has('nvim')
        Plug 'hoob3rt/lualine.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
        Plug 'windwp/nvim-autopairs'
    endif
call plug#end()
