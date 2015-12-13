" Run Program
nnoremap <buffer> <leader>d :VimuxRunCommand("./<C-R>=expand("%:t:r")<CR>")<CR><CR>

" Run Compiler
if len(serverlist()) > 1
    nnoremap <buffer> <leader>w :w<CR>:AsyncMake<CR>
else
    nnoremap <buffer> <leader>w :w<CR>:make<CR>
endif
