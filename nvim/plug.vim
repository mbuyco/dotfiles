call plug#begin(stdpath('data') . '/plugged')
    " General
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'

    " Colors
    Plug 'overcache/NeoSolarized'
    Plug 'joshdick/onedark.vim'

    if has('nvim')
        Plug 'neovim/nvim-lspconfig'
        Plug 'hoob3rt/lualine.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
        Plug 'windwp/nvim-autopairs'
    endif
call plug#end()
