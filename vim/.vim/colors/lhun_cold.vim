" -----------------------------------------------------------------------------
" File: lhun.vim
" Description: simple dark-cold colorscheme for vim
" Author: karlch <christian dot karl at protonmail dot com>
" Source: https://github.com/karlch/lhun.vim
" Last Modified: 11 Feb 2016
" -----------------------------------------------------------------------------

" Initialisation: {{{

" Syntax highlighting supported?
if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='lhun_cold'

" Enough colors available?
if !has('gui_running') && &t_Co != 256
  finish
endif

" }}}

" Global Settings: {{{

if !exists('g:lhun_bold')
  let g:lhun_bold=1
endif
if !exists('g:lhun_undercurl')
  let g:lhun_undercurl=1
endif
if !exists('g:lhun_underline')
  let g:lhun_underline=1
endif
if !exists('g:lhun_inverse')
  let g:lhun_inverse=1
endif

" Lhun is dark.
set background=dark

" }}}

" Palette: {{{

" Grey
let s:grey_dark0   = ['#2C2C2C', 235]
let s:grey_dark1   = ['#303030', 237]
let s:grey_dark2   = ['#444444', 238]
let s:grey_med0    = ['#444444', 239]
let s:grey_med1    = ['#4E4E4E', 240]
let s:grey_med2    = ['#6C6C6C', 242]
let s:grey_light   = ['#BCBCBC', 250]

" Brown
let s:brown        = ['#AFAF87', 144]

" Not visible
let s:hide         = [0, 0]
let s:none         = ['NONE', 'NONE']

" Background
if exists('g:lhun_background')
  let s:bg         = g:lhun_background
else
  let s:bg         = [0, 'NONE']
endif

" Red
let s:red          = ['#AF0000', 124]

" Bright white
let s:extra3       = ['#FFFFFF', 231]

" Flavours: {{{

" User defined
if exists("g:lhun_flavour")
  let s:main_dark    = g:lhun_flavour[0]
  let s:main_med0    = g:lhun_flavour[1]
  let s:main_med1    = g:lhun_flavour[2]
  let s:main_light   = g:lhun_flavour[3]
  let s:extra1       = g:lhun_flavour[4]
  let s:extra2       = g:lhun_flavour[5]
  let s:extra4       = g:lhun_flavour[6]
else
  " Blue
  let s:main_dark    = ['#005FAF', 25]
  let s:main_med0    = ['#0087D7', 32]
  let s:main_med1    = ['#0087FF', 33]
  let s:main_light   = ['#00D3FA', 81]
  " Purple
  let s:extra1       = ['#7251D6', 99]
  " Magenta
  let s:extra2       = ['#870087', 90]
  " Green
  let s:extra4       = ['#00DD00#', 34]
endif

" }}}

" }}}

" Setup Emphasis: {{{
" Allows the user to disable bold, underline and co

let s:bold = 'bold,'
if g:lhun_bold == 0
  let s:bold = ''
endif

let s:underline = 'underline,'
if g:lhun_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:lhun_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:lhun_inverse == 0
  let s:inverse = ''
endif

" }}}

" Highlighting Function: {{{

function! s:HL(name, fg, ...)
  " Arguments: name, fg, bg, emphasis

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:bg
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emp = a:2
  else
    let emp = 'NONE,'
  endif

  let histring = [ 'hi', a:name,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emp[:-2], 'cterm=' . emp[:-2]
        \ ]

  execute join(histring, ' ')
endfunction

" }}}

" Setup Highlighting: {{{

" Features of later vim versions {{{
if version >= 700
  " Cursorline/-column
  call s:HL('CursorLine', s:none, s:grey_dark1)
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:main_dark, s:grey_dark0)
  hi! link TabLineSel TabLineFill
  call s:HL('Tabline', s:grey_light, s:grey_dark1)

  call s:HL('MatchParen', s:grey_dark0, s:extra2, s:bold, s:underline)
endif

if version >= 703
  call s:HL('ColorColumn', s:none, s:grey_dark1)
  call s:HL('Conceal', s:main_dark)
  call s:HL('CursorLineNr', s:main_light, s:grey_dark1)
endif
" }}}

" Basic Highlighting {{{
call s:HL('Comment', s:grey_med2)
call s:HL('Constant', s:brown)
call s:HL('Cursor', s:grey_dark0, s:grey_light)
call s:HL('DiffAdd', s:extra3, s:extra4)
call s:HL('DiffChange', s:main_dark, s:brown)
call s:HL('DiffDelete', s:extra3, s:red)
call s:HL('DiffText', s:main_dark, s:brown)
call s:HL('Folded', s:grey_med2, s:grey_dark0)
call s:HL('LineNr', s:grey_med2, s:grey_dark0)
call s:HL('ModeMsg', s:grey_light)
call s:HL('ModeMsg', s:grey_light, s:none, s:bold)
call s:HL('NonText', s:hide)
call s:HL('Normal', s:grey_light, s:bg)
call s:HL('Operator', s:main_dark)
call s:HL('Pmenu', s:main_light, s:grey_dark1)
call s:HL('PmenuSbar', s:grey_dark0)
call s:HL('PmenuSel', s:grey_dark2, s:main_light, s:bold)
call s:HL('PmenuThumb', s:grey_dark0)
call s:HL('Search', s:grey_dark0, s:main_light)
call s:HL('Special', s:main_light)
call s:HL('Split', s:grey_dark0, s:grey_dark0)
call s:HL('Statement', s:main_dark)
call s:HL('StatusLine', s:main_light, s:grey_dark1, s:bold)
call s:HL('StatusLineNC', s:grey_med0, s:grey_dark1)
call s:HL('Todo', s:grey_light, s:red, s:bold)
call s:HL('Type', s:extra1)
call s:HL('Underline', s:grey_light, s:none, s:underline)
call s:HL('Visual', s:grey_dark0, s:main_med0)
call s:HL('Wildmenu', s:grey_dark0, s:main_light)

