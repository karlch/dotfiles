" Run Program
nnoremap <buffer> <leader>d :VimuxRunCommand("./<C-R>=expand("%:t:r")<CR>")<CR><CR>

" Run Compiler
nnoremap <buffer> <leader>a :Neomake!<CR>

" Clang settings
let g:clang_complete_auto = 1
let g:clang_auto_select = 1
let g:clang_snippets = 0
" let g:clang_snippets_engine = 'ultisnips'
let g:clang_user_options = '-std=c++11'
" Errors
let g:clang_complete_copen = 0
let g:clang_periodic_quickfix = 0
" Clang keys
let g:clang_jumpto_declaration_key = "gd"
