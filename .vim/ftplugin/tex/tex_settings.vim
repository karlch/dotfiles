" Settings for LaTex
" remove all default mappings
let g_tex_pdf_map_keys = 0

" map a pdf viewer
nnoremap <leader>d :! zathura &>/dev/null >/dev/null %:t:r.pdf &<CR><CR>:sleep 500m<CR>:! i3-msg -q resize shrink width 50 px or 10 ppt && i3-msg focus left<CR><CR>:redraw<CR>
" and go to the current line in the pdf
nnoremap <leader>p yy:! i3-msg -q focus right && xdotool key slash ctrl+v BackSpace Return && i3-msg -q focus left<CR><CR>
nnoremap <leader>s %vi}y:! i3-msg -q focus right && xdotool key slash ctrl+v BackSpace Return && i3-msg -q focus left<CR><CR>

" map leader-w for the compiler
nnoremap <leader>w <Esc>:w<CR>:BuildTexPdf<CR>

" Change the environment
nmap cse /end{<CR>/}<CR>h"ayi}0V%:s /<C-R>a/

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
inoremap <C-f> \<c-x><c-k><c-p>
vnoremap <C-f> di\<c-x><c-k><c-p>
imap \ <C-f>
vmap \ <C-f>

" Supertab from beggining to end in LaTeX (because of my LaTeX_fav)
let g:SuperTabDefaultCompletionType = "<Tab>"

" Abbreviation for degrees (really annoying)
iabbrev ° ^\circ
