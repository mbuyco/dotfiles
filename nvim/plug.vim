call plug#begin(stdpath('data') . '/plugged')
    " General
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'jiangmiao/auto-pairs'
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'

    " Colors
    Plug 'joshdick/onedark.vim'
    Plug 'overcache/NeoSolarized'

    if has('nvim')
        Plug 'hoob3rt/lualine.nvim'
        Plug 'ibhagwan/fzf-lua'
        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'neovim/nvim-lspconfig'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    endif
call plug#end()
