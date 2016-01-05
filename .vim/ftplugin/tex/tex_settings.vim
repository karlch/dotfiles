" Settings for LaTex
" remove all default mappings
let g_tex_pdf_map_keys = 0

" map a pdf viewer
nnoremap <buffer> <leader>d :call ZathuraSync()<CR>

" map leader-w for the compiler
nnoremap <buffer> <leader>w <Esc>:w<CR>:BuildTexPdf<CR>

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

" Abbreviation for degrees (really annoying)
iabbrev ° ^\circ

source ~/.vim/ftplugin/tex/tex_tables.vim

" Vimtex
let g:vimtex_index_show_help = 0
let g:vimtex_latexmk_enabled = 0
let g:vimtex_view_enabled = 1
let g:vimtex_imaps_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_envs = 0
let g:vimtex_view_general_viewer = "zathura"
" Mappings therefore
nmap <buffer> <localleader>lt  <plug>(vimtex-toc-open)    
nmap <buffer> <CR>             <plug>(vimtex-toc-toggle)
nmap <buffer> <localleader>ll  <plug>(vimtex-labels-toggle)
