autocmd VimEnter * NERDTree | wincmd p

nnoremap <C-t> :NERDTreeToggle<CR>

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
