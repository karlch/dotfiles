" Execute matlab in tmux 
nnoremap <leader>d :VimuxRunCommand("<C-R>=expand("%:r")<CR>")<CR><CR>
" Current variables
nnoremap <leader>tb :VimuxRunCommand("clc, whos")<CR><CR>
" Code checker as mlint
if len(serverlist()) > 1
    nnoremap <leader>w :w<CR>:AsyncMake<CR>
else
    nnoremap <leader>w :w<CR>:make<CR>
endif
