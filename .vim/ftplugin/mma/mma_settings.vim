" Execute mathematica in tmux 
nnoremap <leader>D :VimuxRunCommand("<<<C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR>")<CR><CR>
nnoremap <leader>d v0o$h"my:VimuxRunCommand(";<C-R>m")<CR>

" Run Mathematica in vim
nnoremap <CR> yyp:.! math<CR>V/In\[2\]<CR>:g /^$/d<CR>gv:g /in/d<CR>:g /Math/d<CR>:%s /Out\[1\]/Out <CR>

" do not use ä ö and ü
inoremap ä (
inoremap ö [
inoremap ü {
inoremap Ä )
inoremap Ö ]
inoremap Ü }
