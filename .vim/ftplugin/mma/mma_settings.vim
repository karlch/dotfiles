" Execute mathematica in tmux 
nnoremap <buffer> <leader>D :VimuxRunCommand("<<<C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR>")<CR><CR>
nnoremap <buffer> <leader>d v0o$h"my:VimuxRunCommand(";<C-R>m")<CR>

" Run Mathematica in vim
nnoremap <buffer> <CR> yyp:.! math<CR>V/In\[2\]<CR>:g /^$/d<CR>gv:g /in/d<CR>:g /Math/d<CR>:%s /Out\[1\]/Out <CR>

" do not use ä ö and ü
inoremap <buffer> ä (
inoremap <buffer> ö [
inoremap <buffer> ü {
inoremap <buffer> Ä )
inoremap <buffer> Ö ]
inoremap <buffer> Ü }
