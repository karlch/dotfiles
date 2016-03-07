" General stuff {{{
" Load Pathogen to handle my plugins
call pathogen#infect()
call pathogen#helptags()

" Use filetype plugins and indentation
filetype plugin indent on

" Activate syntax highlighting
syntax on

" Better timeouts (mapping delay)
set timeoutlen=500
set ttimeoutlen=0

" Set to read automatically when file is changed from outside
set autoread

" Incremental search enabled, highlightsearch disabled
set incsearch hlsearch
" Case insensitive unless uppercase is in the search
set ignorecase smartcase

" Substitute globally by default
set gdefault

" Shows command and mode
set showcmd showmode

" At least seven lines below and above the cursor and seven chars next to it
set scrolloff=7 sidescrolloff=7

" Smoother redrawing of windows
set lazyredraw

" Disable annoying backup and swap files
set nobackup nowritebackup noswapfile

" Split to the right, to the bottom
set splitright splitbelow
" And keep splits neat when vim is resized
autocmd VimResized * wincmd =

" Settings to create a usable autocomplete menu
" Only 10 lines
set pumheight=10
" Omnicompletion default
set omnifunc=syntaxcomplete#Complete
" Enter to select
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Show with one menu item, no preview
set completeopt=menuone,longest

" Statusline
set laststatus=2
set statusline=%<\%t\ %y\%m\%r\%=%#warningmsg#%{neomake#statusline#LoclistStatus()}%*\ \ \lin:\ %l\/\%L\ col:\ %c

" Copy and paste from system
set clipboard=unnamedplus

" Disable the intro message, sorry Uganda
set shortmess=I

" No title, I prefer my tmux one
set notitle

" Change directory to the current buffer when opening files.
set autochdir

" Hide dotfiles
let g:netrw_list_hide='\..*'

" No mouse, tzz neovim
set mouse=

" }}}

" Optics {{{
" Show the line number and relativenumber
set number relativenumber

" Highlight the cursorline
set cursorline

" Visual autocomplete for command menu
set wildmenu

" Enable folding by syntax
set foldenable foldmethod=syntax
set foldlevel=100
" Opening of folds
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Favourite colorscheme
colorscheme lhun

" Textwidth is always 80, do not wrap, anything longer will be broken
set textwidth=80 nowrap linebreak

" Show a column at the end of textwidth
set colorcolumn=+1

" Highlighting Group for trailing whitespaces
highlight trailing_whitespace ctermbg=red ctermfg=white

" Higher help window
set helpheight=30

" }}}

" Tabs and indentation {{{
" Autoindentation on
set autoindent

" Smaller tab
set shiftwidth=4

" Spaces instead of tab (safer)
set expandtab

" Delete 4 spaces (=tab) in one backspace
set softtabstop=4

" Round indents to a multiple of shiftwidth
set shiftround

" }}}

" Abbreviations {{{
" Save as root
cabbrev w!! w !sudo tee > /dev/null %

" }}}

" General Mappings {{{
" Movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Quicker way to enter a command
noremap ö :

" And to search
map ä /
cnoremap ä /
" ... backwards
map Ä ?
cnoremap Ä ?

" Going to lines
noremap ü G

" Switching between matches
map <tab> %

" Toggling the hlsearch
noremap <leader>ä :set hlsearch!<CR>
noremap <Esc> <Esc>:nohlsearch<CR>

" Map + and <BS> to search (keyboard layout...)
nmap + *
nmap <Bs> #

" Move code blocks without losing the visualization
vnoremap < <gv
vnoremap > >gv

" Calculator
inoremap <C-c> =<Esc>vaW"ey:call CalcQA()<CR>F=dBxA
vnoremap <C-c> "ey:call CalcQA()<CR>
nnoremap <C-c> vaW"ey:call CalcQA()<CR>

" Spell checking on/off
nnoremap <F2> :set spell! spelllang=de<CR>
nnoremap <F3> :set spell! spelllang=en<CR>
" Next/previous error
nnoremap <F4> ]s
nnoremap <F5> [s
" Accept the word
nnoremap <F6> zg
" Show alternatives
nnoremap <F7> z=

" Trailing Whitespace
nnoremap <leader>tw :call TrailingWhitespaceToggle()<CR>

" Y like D and C
nnoremap Y y$

" S as substitute the command way (cc works anyway)
nnoremap S :%s /
xnoremap S :s /

" Navigation for vim, tmux and i3 (actually bound to mod+hjkl in i3 config)
inoremap <Left> <Esc>:TmuxNavigateLeft<CR>
inoremap <Down> <Esc>:TmuxNavigateDown<CR>
inoremap <Up> <Esc>:TmuxNavigateUp<CR>
inoremap <Right> <Esc>:TmuxNavigateRight<CR>

" Follow Tags with C-Space
noremap <C-@> <C-]>

