" Execute mathematica in tmux 
nnoremap <leader>d :VimuxRunCommand("<<<C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR>")<CR><CR>

" Run Mathematica in vim
nnoremap <CR> v0o$h"my:VimuxRunCommand(";<C-R>m")<CR>
