" Settings for LaTex
" remove all default mappings
let g_tex_pdf_map_keys = 0

" map <buffer> a pdf viewer
nnoremap <buffer> <leader>d :call ZathuraSync()<CR>
" Scroll pdf
nnoremap <buffer> <leader>j :! i3-msg -q focus right && xdotool key J J && i3-msg -q focus left<CR><CR>
nnoremap <buffer> <silent> <leader>k :! i3-msg -q focus right && xdotool key K K && i3-msg -q focus left<CR><CR>

" map <buffer> leader-w for the compiler
nnoremap <buffer> <leader>w <Esc>:w<CR>:BuildTexPdf<CR>

" Change the environment
nmap <buffer> cse /end{<CR>/}<CR>h"ayi}0V%:s /<C-R>a/

" Linelength 90 for LaTex files, reasonable length in my opinion
set tw=90
set sidescrolloff=0

" Use the LaTeX dictionaries
set dictionary+=~/.vim/dictionary/latex_fav
set dictionary+=~/.vim/dictionary/latex
set dictionary+=~/.vim/dictionary/latex_texmaker
set complete+=k~/.vim/dictionary/latex_fav
set complete+=k~/.vim/dictionary/latex
set complete+=k~/.vim/dictionary/latex_texmaker

" Show me autocomplete
inoremap <buffer> <C-f> \<c-x><c-k><c-p>
vnoremap <buffer> <C-f> di\<c-x><c-k><c-p>
imap <buffer> \ <C-f>
vmap <buffer> \ <C-f>

" Supertab from beggining to end in LaTeX (because of my LaTeX_fav)
let g:SuperTabDefaultCompletionType = "<Tab>"

" Abbreviation for degrees (really annoying)
iabbrev ° ^\circ

source ~/.vim/ftplugin/tex/tex_tables.vim