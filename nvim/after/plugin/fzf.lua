vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<c-F>',
    "<cmd>lua require('fzf-lua').live_grep_glob({ glob = '!{node_modules/*,.git/*}' })<CR>",
    { noremap = true, silent = true })
