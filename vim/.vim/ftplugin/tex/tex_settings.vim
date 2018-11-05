" Settings for LaTex

" Map a pdf viewer
nnoremap <buffer> <leader>d :call ZathuraSync()<CR>

set sidescrolloff=0

" Abbreviation for degrees (really annoying)
iabbrev ° ^\circ

" Tables
source ~/.vim/ftplugin/tex/tex_tables.vim

" Vimtex
let g:vimtex_index_show_help = 1
let g:vimtex_latexmk_enabled = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_enabled = 1
let g:vimtex_imaps_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_envs = 0
let g:vimtex_view_general_viewer = "zathura"
let g:vimtex_toc_tocdepth = 2
" Mappings therefore
nmap <buffer> <localleader>tt  <plug>(vimtex-toc-toggle)    
nmap <buffer> <CR>             <plug>(vimtex-toc-open)
nmap <buffer> <localleader>tl  <plug>(vimtex-labels-toggle)

" Quickfix here instead of loclist
nnoremap <leader>o :cw<CR>
nnoremap <leader>e :cc<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>N :cprev<CR>

" And a little indicator about the error amount
function! ErrorList()
    let errors = len(getqflist())
    if errors == 0
        let errstring = ""
    else
        let errstring = "E:" . errors
    endif
    return errstring
endfunction

" View in Zathura
function! ZathuraSync()
    exec "normal :NeomakeSh ~/.vim/ftplugin/tex/start_zathura.sh\<Space>\<C-R>=expand('%')\<CR>\<Space>\<C-R>=line('.')\<CR>\<CR>"
    redraw!
endfunction
