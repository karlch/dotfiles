"     Description:      a simple vim colorscheme in blue and warm colors
"     Maintainer:       karlch
"     License:          gpl 3+
"     Version:          1.2 (09.02.2016)

set background=dark

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name = "lhun"

" blue dull         9ab2c8    32
" blue bright       62acce    45
" red               9d0e15    124
" brown slight      d1c79e    144
" orange            d1d435    215
" yellow            e6ac32    227
" black             2a2b2f    234
" various grey tones in between
" grey light        e1e0e5    250
" interesting 75, 63, 39, 33 

hi NonText                  ctermfg=0      ctermbg=none     cterm=none
hi DiffText                 ctermfg=32     ctermbg=144      cterm=none
hi Special                  ctermfg=32     ctermbg=none     cterm=none
hi TablineSel               ctermfg=32     ctermbg=234      cterm=none
hi TablineFill              ctermfg=32     ctermbg=234      cterm=none
hi EasyMotionTarget2Second  ctermfg=32     ctermbg=none     cterm=none
hi Conceal                  ctermfg=32     ctermbg=none     cterm=none
hi CursorLineNr             ctermfg=45     ctermbg=none     cterm=bold
hi Statement                ctermfg=45     ctermbg=none     cterm=none
hi StatusLine               ctermfg=45     ctermbg=234      cterm=bold
hi EasyMotionTarget         ctermfg=45     ctermbg=none     cterm=none
hi EasyMotionTarget2First   ctermfg=45     ctermbg=none     cterm=none
hi Operator                 ctermfg=63     ctermbg=none     cterm=none
hi Pmenu                    ctermfg=81     ctermbg=234      cterm=none
hi Constant                 ctermfg=144    ctermbg=none     cterm=none
hi MatchParen               ctermfg=215    ctermbg=234      cterm=bold,underline
hi PreProc                  ctermfg=215    ctermbg=none     cterm=none 
hi Type                     ctermfg=227    ctermbg=none     cterm=none
hi StatusLineNC             ctermfg=233    ctermbg=234      cterm=none
hi Cursor                   ctermfg=234    ctermbg=250      cterm=none
hi DiffAdd                  ctermfg=234    ctermbg=32       cterm=none
hi DiffChange               ctermfg=234    ctermbg=144      cterm=none
hi PmenuSbar                ctermfg=234    ctermbg=none     cterm=none
hi PmenuThumb               ctermfg=234    ctermbg=none     cterm=none
hi Search                   ctermfg=234    ctermbg=32       cterm=none
hi Visual                   ctermfg=234    ctermbg=32       cterm=none
hi PmenuSel                 ctermfg=236    ctermbg=81       cterm=bold
hi Split                    ctermfg=236    ctermbg=234      cterm=none
hi Wildmenu                 ctermfg=236    ctermbg=45       cterm=bold
hi DiffDelete               ctermfg=239    ctermbg=none     cterm=none
hi EasyMotionShade          ctermfg=239    ctermbg=none     cterm=none
hi Comment                  ctermfg=242    ctermbg=none     cterm=none
hi Folded                   ctermfg=242    ctermbg=none     cterm=none
hi ModeMsg                  ctermfg=250    ctermbg=none     cterm=bold
hi Normal                   ctermfg=250    ctermbg=none     cterm=none
hi Tabline                  ctermfg=250    ctermbg=234      cterm=none
hi Todo                     ctermfg=250    ctermbg=124      cterm=bold
hi Underlined               ctermfg=250    ctermbg=none     cterm=underline
hi ColorColumn                             ctermbg=234
hi CursorLine                              ctermbg=234      cterm=none

hi! link Boolean            Constant
hi! link Character          Constant
hi! link Conditional        Statement
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
hi! link Function           Normal
hi! link Identifier         Special
hi! link Ignore             Comment
hi! link IncSearch          Search
hi! link Include            PreProc
hi! link Keyword            Statement
hi! link Label              Statement
hi! link LineNr             Comment
hi! link Macro              PreProc
hi! link MoreMsg            ModeMsg
hi! link Number             Constant
hi! link PreCondit          PreProc
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

" ada
hi! link adaBegin           Type
hi! link adaEnd             Type
hi! link adaKeyword         Special
" c++
hi! link cppAccess          Type
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
" py
hi! link pythonStatement    Type
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

" hi Comment                  guifg=#6c6c6c       guibg=#2C2C2C    gui=none
" hi ColorColumn                                  guibg=#303030
" hi Cursor                   guifg=#2C2C2C       guibg=#bcbcbc    gui=none
" hi Constant                 guifg=#afaf87       guibg=#2C2C2C    gui=none
" hi CursorLine                                   guibg=#303030    gui=none
" hi CursorLineNr             guifg=#5fffff       guibg=#2C2C2C    gui=none
" hi DiffAdd                  guifg=#2C2C2C       guibg=#5fafd7    gui=none
" hi DiffChange               guifg=#2C2C2C       guibg=#afaf87    gui=none
" hi DiffDelete               guifg=#4e4e4e       guibg=#2C2C2C    gui=none
" hi DiffText                 guifg=#af0000       guibg=#afaf87    gui=none
" hi Folded                   guifg=#6c6c6c       guibg=#2C2C2C    gui=none
" hi MatchParen               guifg=#ffd75f       guibg=#303030    gui=bold,underline
" hi ModeMsg                  guifg=#bcbcbc       guibg=#2C2C2C    gui=bold
" hi Normal                   guifg=#bcbcbc       guibg=#2C2C2C    gui=none
" hi Pmenu                    guifg=#5fd7ff       guibg=#303030    gui=none
" hi PmenuSel                 guifg=#303030       guibg=#5fd7ff    gui=bold
" hi PmenuSbar                guifg=#2C2C2C       guibg=#2C2C2C    gui=none
" hi PmenuThumb               guifg=#2C2C2C       guibg=#2C2C2C    gui=none
" hi PreProc                  guifg=#ffd75f       guibg=#2C2C2C    gui=none 
" hi Search                   guifg=#2C2C2C       guibg=#bcbcbc    gui=none
" hi Special                  guifg=#5fafd7       guibg=#2C2C2C    gui=none
" hi Statement                guifg=#5fffff       guibg=#2C2C2C    gui=none
" hi StatusLine               guifg=#5fafd7       guibg=#303030    gui=bold
" hi StatusLineNC             guifg=#121212       guibg=#303030    gui=none
" hi Split                    guifg=#2C2C2C       guibg=#2C2C2C    gui=none
" hi Tabline                  guifg=#bcbcbc       guibg=#303030    gui=none
" hi TablineSel               guifg=#5fafd7       guibg=#303030    gui=none
" hi TablineFill              guifg=#5fafd7       guibg=#2C2C2C    gui=none
" hi Todo                     guifg=#bcbcbc       guibg=#af0000    gui=bold
" hi Type                     guifg=#ffff6f       guibg=#2C2C2C    gui=none
" hi Underlined               guifg=#bcbcbc       guibg=#2C2C2C    gui=underline
" hi Visual                   guifg=#2C2C2C       guibg=#bcbcbc    gui=none
" hi Wildmenu                 guifg=#5fffff       guibg=#2C2C2C    gui=bold
" hi EasyMotionTarget         guifg=#5fffff       guibg=#2C2C2C    gui=none
" hi EasyMotionShade          guifg=#4e4e4e       guibg=#2C2C2C    gui=none
" hi EasyMotionTarget2First   guifg=#5fffff       guibg=#2C2C2C    gui=none
" hi EasyMotionTarget2Second  guifg=#5fafd7       guibg=#2C2C2C    gui=none
