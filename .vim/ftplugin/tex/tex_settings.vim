" Settings for LaTex
" remove all default mappings
let g_tex_pdf_map_keys = 0

" map a pdf viewer
map <leader>d :! zathura &>/dev/null >/dev/null %:t:r.pdf &<CR><CR>:redraw<CR>

" map leader-w for the compiler
nnoremap <leader>w <Esc>:w<CR>:BuildTexPdf<CR>
" a tmux version
nnoremap <leader>W :w<CR>:VimuxRunCommand("vim <C-R>=expand("%:p:h")<CR>/<C-R>=expand("%:t")<CR> +Voom +BuildTexPdf")<CR>
let g:VimuxHeight = "10"
let g:VimuxOrientation = "v"

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

" Concealing
" let g:tex_conceal="adgm"
