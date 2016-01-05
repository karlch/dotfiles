" Settings for python

" {{{ PYMODE
" And disable the pymode version
let g:pymode_run = 0
" Full code check
nnoremap <buffer> <leader>a :call CheckAll()<CR>
nnoremap <buffer> <leader>A :PymodeLintAuto<CR>
" Do not enable rope (use jedi)
let g:pymode_rope = 0
" Folding
let g:pymode_folding = 0
" Code checkers
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_lint_unmodified = 1
let g:pymode_lint_ignore = "E501,E402"
let g:pymode_lint_todo_symbol = 'T'
let g:pymode_lint_comment_symbol = '#'
let g:pymode_lint_error_symbol = 'E'
let g:pymode_lint_info_symbol = 'I'
let g:pymode_quickfix_minheight = 1
let g:pymode_quickfix_maxheight = 8
let g:pymode_rope_goto_definition_bind = "<Nop>"
" Function for checking everything
function! CheckAll()
    let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
    PymodeLint
    let g:pymode_lint_checkers = ['pyflakes']
endfunction
" }}}

" {{{ JEDI
" Do not let jedi show the stupid window on autocomplete
let g:jedi#auto_vim_configuration=0
setlocal completeopt=menuone,longest
" Do not show call signatures (sad, but just too slow...)
let g:jedi#show_call_signatures = 0
" let g:jedi#show_call_signatures_delay = 100
" Do not automatically select the first word
let g:jedi#popup_select_first = 1
" And do not start on .
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
nnoremap <buffer> <leader>d :VimuxRunCommand("python <C-R>=expand("%:t")<CR>")<CR><CR>
nmap <buffer> <leader>p :VimuxRunCommand("python")<CR><C-l>


" SuperTab for jedi completion
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Sorting code quickly (great for imports)
nnoremap <buffer> <leader>s :sort<CR>
vnoremap <buffer> <leader>s :sort<CR>

" insert a organizing line
nnoremap <buffer> <leader>i 80i#<Esc>o# <Esc>

" alternate way to go to errors
nnoremap <buffer> <leader>e :wincmd j<CR>gg<CR>
nnoremap <buffer> <leader>n :wincmd j<CR>j<CR>
nnoremap <buffer> <leader>N :wincmd j<CR>k<CR>

" Nested quotes for python
let b:delimitMate_nesting_quotes = ['"']
set complete+=k~/.vim/dictionary/python_snippets

" vim:foldmethod=marker:foldlevel=0
