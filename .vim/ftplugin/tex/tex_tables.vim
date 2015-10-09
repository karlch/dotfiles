" Importing different table types directly into vim

" Csv
function! ImportCsv(filename)
    exec "normal i\\begin{center}"
    exec "normal :read !csv2latex --nohead --position c --separator c \<C-R>=a:filename\<CR>\<CR>"
    exec "normal o\\end{center}"
    exec "normal =ip}"
    redraw!
    echo "imported:" a:filename
endfunction
nnoremap <leader>tic :call ImportCsv('')<left><left>

" cln
function! ImportCln(filename)
    exec "normal i\\begin{center}"
    exec "normal :read !csv2latex --nohead --position c --separator l \<C-R>=a:filename\<CR>\<CR>"
    exec "normal o\\end{center}"
    exec "normal =ip}"
    redraw!
    echo "imported:" a:filename
endfunction
nnoremap <leader>til :call ImportCln('')<left><left>

" Sc
function! ImportSc(filename)
    exec "normal i\\begin{center}"
    exec "normal :!~/bin/sc2tex \<C-R>=a:filename\<CR>\<CR>"
    exec "normal :read !cat sctable.tex && rm sctable.tex\<CR>"
    exec "normal o\\end{center}"
    exec "normal =ip}"
    redraw!
endfunction
nnoremap <leader>tis :call ImportSc('')<left><left>
