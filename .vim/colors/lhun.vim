" Description:	a theme based on kellys because I wanted to
"  Maintainer:	Tano
"     License:	gpl 3+
"     Version:	1.1 (27.03.2015)

set background=dark

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let colors_name = "lhun"

" black			2a2b2f	234
" blue bright			62acce	87
" blue dull	9ab2c8	74
" brown slight	d1c79e	144
" green	yellowy	d1d435	221
" grey dark		67686b	240
" grey light	e1e0e5	250
" orange		e6ac32	227
" red			9d0e15	124

" tabline

hi Comment		ctermfg=242	ctermbg=234	cterm=none
hi ColorColumn                          ctermbg=238
hi Cursor 		ctermfg=234	ctermbg=250	cterm=none
hi Constant 	        ctermfg=144	ctermbg=234	cterm=none
hi CursorLine	                   	ctermbg=236	cterm=none
hi CursorLineNr         ctermfg=87      ctermbg=236     cterm=none
hi DiffAdd		ctermfg=234	ctermbg=74	cterm=none
hi DiffChange	        ctermfg=234	ctermbg=144	cterm=none
hi DiffDelete	        ctermfg=239	ctermbg=234	cterm=none
hi DiffText		ctermfg=124	ctermbg=144	cterm=none
hi Folded 		ctermfg=242	ctermbg=234	cterm=none
hi MatchParen	        ctermfg=221	ctermbg=236	cterm=bold,underline
hi ModeMsg		ctermfg=250	ctermbg=234	cterm=bold
hi Normal 		ctermfg=250	ctermbg=234	cterm=none
hi Pmenu		ctermfg=81	ctermbg=236	cterm=none
hi PmenuSel		ctermfg=236	ctermbg=81	cterm=bold
hi PmenuSbar	        ctermfg=234	ctermbg=234	cterm=none
hi PmenuThumb	        ctermfg=234	ctermbg=none	cterm=none
hi PreProc		ctermfg=221	ctermbg=234	cterm=none 
hi Search		ctermfg=234	ctermbg=250	cterm=none
hi Special		ctermfg=74	ctermbg=234	cterm=none
hi Statement	        ctermfg=87	ctermbg=234	cterm=none
hi StatusLine 	        ctermfg=74	ctermbg=236	cterm=bold
hi StatusLineNC         ctermfg=233	ctermbg=236	cterm=none
hi Split                ctermfg=234     ctermbg=234     cterm=none
hi Tabline              ctermfg=250     ctermbg=236     cterm=none
hi TablineSel           ctermfg=74      ctermbg=236     cterm=none
hi TablineFill          ctermfg=74      ctermbg=234     cterm=none
hi Todo 		ctermfg=250	ctermbg=124	cterm=bold
hi Type 		ctermfg=227	ctermbg=234	cterm=none
hi Underlined	        ctermfg=250	ctermbg=234	cterm=underline
hi Visual		ctermfg=234	ctermbg=250	cterm=none
hi Wildmenu		ctermfg=87	ctermbg=234	cterm=bold
hi EasyMotionTarget     ctermfg=87     ctermbg=none    cterm=none
hi EasyMotionShade      ctermfg=239     ctermbg=none    cterm=none
hi EasyMotionTarget2First ctermfg=87   ctermbg=none    cterm=none
hi EasyMotionTarget2Second ctermfg=74  ctermbg=none    cterm=none

