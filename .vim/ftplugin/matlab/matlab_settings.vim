" Execute matlab in tmux 
nnoremap <buffer> <leader>d :VimuxRunCommand("clc, <C-R>=expand("%:r")<CR>")<CR><CR>
" Execute Function prompting for input
nnoremap <leader>vf :VimuxRunCommand("clc, <C-R>=expand("%:r")<CR>()")<Left><Left><Left>
" Current variables
nnoremap <buffer> <leader>tb :VimuxRunCommand("clc, whos")<CR><CR>
" Code checker as mlint
if len(serverlist()) > 1
    nmap <buffer> <leader>w :w<CR>:AsyncMake<CR><leader>d
else
    nmap <buffer> <leader>w :w<CR>:make<CR><leader>d
endif