" I use a different color for comparisons
call s:HL('CompOperator', s:extra2)


hi! link Boolean            Constant
hi! link Character          Constant
hi! link Conditional        CompOperator
hi! link CursorColumn       CursorLine
hi! link Debug              Special
hi! link Define             PreProc
hi! link Delimiter          Special
hi! link Directory          Type
hi! link Error              Todo
hi! link ErrorMsg           Error
hi! link Exception          Statement
hi! link Float              Constant
hi! link FoldColumn         Folded
hi! link Function           Operator
hi! link Identifier         Special
hi! link Ignore             Comment
hi! link IncSearch          Search
hi! link Include            PreProc
hi! link Keyword            Statement
hi! link Label              Statement
hi! link Macro              PreProc
hi! link MoreMsg            ModeMsg
hi! link Number             Constant
hi! link PreCondit          PreProc
hi! link PreProc            Type
hi! link Question           MoreMsg
hi! link Repeat             Statement
hi! link SignColumn         FoldColumn
hi! link SpecialChar        Special
hi! link SpecialComment     Special
hi! link SpecialKey         Special
hi! link SpellBad           Error
hi! link SpellCap           Error
hi! link SpellLocal         Error
hi! link SpellRare          Error
hi! link StorageClass       Type
hi! link String             Constant
hi! link Structure          Type
hi! link Tag                Special
hi! link Title              ModeMsg
hi! link Typedef            Type
hi! link VertSplit          Split
hi! link WarningMsg         Error
" }}}

" Plugin support {{{
" Easymotion
call s:HL('EasyMotionTarget2Second', s:main_dark)
call s:HL('EasyMotionTarget', s:main_light)
call s:HL('EasyMotionTarget2First', s:main_light)
call s:HL('EasyMotion', s:grey_med1)

" Rainbowparens
let g:rbpt_max = 6
let g:rbpt_colorpairs = [
    \ [s:main_med0[1],     s:main_med0[0] ],
    \ [s:main_light[1],    s:main_light[0] ],
    \ [s:main_dark[1],     s:main_dark[0] ],
    \ [s:extra2[1],        s:extra2[0] ],
    \ [s:extra1[1],        s:extra1[0] ],
    \ [s:main_light[1],    s:main_light[0] ],
    \ ]

" }}}

" Languages {{{

" ada
hi! link adaBegin           Type
hi! link adaEnd             Type
hi! link adaKeyword         Special
" c++
hi! link cppAccess          Operator
hi! link cppStatement       Special
" hs
hi! link ConId              Type
hi! link hsPragma           PreProc
hi! link hsConSym           Operator
" html
hi! link htmlArg            Statement
hi! link htmlEndTag         Special
hi! link htmlLink           Underlined
hi! link htmlSpecialTagName PreProc
hi! link htmlTag            Special
hi! link htmlTagName        Type
" java
hi! link javaTypeDef        Special
" lisp
hi! link lispAtom           Constant
hi! link lispAtomMark       Constant
hi! link    lispConcat      Special
hi! link lispDecl           Type
hi! link lispFunc           Special
hi! link lispKey            PreProc
" pas
hi! link pascalAsmKey       Statement
hi! link pascalDirective    PreProc
hi! link pascalModifier     PreProc
hi! link pascalPredefined   Special
hi! link pascalStatement    Type
hi! link pascalStruct       Type
" php
hi! link phpComparison      Special
hi! link phpDefine          Normal
hi! link phpIdentifier      Normal
hi! link phpMemberSelector  Special
hi! link phpRegion          Special
hi! link phpVarSelector     Special
" rb
hi! link rubyConstant       Special
hi! link rubyDefine         Type
hi! link rubyRegexp         Special
" scm
hi! link schemeSyntax       Special
" sh
hi! link shArithRegion      Normal
hi! link shDerefSimple      Normal
hi! link shDerefVar         Normal
hi! link shFunction         Type
hi! link shLoop             Statement
hi! link shStatement        Special
hi! link shVariable         Normal
" sql
hi! link sqlKeyword         Statement
" vim
hi! link vimCommand         Statement
hi! link vimCommentTitle    Normal
hi! link vimEnvVar          Special
hi! link vimFuncKey         Type
hi! link vimGroup           Special
hi! link vimHiAttrib        Constant
hi! link vimHiCTerm         Special
hi! link vimHiCtermFgBg     Special
hi! link vimHighlight       Special
hi! link vimHiGui           Special
hi! link vimHiGuiFgBg       Special
hi! link vimOption          Special
hi! link vimSyntax          Special
hi! link vimSynType         Special
hi! link vimUserAttrb       Special
" xml
hi! link xmlAttrib          Special
hi! link xmlCdata           Normal
hi! link xmlCdataCdata      Statement
hi! link xmlCdataEnd        PreProc
hi! link xmlCdataStart      PreProc
hi! link xmlDocType         PreProc
hi! link xmlDocTypeDecl     PreProc
hi! link xmlDocTypeKeyword  PreProc
hi! link xmlEndTag          Statement
hi! link xmlProcessingDelim PreProc
hi! link xmlNamespace       PreProc
hi! link xmlTagName         Statement

" }}}

" }}}

" vim:foldmethod=marker:foldlevel=0:shiftwidth=2:softtabstop=2:expandtab
