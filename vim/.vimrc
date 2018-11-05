" General stuff {{{
" Use filetype plugins and indentation
filetype plugin indent on

" Activate syntax highlighting
syntax on

" Better timeouts (mapping delay)
set timeoutlen=500
set ttimeoutlen=0

" Set to read automatically when file is changed from outside
set autoread

" Incremental search enabled, highlightsearch enabled
set incsearch hlsearch
" Case insensitive unless uppercase is in the search
set ignorecase smartcase

" Substitute globally by default
set gdefault

" Shows command and hides mode as this is handled by lightline
set showcmd noshowmode

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

" Always display statusline
set laststatus=2

" Copy and paste from system
set clipboard=unnamedplus

" Disable the intro message, sorry Uganda
set shortmess=I

" No title, I prefer my tmux one
set notitle

" Use true colors
set termguicolors

" }}}

" Plugins {{{
" Synchronized plugins in plugged
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'benmills/vimux'
Plug 'chrisbra/unicode.vim'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'henrik/vim-indexed-search'
Plug 'itchyny/lightline.vim'
Plug 'jamshedvesuna/vim-markdown-preview', {'for': 'markdown'}
Plug 'jiangmiao/auto-pairs'
Plug 'joshukraine/dragvisuals'
Plug 'kien/rainbow_parentheses.vim'
Plug 'konfekt/fastfold'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'lukerandall/haskellmode-vim', {'for': 'haskell'}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'neomake/neomake'
Plug 'potatoesmaster/i3-vim-syntax'
Plug 'rhysd/committia.vim'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tmhedberg/simpylfold', {'for': 'python'}
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'valloric/YouCompleteMe'

" Local plugins in bundle
Plug '~/.vim/bundle/root'
Plug '~/.vim/bundle/syntax-improvements'
Plug '~/.vim/bundle/tmux-navigator'
Plug '~/.vim/bundle/visual-star-search'
Plug '~/.vim/bundle/vmath'

call plug#end()
" }}}

" Optics {{{
" Show the line number and relativenumber
set number relativenumber

" Highlight the cursorline
set cursorline

" Visual autocomplete for command line
set wildmenu

" Enable folding by syntax
set foldenable foldmethod=syntax
set foldlevel=100
" Opening of folds
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Favourite colorscheme
let g:nord_comment_brightness = 8
colorscheme nord

" Textwidth is always 79, do not wrap, anything longer will be broken
set textwidth=79 nowrap linebreak

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
tnoremap <Esc> <C-\><C-n>

" Quicker way to enter a command
noremap ö :

" And to search
map ä /
cnoremap ä /
" ... backwards
map Ä ?
cnoremap Ä ?

" Clear highlight on escape
noremap <Esc> <Esc>:nohlsearch<CR>

" Switching between matches
map <tab> %

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
noremap <C-Space> <C-]>

" Nice buffer switching
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

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

" Edit my vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Source my vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>

" Quickly align the whole paragraph/selection
nnoremap <leader>g gqip
vnoremap <leader>g gq

" Move to quickfix errors
nnoremap <leader>e :ll<CR>
nnoremap <leader>n :lnext<CR>
nnoremap <leader>N :lprevious<CR>

" Nice buffer list
nnoremap <leader>b :buffers<CR>:buffer<Space>

" Move to beginning/end of line
noremap <leader>h ^
noremap <leader>l $

" }}}

" Plugin Mappings {{{

" Quicker commenting of code
map <leader>c gcc

" Start Tagbar
nnoremap <leader>tb :TagbarToggle<CR>

" Netrw (Not a plugin, but replaces one :D)
nnoremap <leader>tv :Vexplore<CR>
nnoremap <leader>ts :Sexplore<CR>
nnoremap <leader>te :Explore<CR>

" Start the mundo plugin
nnoremap<leader>u :MundoToggle<CR><CR>

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
vmap <expr> <leader>+ VMATH_YankAndAnalyse()

" Surround
" Use normal s in visual mode as well
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

" Dragvisuals
let g:DVB_TrimWS = 1

" UltiSnips
let g:UltiSnipsSnippetDirectories = ['bundle/snippet-dir/my-snippets', 'UltiSnips']

" Vimux
let g:VimuxUseNearest = "0"
let g:VimuxResetSequence = "q C-u C-s C-l"

" Indexed-search
let g:indexed_search_colors = 0
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1
let g:indexed_search_unfold = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<C-n>"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" Mundo
let g:mundo_close_on_revert = 1
let g:mundo_prefer_python3 = 1

" Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 2

" Lightline
let g:lightline = {
    \ 'active': {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ], 
    \            [ 'filetype' ],
    \            [ 'errors' ] ] },
    \ 'component' : {
    \ 'lineinfo': "%{printf('%03d/%03d', line('.'),  line('$'))}" },
    \ 'component_function': {
    \ 'errors': 'neomake#statusline#LoclistStatus' },
    \ 'component_type': {
    \ 'errors': 'error' }
    \ }
let g:lightline.colorscheme = "base16_ocean"
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

" Thesaurus_query
let g:tq_language = ['en']
let g:tq_map_keys = 0

" Markdown preview
let vim_markdown_preview_browser='qutebrowser'
let vim_markdown_preview_github=1
let vim_markdown_preview_use_xdg_open=1

" netrw
let g:netrw_banner=0                              " disable banner
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'      " hide dotfiles
let g:netrw_list_hide.=netrw_gitignore#Hide()     " hide gitignored files

" Ycm
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_always_populate_location_list = 1

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
autocmd! BufWritePost *.{py,hs} Neomake
autocmd! BufWritePost vimiv Neomake

" Python
" Command to insert the python code for a nice header
autocmd BufNewFile *.py exe "normal a# vim: ft=python fileencoding=utf-8 sw=4 et sts=4\<Esc>o"

" Perl
" Insert perl header
autocmd BufNewFile *.pl exe "normal a#!/usr/bin/env perl\<Esc>o\<Esc>ouse strict;\<Esc>ouse warnings;\<Esc>ouse diagnostics;\<Esc>ouse feature 'say';\<Esc>o"

" C
" Set a compiler
autocmd BufRead,BufNewFile *.c setlocal makeprg=gcc\ %\ -o\ %:t:r\ -lm
autocmd BufRead,BufNewFile *.cpp setlocal makeprg=g++\ %\ -o\ %:t:r\ -std=c++11
autocmd BufRead,BufNewFile *.cxx setlocal makeprg=g++\ %\ -o\ %:t:r\ -std=c++11

" LaTex
let g:tex_flavor='latex'
autocmd VimEnter *.tex VimtexCompile

" Haskell
autocmd BufEnter *.hs compiler ghc

" Mail
autocmd BufRead,BufNewFile *mutt-* set filetype=mail
autocmd BufRead,BufNewFile *mutt-* setlocal foldlevel=3
autocmd BufRead,BufNewFile *mutt-* setlocal textwidth=72

" Shell
autocmd BufNewFile *.sh silent exec "normal i#!/bin/bash\<CR>\<CR>\<Esc>:silent w\<CR>:silent! chmod +x %\<CR>\<CR>"

" Ktf
autocmd BufRead,BufNewFile *.ktf set filetype=text

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

" }}}

" Folding the .vimrc {{{
" fold the .vimrc
" vim:foldmethod=marker:foldlevel=0
" }}}
