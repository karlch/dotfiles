" Settings for python
" autoindent python scripts after specific keywords
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Keycombination for running a python Skript in current window
" nnoremap <leader>d :! clear && python %<CR>
" " Run python in the terminal
" nnoremap <leader>p :! clear && python<CR>

" Tmux version
nnoremap <leader>d :VimuxRunCommand("python2 <C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR>")<CR><CR>
nmap <leader>p :VimuxRunCommand("python2")<CR><C-l>

" and disable the pymode version
let g:pymode_run = 0

" Check code when saving and remove the pep errors
nnoremap <leader>w :w<Cr>:PymodeLintAuto<CR>:PymodeLint<Cr>
"
" Do not enable rope (use jedi)
let g:pymode_rope = 0

" Show documentation on leader k like Jedi
let g:pymode_doc_bind = '<leader>k'

" Do not let jedi show the stupid window on autocomplete
let g:jedi#auto_vim_configuration=0
setlocal completeopt=menuone,longest

" Do not show call signatures (sad, but just too slow...)
let g:jedi#show_call_signatures = "0"

" Do not automatically select the first word
let g:jedi#popup_select_first = 0

" And do not start on .
let g:jedi#popup_on_dot = 0

" The Key mappings for jedi
let g:jedi#completions_command = "<C-Space>"
let g:jedi#goto_assignments_command = "<Nop>"
let g:jedi#goto_definitions_command = "<gd>"
let g:jedi#documentation_command = "<leader>k"
let g:jedi#usages_command = "<Nop>"
let g:jedi#rename_command = "<leader>r"

" SuperTab for jedi completion
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Sorting code quickly (great for imports)
nnoremap <leader>s :sort<CR>
vnoremap <leader>s :sort<CR>

" do not use ä ö and ü
inoremap ä ae
inoremap ö oe
inoremap ü ue
inoremap Ä Ae
inoremap Ö Oe
inoremap Ü Ue

" insert a organizing line
nnoremap <leader>i 80i#<Esc>o# <Esc>

" alternate way to go to errors
nnoremap <leader>e :wincmd j<CR>gg<CR>
nnoremap <leader>n :wincmd j<CR>j<CR>
nnoremap <leader>N :wincmd j<CR>k<CR>

" Nested quotes for python
let b:delimitMate_nesting_quotes = ['"']
set complete+=k~/.vim/dictionary/python_snippets
