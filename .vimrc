" General stuff {{{
" Do not try to be vi compatible, needed for various settings
set nocompatible

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
set incsearch nohlsearch
" Case insensitive unless uppercase is in the search
set ignorecase smartcase

" Substitute globally by default
set gdefault

" utf8 as standard encoding
set encoding=utf8

" Shows command and mode
set showcmd showmode

" At least seven lines below and above the cursor and seven chars next to it
set scrolloff=7 sidescrolloff=7

" Smoother redrawing of windows
set ttyfast lazyredraw

" Disable annoying backup and swap files
set nobackup nowritebackup noswapfile

" Split to the right, to the bottom
set splitright splitbelow

" Settings to create a usable autocomplete menu
" Only 10 lines
set pumheight=10
" Omnicompletion default
set omnifunc=syntaxcomplete#Complete
" Supertab on omni
let g:SuperTabDefaultCompletionType = "<c-x><c-o><c-p>"
" Enter to select
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Statusline
set laststatus=2
set statusline=%<\%t\ %y\%m\%r\%=\lin:\ %l\/\%L\ col:\ %c

" Copy and paste from system
set clipboard=unnamedplus

" Disable the intro message, sorry Uganda
set shortmess=I

" No title, I prefer my tmux one
set notitle

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

" Dark background theme
set background=dark

" Favourite colorscheme and therefore 256 colors
set t_Co=256
colorscheme lhun

" Textwidth is always 80, do not wrap, anything longer will be broken
set textwidth=80 nowrap linebreak

" Show a column at the end of textwidth
set colorcolumn=+1

" Highlighting Group for trailing whitespaces
highlight trailing_whitespace ctermbg=red ctermfg=white

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

" Starting a linear table
cabbrev linlist r! python2 ~/Dokumente/Uni/14W/WiPro/skripte/mathe/listtab.py

" }}}

" General Mappings {{{
" Quicker way to enter a command
noremap ö :

" And to search
noremap ä /
cnoremap ä /
" ... backwards
noremap Ä ?
cnoremap Ä ?

" Going to lines
noremap ü G

" Switching between matches
map <tab> %

" Toggling the hlsearch
noremap <leader>ä :set hlsearch!<Cr>

" Map + and <BS> to search
nnoremap + *zz
nnoremap <Bs> #zz
" Search results are showed in the middle of the line and folds are opened
nnoremap n nzzzv
nnoremap N Nzzzv
" Also in visualmode keeping the selection
vmap + *gnzz
vmap <Bs> #gnzz

" Move codeblocks without losing the visualization
vnoremap < <gv
vnoremap > >gv

" Calculator
inoremap <C-c> <C-o>yiW<End>=<C-R>=<C-R>0<CR>
vnoremap <C-c> "ey:call CalcQA()<CR>

" Spellchecking on/off
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

" }}}

" Leader Mappings {{{
" Space is mapped for the use of the leader key (map for visibility)
map <space> <leader>

" Move to beggining/end of line
noremap <leader>h ^
noremap <leader>l $

" Quit all windows
nnoremap <leader>q :qa!<CR>
" Save the current window
nnoremap <leader>w :w<CR>
" Save and quit
nnoremap <leader>z ZZ

" Open and close folds quickly
nnoremap <leader>f za
nnoremap <leader>F 100za

" Edit my vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
" Source my vimrc
nnoremap <leader>vs :source $MYVIMRC<CR>

" Quickly align the whole paragraph/selection
nnoremap <leader>g gqip
vnoremap <leader>g gq

" Move to quickfix errors
nnoremap <leader>e :cc<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>N :cprevious<CR>

" Make a latex table
nnoremap <leader>T :%s / / \& <CR>:%s /^/    <CR>:%s /$/ \\\\ \\hline<CR>ggO<Bs><Bs>\begin{center}<CR><tab>\begin{tabular}<CR>\hline<Esc>Go\end{tabular}<Cr><Bs>\end{center}<Esc>2GA{\|c\|c\|}<left>
vnoremap <leader>T :s / / \& <CR>gv:s /^/    <CR>gv:s /$/ \\\\ \\hline<CR>gvo<Esc>O<Bs><Bs>\begin{center}<CR><tab>\begin{tabular}<CR>\hline<Esc>gvo<Esc>o\end{tabular}<Cr><Bs>\end{center}<Esc>gvo2k<Esc>A{\|c\|c\|}<left>

" Open file in a new tab
map <leader>dt :call DmenuOpen("tabe")<cr>
" Open file in current buffer
map <leader>de :call DmenuOpen("e")<cr>
" Open file in vertical split
map <leader>ds :call DmenuOpen("sp")<cr>
" Open file in split
map <leader>dv :call DmenuOpen("vs")<cr>

" Select file with ranger
nnoremap <leader>r :<C-U>RangerChooser<CR>

" }}}

" Plugin Mappings {{{

" Quicker commenting of code
map <leader>c <c-_><c-_>

" Keycombination for the Nerdtree
nnoremap <leader>te :NERDTreeToggle<CR>

" Start Tagbar
nnoremap <leader>tb :TagbarToggle<CR>

" Start the gundo plugin
nnoremap<leader>u :GundoToggle<CR>

" Easymotion on -
map - <Plug>(easymotion-prefix)
" Easymotion repeat
map -. <Plug>(easymotion-repeat)
" Inline forward/backward
map -l <Plug>(easymotion-lineforward)
map -h <Plug>(easymotion-linebackward)
" Words of the whole screen
map -a <Plug>(easymotion-bd-w)
" Two letter searches
map -s <Plug>(easymotion-s2)
" Longer searches
map -- <Plug>(easymotion-sn)
" Smart f and t
map f <Plug>(easymotion-bd-f)
map t <Plug>(easymotion-bd-t)

