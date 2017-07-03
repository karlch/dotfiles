" Settings for python

" {{{ JEDI
" Do not let jedi show the stupid window on autocomplete
let g:jedi#auto_vim_configuration=0
setlocal completeopt=menuone,longest
" Do not show call signatures (sad, but just too slow...)
let g:jedi#show_call_signatures = 2
let g:jedi#show_call_signatures_delay = 0
let g:jedi#popup_select_first = 1
let g:jedi#popup_on_dot = 1
" The Key mappings for jedi
let g:jedi#completions_command = "<C-Space>"
let g:jedi#goto_assignments_command = "<Nop>"
let g:jedi#goto_command = "gd"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#usages_command = "gu"
let g:jedi#rename_command = "<leader>r"
" }}}

" Tmux version for running python
nnoremap <buffer> <leader>d :VimuxRunCommand("python <C-R>=expand("%:t")<CR>")<CR>
nmap <buffer> <leader>p :VimuxRunCommand("python")<CR><C-l>

" SuperTab for jedi completion
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Sorting code quickly (great for imports)
nnoremap <buffer> <leader>s :sort<CR>
vnoremap <buffer> <leader>s :sort<CR>

" insert a organizing line
nnoremap <buffer> <leader>i 80i#<Esc>o# <Esc>

" Nested quotes for python
let b:delimitMate_nesting_quotes = ['"']
set complete+=k~/.vim/dictionary/python_snippets

" Neomake
let g:neomake_python_enabled_makers = ['pyflakes']
let g:neomake_python_pycodestyle_args = ['--max-line-length=80']
let g:neomake_verbose = 1

nnoremap <buffer> <leader>a :call CheckAll()<CR>
function! CheckAll()
    let g:neomake_python_enabled_makers = ['pycodestyle', 'pyflakes', 'pylint']
    write
    let g:neomake_python_enabled_makers = ['pyflakes']
endfunction

" vim:foldmethod=marker:foldlevel=0