hi! link Boolean		Constant
hi! link Character		Constant
hi! link Conditional	Statement
hi! link CursorColumn	CursorLine
hi! link Debug			Special	
hi! link Define			PreProc
hi! link Delimiter		Special
hi! link Directory		Type
hi! link Error			Todo
hi! link ErrorMsg		Error
hi! link Exception		Statement
hi! link Float			Constant
hi! link FoldColumn		Folded
hi! link Function		Normal
hi! link Identifier		Special
hi! link Ignore			Comment
hi! link IncSearch		Search
hi! link Include		PreProc
hi! link Keyword		Statement
hi! link Label			Statement
hi! link LineNr			Comment
hi! link Macro			PreProc
hi! link MoreMsg		ModeMsg
hi! link NonText		Split
hi! link Number			Constant
hi! link Operator		Special
hi! link PreCondit		PreProc
hi! link Question		MoreMsg
hi! link Repeat			Statement
hi! link SignColumn		FoldColumn
hi! link SpecialChar	Special
hi! link SpecialComment	Special
hi! link SpecialKey		Special
hi! link SpellBad		Error
hi! link SpellCap		Error
hi! link SpellLocal		Error
hi! link SpellRare		Error
hi! link StorageClass	Type
hi! link String			Constant
hi! link Structure		Type
hi! link Tag			Special
hi! link Title			ModeMsg
hi! link Typedef		Type
hi! link VertSplit		Split
hi! link WarningMsg		Error

" ada
hi! link adaBegin			Type
hi! link adaEnd				Type
hi! link adaKeyword			Special
" c++
hi! link cppAccess			Type
hi! link cppStatement		Special
" hs
hi! link ConId				Type
hi! link hsPragma			PreProc
hi! link hsConSym			Operator
" html
hi! link htmlArg			Statement
hi! link htmlEndTag			Special
hi! link htmlLink			Underlined
hi! link htmlSpecialTagName	PreProc
hi! link htmlTag			Special
hi! link htmlTagName		Type
" java
hi! link javaTypeDef		Special
" lisp
hi! link lispAtom			Constant
hi! link lispAtomMark		Constant
hi! link lispConcat			Special
hi! link lispDecl			Type
hi! link lispFunc			Special
hi! link lispKey			PreProc
" pas
hi! link pascalAsmKey		Statement
hi! link pascalDirective	PreProc
hi! link pascalModifier		PreProc
hi! link pascalPredefined	Special
hi! link pascalStatement	Type
hi! link pascalStruct		Type
" php
hi! link phpComparison		Special
hi! link phpDefine			Normal
hi! link phpIdentifier		Normal
hi! link phpMemberSelector	Special
hi! link phpRegion			Special
hi! link phpVarSelector		Special
" py
hi! link pythonStatement	Type
" rb
hi! link rubyConstant		Special
hi! link rubyDefine			Type
hi! link rubyRegexp			Special
" scm
hi! link schemeSyntax		Special
" sh
hi! link shArithRegion		Normal
hi! link shDerefSimple		Normal
hi! link shDerefVar			Normal
hi! link shFunction			Type
hi! link shLoop				Statement
hi! link shStatement		Special
hi! link shVariable			Normal
" sql
hi! link sqlKeyword			Statement
" vim
hi! link vimCommand			Statement
hi! link vimCommentTitle	Normal
hi! link vimEnvVar			Special
hi! link vimFuncKey			Type
hi! link vimGroup			Special
hi! link vimHiAttrib		Constant
hi! link vimHiCTerm			Special
hi! link vimHiCtermFgBg		Special
hi! link vimHighlight		Special
hi! link vimHiGui			Special
hi! link vimHiGuiFgBg		Special
hi! link vimOption			Special
hi! link vimSyntax			Special
hi! link vimSynType			Special
hi! link vimUserAttrb		Special
" xml
hi! link xmlAttrib			Special
hi! link xmlCdata			Normal
hi! link xmlCdataCdata		Statement
hi! link xmlCdataEnd		PreProc
hi! link xmlCdataStart		PreProc
hi! link xmlDocType			PreProc
hi! link xmlDocTypeDecl		PreProc
hi! link xmlDocTypeKeyword	PreProc
hi! link xmlEndTag			Statement
hi! link xmlProcessingDelim	PreProc
hi! link xmlNamespace		PreProc
hi! link xmlTagName			Statement
