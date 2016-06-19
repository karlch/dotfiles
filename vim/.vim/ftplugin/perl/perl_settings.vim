" Settings for perl

" Tmux version for running perl scripts
nnoremap <buffer> <leader>d :VimuxRunCommand("perl <C-R>=expand("%:t")<CR>")<CR>