" Dragvisuals
vmap <expr> <C-h> DVB_Drag('left')
vmap <expr> <C-l> DVB_Drag('right')
vmap <expr> <C-j> DVB_Drag('down')
vmap <expr> <C-k> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

" Vmath
" Needed helpers, mapped to something useless
vnoremap °1 :<Bs><Bs><Bs><Bs><Bs>set noshowmode<Cr>
vmap <expr> °2 VMATH_YankAndAnalyse()
" The actual expressions
nmap <leader>+ v°1vip°2
vmap <leader>+ °1gv°2
" Show mode again when done
vnoremap <Esc> <Esc>:set showmode<Cr>:<Bs>

" Surround
" Use normal s in visual mode aswell
vmap s S
" Add a surrounding with s
nmap s ysi

" Start/Stop neocomplete
nnoremap <leader>o :call NeoCompleteToggle()<CR>

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

" Configure Tagbar
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_foldlevel = 5
let g:tagbar_compact = 1

" Configure Voom
let g:voom_tab_key = "<Nop>"
let g:voom_tree_width = 29

" Configure easymotion
let g:EasyMotion_keys = 'acdefghijklmnoqrstuvwö'

" Configure delimitMate
let g:delimitMate_expand_space = 0
let g:delimitMate_expand_cr = 0
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_balance_matchpairs = 1

" Configure dragvisuals
let g:DVB_TrimWS = 1

" Configure Neocomplete
" start it but disable it (make toggling possible)
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#enable_fuzzy_completion = 0
let g:neocomplete#enable_auto_delimiter = 1

" Configure UltiSnips
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "MySnippets"]

" Configure Vimux
let g:VimuxHeight = "30"
let g:VimuxOrientation = "h"
let g:VimuxUseNearest = "0"

" Configure Mathematica
let g:mma_candy = 1

"}}}

" Filespecific autocommands {{{
" Python
" Command to insert the python code for a nice header
autocmd BufNewFile *.py exe "normal a#!/usr/bin/env python\<Esc>o# encoding: utf-8\<Esc>o"
" Close the extra vimux buffer
autocmd VimLeave *.py VimuxCloseRunner

" C
" Close the extra vimux buffer
autocmd VimLeave *.c VimuxCloseRunner
autocmd BufRead,BufNewFile *.c set makeprg=gcc\ %


" LaTex
" Open Voom LaTex on startup
autocmd BufRead,BufNewFile *.tex Voom latex
autocmd VimLeave *.tex exe "!killall zathura"

" Tex to LaTex
let g:tex_flavor='latex'

" Matlab
autocmd BufRead,BufNewFile *.m VimuxRunCommand("clear && matlab -nosplash -nodesktop")
autocmd VimLeave *.m VimuxCloseRunner
" Compiler
autocmd BufEnter *.m compiler mlint

" Mathematica
autocmd BufRead,BufNewFile *.mma      set ft=mma
autocmd BufRead,BufNewFile *.mma VimuxRunCommand("clear && math")
autocmd VimLeave *.mma VimuxCloseRunner
autocmd BufNewFile *.mma exe "normal a<<~/.vim/ftplugin/mma/startjava\<Esc>"

" Tsv (Vim as spreadsheet)
autocmd BufEnter *.tsv setlocal noexpandtab shiftwidth=20 softtabstop=20 tabstop=20
autocmd BufEnter *.tsv setlocal textwidth=800 nowrap nolinebreak colorcolumn=0 norelativenumber
autocmd BufEnter *.tsv let g:SuperTabDefaultCompletionType = "<Tab>"
autocmd BufEnter *.tsv nnoremap <leader>tb :sp<CR>:wincmd k<CR>:0<CR>1<C-W>_:wincmd j<CR>
autocmd BufEnter *.tsv inoremap = =<Esc>vB"ey:call CalcQA()<CR>?=<CR>ldBE
autocmd BufEnter *.tsv nnoremap v <C-v>
autocmd BufEnter *.tsv nnoremap <C-v> v
autocmd BufLeave *.tsv setlocal expandtab shiftwidth=4 tabstop=4
autocmd BufLeave *.tsv setlocal textwidth=80 nowrap linebreak colorcolumn=+1 relativenumber
autocmd BufLeave *.tsv let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
autocmd BufLeave *.tsv nnoremap <leader>tb :TagbarToggle<CR>
autocmd BufLeave *.tsv inoremap = =
autocmd BufLeave *.tsv nnoremap v v
autocmd BufLeave *.tsv nnoremap <C-v> <C-v>

" Mail
autocmd BufRead,BufNewFile *mutt-* setfiletype mail
autocmd BufRead,BufNewFile *mutt-* set foldlevel=3
autocmd BufRead,BufNewFile *mutt-* exec "normal ggO\<CR>\<Esc>gg"

" }}}

" Functions {{{
function! NeoCompleteToggle()
    if g:neocomplete#disable_auto_complete
        let g:neocomplete#disable_auto_complete = 0
    else
        let g:neocomplete#disable_auto_complete = 1
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
  " run bc, strip newline
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

function! DmenuOpen(cmd)
  let fname = Chomp(system("ls -A | grep -v ^d | dmenu -i -b -y 25 -p launch: -l 20 -fn SourceCodePro -nb '#2C2C2C' -nf '#00C1FF' -sb '#00A0DD' -sf '#FFFFFF' -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

function! RangeChooser()
    let temp = tempname()
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()

" }}}

" Gui Options {{{

if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
endif

" }}}

" Folding the .vimrc {{{
" fold the .vimrc
" vim:foldmethod=marker:foldlevel=0
" }}}
