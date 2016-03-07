" File:         IndexedSearch.vim
" Author:       Yakov Lerner <iler.ml@gmail.com>
" URL:          http://www.vim.org/scripts/script.php?script_id=1682
" Last change:  2014-10-10

" This script redefines 6 search commands (/,?,n,N,*,#). At each search,
" it shows at which match number you are, and the total number
" of matches, like this: "At Nth match out of M". This is printed
" at the bottom line at every n,N,/,?,*,# search command, automatically.
"
" To try out the plugin, source it and play with N,n,*,#,/,? commands.
" At the bottom line, you'll see wha it shows. There are no new
" commands and no new behavior to learn. Just additional info
" on the bottom line, whenever you perform search.
"
" Works on vim6 and vim7. On very large files, won't cause slowdown
" because it checks the file size.
" Don't use if you're sensitive to one of its components :-)
"
" I am posting this plugin because I find it useful.
" -----------------------------------------------------
" Checking Where You Are with respect to Search Matches
" .....................................................
" You can press \\ or \/ (that's backslach then slash),
" or :ShowSearchIndex to show at which match index you are,
" without moving cursor.
"
" If cursor is exactly on the match, the message is:
"     At Nth match of M
" If cursor is between matches, following messages are displayed:
"     Betwen matches 189-190 of 300
"     Before first match, of 300
"     After last match, of 300
" ------------------------------------------------------
" To disable colors for messages, set 'let g:indexed_search_colors=0'.
" ------------------------------------------------------
" Performance. Plugin bypasses match counting when it would take
" too much time (too many matches, too large file). You can
" tune performance limits below, after comment "Performance tuning limits"
" ------------------------------------------------------
" In case of bugs and wishes, please email: iler.ml at gmail.com
" ------------------------------------------------------

if exists("g:loaded_indexed_search") || &cp || v:version < 700
    finish
endif
let g:loaded_indexed_search = 1

let s:save_cpo = &cpo
set cpo&vim


" Performance tuning limits
if !exists('g:indexed_search_max_lines')
    " Max filesize (in lines) up to where the plugin works
    let g:indexed_search_max_lines = 30000
endif

if !exists("g:indexed_search_max_hits")
    " Max number of matches up to where the plugin stops counting
    let g:indexed_search_max_hits = 1000
endif

" Appearance settings
if !exists('g:indexed_search_colors')
    " 1 or null - use colors for messages,
    " 0         - no colors
    let g:indexed_search_colors = 1
endif

if !exists('g:indexed_search_shortmess')
    " 1         - shorter messages;
    " 0 or null - longer messages.
    let g:indexed_search_shortmess = 0
endif

if !exists('g:indexed_search_numbered_only')
    " 1         - numbered only count
    " 0         - first and last spelled out
    let g:indexed_search_numbered_only = 0
endif

" Mappings
if !exists('g:indexed_search_mappings')
    let g:indexed_search_mappings = 1
endif

if !exists('g:indexed_search_dont_move')
    let g:indexed_search_dont_move = 0
endif

if !exists('g:indexed_search_unfold')
    let g:indexed_search_unfold = 1
endif

command! -bang ShowSearchIndex :call indexed_search#show_index(<bang>0)
command! -bang BlingHighlight :call BlingHighlight()
command! -bang BlingUnHighlight :call BlingUnHighlight()

noremap <Plug>(indexed-search-/)  :ShowSearchIndex<CR>:nohlsearch<CR>:BlingUnHighlight<CR>/
noremap <Plug>(indexed-search-?)  :ShowSearchIndex<CR>:nohlsearch<CR>:BlingUnHighlight<CR>?

noremap <silent> <Plug>(indexed-search-*) *:ShowSearchIndex<CR>:BlingHighlight<CR>
noremap <silent> <Plug>(indexed-search-#) #:ShowSearchIndex<CR>:BlingHighlight<CR>

noremap <silent> <Plug>(indexed-search-n) n:ShowSearchIndex<CR>:BlingHighlight<CR>
noremap <silent> <Plug>(indexed-search-N) N:ShowSearchIndex<CR>:BlingHighlight<CR>

" Additionally implement a visual indicator like in Bling
let g:bling_current_ring = 0
highlight BlingHighlight ctermbg=99 ctermfg=231 cterm=none

function! BlingHighlight()
    let param = getreg('/')
    let pos = getpos('.')
  
    let pattern = '\%'.pos[1].'l\%'.pos[2].'c\%('.param
    if match(param, '^\\v') == 0
        let pattern = pattern.')'
    else
        let pattern = pattern.'\)'
    endif
  
    if &ignorecase == 1 || &smartcase == 1
        let pattern = pattern.'\c'
    endif
  
    call BlingUnHighlight()
    let g:bling_current_ring = matchadd('BlingHighlight', pattern)

    redraw!
endfunction

function! BlingUnHighlight()
    if g:bling_current_ring
        call matchdelete(g:bling_current_ring)
    endif
    let g:bling_current_ring = 0
endfunction


" Map indexed search
if g:indexed_search_mappings
    nmap / <Plug>(indexed-search-/)
    nmap ? <Plug>(indexed-search-?)

    if g:indexed_search_dont_move
        " These can't be implemented using the <Plug> mappings because the
        " 'N' needs to happen after the '*' (or '#') and before the
        " :ShowSearchIndex
        nnoremap <silent>* *N:ShowSearchIndex<CR>
        nnoremap <silent># #N:ShowSearchIndex<CR>
    else
        nmap * <Plug>(indexed-search-*)
        nmap # <Plug>(indexed-search-#)
    endif

    if g:indexed_search_unfold
        nmap n <Plug>(indexed-search-n)zv
        nmap N <Plug>(indexed-search-N)zv
    else
        nmap n <Plug>(indexed-search-n)
        nmap N <Plug>(indexed-search-N)
    endif
endif

" A nice way to remove hlsearch and the visual indicator
noremap <silent> <Plug>(clear_all_highlights) <Esc>:nohlsearch<CR>:BlingUnHighlight<CR>
nmap <Esc> <Plug>(clear_all_highlights)

let &cpo = s:save_cpo
