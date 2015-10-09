" Execute mathematica in tmux 
nnoremap <buffer> <leader>D :VimuxRunCommand("<<<C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR>")<CR><CR>
nnoremap <buffer> <leader>d v0o$h"my:VimuxRunCommand(";<C-R>m")<CR>

" Run Mathematica in vim
nnoremap <buffer> <CR> yyp:.! math<CR>V/In\[2\]<CR>:g /^$/d<CR>gv:g /in/d<CR>:g /Math/d<CR>:%s /Out\[1\]/Out <CR>

" Neat notebook
" let g:notebook_cmd='{ script -c wolfram /dev/null; }'
" let g:notebook_stop="Quit"
" let g:notebook_send0=""
" let g:notebook_send='Print []; Print [ \"VIMWOLFRAMNOTEBOOK\" ]; Print []'
" let g:notebook_detect='VIMWOLFRAMNOTEBOOK'
"
" nnoremap <buffer> <CR> :NotebookEvaluate<CR>
