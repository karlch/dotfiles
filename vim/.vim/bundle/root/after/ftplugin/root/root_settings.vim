" Root maker for neomake
let errorformat = '' .
    \     '%-G%f:%s:,' .
    \     '%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,' .
    \     '%-G%f:%l: %#error: %#for each function it appears%.%#,' .
    \     '%-GIn file included%.%#,' .
    \     '%-G %#from %f:%l\,,' .
    \     '%f:%l:%c: %trror: %m,' .
    \     '%f:%l:%c: %tarning: %m,' .
    \     '%f:%l:%c: %m,' .
    \     '%f:%l: %trror: %m,' .
    \     '%f:%l: %tarning: %m,'.
    \     '%f:%l: %m'

let g:neomake_cpp_root_maker = {
    \ 'exe': 'root',
    \ 'args': ['-q', '-l', '-b'],
    \ 'errorformat': errorformat
    \ }

" Back to cpp when everything has loaded
set filetype=cpp
let g:neomake_cpp_enabled_makers = ['root']

" Run Program
nnoremap <buffer> <leader>d :VimuxRunCommand("root -l <C-R>=expand("%")<CR>")<CR><CR>
nnoremap <buffer> <leader>r :VimuxRunCommand(".q")<CR><CR>

" Dictionary
set dictionary+=~/.vim/dictionary/root
set complete+=k~/.vim/dictionary/root

let g:clang_complete_auto = 1
let g:clang_auto_select = 1

" Add the complete file if it isn't there
" silent !cp ~/.vim/bundle/root/after/ftplugin/root/clang_complete .clang_complete
