" Execute matlab in tmux 
nnoremap <buffer> <leader>d :VimuxRunCommand("<C-R>=expand("%:r")<CR>")<CR><CR>
" Current variables
nnoremap <buffer> <leader>tb :VimuxRunCommand("clc, whos")<CR><CR>
" Code checker as mlint
if len(serverlist()) > 1
    nnoremap <buffer> <leader>w :w<CR>:AsyncMake<CR>
else
    nnoremap <buffer> <leader>w :w<CR>:make<CR>
endif
