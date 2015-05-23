" Execute matlab in tmux 
nnoremap <leader>d :VimuxRunCommand("<C-R>=expand("%:r")<CR>")<CR><CR>
" Current variables
nnoremap <leader>tb :VimuxRunCommand("clc, whos")<CR><CR>
" Code checker as mlint
" nnoremap <leader>w :VimuxRunCommand("mlint <C-R>=expand("%:r")<CR>")<CR><CR>
nnoremap <leader>w :w<CR>:AsyncMake<CR>
nnoremap <leader>W :copen<CR>
