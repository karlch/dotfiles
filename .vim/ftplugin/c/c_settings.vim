" Run Program
nnoremap <leader>d :VimuxRunCommand("./<C-R>=expand("%:t:r")<CR>")<CR><CR>
" Run Compiler
if len(serverlist()) > 1
    nnoremap <leader>w :w<CR>:AsyncMake<CR>
else
    nnoremap <leader>w :w<CR>:make<CR>
endif
