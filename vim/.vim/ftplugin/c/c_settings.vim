" Larger textwidth for cpp
set textwidth=100

" Run Program
nnoremap <buffer> <leader>d :VimuxRunCommand("./<C-R>=expand("%:t:r")<CR>")<CR><CR>

" Run Compiler
nnoremap <buffer> <leader>a :Neomake!<CR>

" Run root
nnoremap <buffer> <leader>r :VimuxRunCommand("root -l <C-R>=expand("%")<CR>")<CR><CR>
nnoremap <buffer> <leader>s :VimuxRunCommand(".q")<CR><CR>

" vim-clang
let g:clang_cpp_options = '-pthread -std=c++1y -m64 -lm -ldl'

let g:clang_format_style = 'WebKit'
let g:clang_cpp_completeopt = 'menuone,longest'
let g:clang_diagsopt = ''

" CPP Highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Neomake
let g:neomake_verbose = 1

let g:neomake_cpp_clang_maker = {
    \ 'exe': 'clang++',
    \ 'args': ['-Wall',
    \          '-Wextra',
    \          '-lm',
    \          '-ldl',
    \          '-m64',
    \          '-o%:t:r',
    \          '-pedantic'],
    \ 'errorformat': '%E%f:%l:%c: fatal error: %m,' .
    \                '%E%f:%l:%c: error: %m,' .
    \                '%W%f:%l:%c: warning: %m,' .
    \                '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
    \                '%E%m'
    \ }
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_c_enabled_makers = ['clang']