" Access marks quickly
nnoremap , `

" Move to beginning/end of line
noremap H ^
noremap L $

" }}}

" Leader Mappings {{{
" Space is mapped for the use of the leader key (map for visibility)
map <space> <leader>

" Quit all windows
nnoremap <leader>q :qa!<CR>
" Save the current window
nnoremap <leader>w :w<CR>

" Open and close folds quickly
nnoremap <leader>f za
nnoremap <leader>F :call ToggleFoldlevel()<CR>

" Edit my vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Source my vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>

" Quickly align the whole paragraph/selection
nnoremap <leader>g gqip
vnoremap <leader>g gq

" Move to quickfix errors
nnoremap <leader>o :lw<CR>
nnoremap <leader>e :ll<CR>
nnoremap <leader>n :lnext<CR>
nnoremap <leader>N :lprevious<CR>

" Nice buffer switching
nnoremap <leader>b :buffers<CR>:buffer<Space>

" }}}

" Plugin Mappings {{{

" Quicker commenting of code
map <leader>c <c-_><c-_>
nnoremap <leader>C A<Space><Space><Esc>:TCommentRight<CR>l

" Start Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
" Netrw (Not a plugin, but replaces one :D)
nnoremap <leader>tv :Vexplore<CR>
nnoremap <leader>ts :Sexplore<CR>
nnoremap <leader>te :Explore<CR>

" Start the gundo plugin
nnoremap<leader>u :GundoToggle<CR><CR>

" Powerful hl
map <leader>h <Plug>(easymotion-linebackward)
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
" " Smart f and t
map f <Plug>(easymotion-bd-f)
map t <Plug>(easymotion-bd-t)
" Two letter searches
map F <Plug>(easymotion-s2)
" Longer searches
map - <Plug>(easymotion-sn)

" Dragvisuals
vmap <expr> <C-h> DVB_Drag('left')
vmap <expr> <C-l> DVB_Drag('right')
vmap <expr> <C-j> DVB_Drag('down')
vmap <expr> <C-k> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

" Vmath
" Needed helpers, mapped to something useless
vnoremap °1 :<Bs><Bs><Bs><Bs><Bs>set noshowmode<CR>
vmap <expr> °2 VMATH_YankAndAnalyse()
" The actual expressions
nmap <leader>+ v°1vip°2
vmap <leader>+ °1gv°2
" Show mode again when done
vnoremap <Esc> <Esc>:set showmode<CR>:<Bs>

" Surround
" Use normal s in visual mode as well
vmap s S
" Add a surrounding with s
nmap s ysi

" UltiSnips the way it should be
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
let g:UltiSnipsListSnippets = "<C-l>"

" Vimux
" Run a command in tmux
nnoremap <leader>vp :VimuxPromptCommand<CR>
" Stop the Command
nnoremap <leader>vi :VimuxInterruptRunner<CR>
" Close the runner
nnoremap <leader>vc :VimuxCloseRunner<CR>

" After all the mappings remove everything that disturbs select mode
" This interferes with all the snippets
smapclear

" }}}

" Settings for plugins {{{

" Tagbar
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_foldlevel = 5
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_indent = 1
let g:tagbar_autopreview = 0

" Easymotion
let g:EasyMotion_keys = 'ACDEFGHIJKLMNQRSTUVWÖ'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1

" delimitMate
let g:delimitMate_expand_space = 0
let g:delimitMate_expand_cr = 0
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_balance_matchpairs = 1

" Dragvisuals
let g:DVB_TrimWS = 1

" UltiSnips
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "MySnippets"]

" Vimux
" let g:VimuxHeight = "30"
" let g:VimuxOrientation = "h"
let g:VimuxUseNearest = "0"
let g:VimuxResetSequence = "q C-u C-s C-l"

" Mathematica
let g:mma_candy = 1

" Indexed-search
let g:indexed_search_colors = 0
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1
let g:indexed_search_unfold = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Gundo
let g:gundo_close_on_revert = 1

" Neomake
let g:neomake_verbose = 0
let g:neomake_cpp_clang_args = ['-Wno-c++11-extensions']

" NeoTerm
let g:neoterm_size = 60
let g:neoterm_position = "vertical"
let g:neoterm_keep_term_open = 0

"}}}

" Autocommands {{{
" Close the extra tmux buffer
autocmd VimLeave * VimuxCloseRunner

" Formatoptions
autocmd FileType * setlocal formatoptions=tcqlnj
autocmd FileType *.tex setlocal formatoptions=tcqlnjaw

" Rainbow Parens
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" Quickfixsize
autocmd FileType qf call AdjustWindowHeight()
function! AdjustWindowHeight()
    echom line("$")
  execute min([line("$"), 8]) . "wincmd _"
endfunction

" Neomake
autocmd! BufWritePost *.{py,c,C,cpp} Neomake
autocmd! BufWritePost vimiv Neomake

" Python
" Command to insert the python code for a nice header
autocmd BufNewFile *.py exe "normal a#!/usr/bin/env python\<Esc>o# encoding: utf-8\<Esc>o"

" C
" Set a compiler
autocmd BufRead,BufNewFile *.c setlocal makeprg=gcc\ %\ -o\ %:t:r\ -lm
autocmd BufRead,BufNewFile *.cpp setlocal makeprg=g++\ %\ -o\ %:t:r\ -std=c++11
" Root
autocmd BufRead,BufNewFile *.C set filetype=cpp.root

" LaTex
autocmd BufRead,BufNewFile *.tex call ZathuraSync()
autocmd VimLeave *.tex exe "!~/.vim/ftplugin/tex/close_zathura.sh"
" Tex to LaTex
let g:tex_flavor='latex'

" Matlab
autocmd BufRead,BufNewFile *.m VimuxRunCommand("clear && matlab -nosplash -nodesktop")
" Compiler
autocmd BufEnter *.m compiler mlint

" Mathematica
autocmd BufRead,BufNewFile *.mma      setfiletype mma
autocmd BufRead,BufNewFile *.mma VimuxRunCommand("clear && math")
autocmd BufNewFile *.mma exe "normal a<<~/.vim/ftplugin/mma/startjava\<Esc>"

" Tsv (Vim as spreadsheet)
autocmd BufEnter *.tsv setlocal noexpandtab shiftwidth=20 softtabstop=20 tabstop=20
autocmd BufEnter *.tsv setlocal textwidth=800 nowrap nolinebreak colorcolumn=0 norelativenumber
autocmd BufEnter *.tsv let g:SuperTabDefaultCompletionType = "<Tab>"
autocmd BufEnter *.tsv nnoremap <buffer> <leader>tb :sp<CR>:wincmd k<CR>:0<CR>1<C-W>_:wincmd j<CR>
autocmd BufEnter *.tsv inoremap <buffer> = =<Esc>vB"ey:call CalcQA()<CR>?=<CR>ldBE
autocmd BufLeave *.tsv setlocal expandtab shiftwidth=4 tabstop=4
autocmd BufLeave *.tsv setlocal textwidth=80 nowrap linebreak colorcolumn=+1 relativenumber
autocmd BufLeave *.tsv inoremap = =

" Mail
autocmd BufRead,BufNewFile *mutt-* setfiletype mail
autocmd BufRead,BufNewFile *mutt-* set foldlevel=3
autocmd BufRead,BufNewFile *mutt-* exec "normal ggO\<CR>\<Esc>gg"

" Shell
autocmd BufNewFile *.sh silent exec "normal i#!/bin/bash\<CR>\<CR>\<Esc>:silent w\<CR>:silent! chmod +x %\<CR>\<CR>"

" Calculator
autocmd BufRead,BufNewFile calc inoremap <CR> =<Esc>vaW"ey:call CalcQA()<CR>F=lDo<Esc>i>   <Esc>po<Esc>i
autocmd BufRead,BufNewFile calc inoremap <Space> <Esc>pa

" }}}

" Functions {{{
let g:fold_level_toggle = 1
function! ToggleFoldlevel()
    if g:fold_level_toggle
        set foldlevel=0
        echom "folding"
        let g:fold_level_toggle = 0
    else
        set foldlevel=100
        echom "opening"
        let g:fold_level_toggle = 1
    endif
endfunction

let g:trailing_whitespace_toggle = 0
function! TrailingWhitespaceToggle()
    if g:trailing_whitespace_toggle
        match trailing_whitespace //
        let g:trailing_whitespace_toggle = 0
    else
        execute 'match trailing_whitespace /\v( )+$/'
        let g:trailing_whitespace_toggle = 1
    endif
endfunction

function! CalcQA()
    let has_equal = 0
    " remove newlines and trailing spaces
    let @e = substitute (@e, "\n", "", "g")
    let @e = substitute (@e, '\s*$', "", "g")
    " if we end with an equal, strip, and remember for output
    if @e =~ "=$"
        let @e = substitute (@e, '=$', "", "")
        let has_equal = 1
    endif
    " escape chars for shell
    let @e = escape (@e, '*()')
    " run qalc, strip newline
    let answer = substitute (system ("echo " . @e . " \| qalc"), "\n", "", "")
    " Strip the answer to what is needed
    let answer1 = split(answer, " ")
    let answer2 = answer1[-1]
    let answer3 = split(answer2, "\n")
    let answer4 = answer3[0]
    if has_equal == 1
        normal `>
        exec "normal a" . answer4
        echo "answer = " . answer4
    else
        echo "answer = " . answer4
    endif
endfunction

function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" }}}

" Folding the .vimrc {{{
" fold the .vimrc
" vim:foldmethod=marker:foldlevel=0
" }}}
