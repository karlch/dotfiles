" Error Message Filtering and Parsing {{{1
" =============================================================================
"
if !exists('g:Tex_IgnoredWarnings')
	let g:Tex_IgnoredWarnings =
		\'Underfull'."\n".
		\'Overfull'."\n".
		\'specifier changed to'."\n".
		\'You have requested'."\n".
		\'Missing number, treated as zero.'."\n".
		\'There were undefined references'."\n".
		\'Citation %.%# undefined'
endif
" This is the number of warnings in the g:Tex_IgnoredWarnings string which
" will be ignored.
if !exists('g:Tex_IgnoreLevel')
	let g:Tex_IgnoreLevel = 7
endif
" There will be lots of stuff in a typical compiler output which will
" completely fall through the 'efm' parsing. This options sets whether or not
" you will be shown those lines.
if !exists('g:Tex_IgnoreUnmatched')
	let g:Tex_IgnoreUnmatched = 1
endif
" With all this customization, there is a slight risk that you might be
" ignoring valid warnings or errors. Therefore before getting the final copy
" of your work, you might want to reset the 'efm' with this variable set to 1.
" With that value, all the lines from the compiler are shown irrespective of
" whether they match the error or warning patterns.
" NOTE: An easier way of resetting the 'efm' to show everything is to do
"       TCLevel strict
if !exists('g:Tex_ShowallLines')
	let g:Tex_ShowallLines = 0
endif

fun! <SID>Strntok(s, tok, n)
	return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfun

function! <SID>IgnoreWarnings()
	let i = 1
	while s:Strntok(g:Tex_IgnoredWarnings, "\n", i) != '' &&
				\ i <= g:Tex_IgnoreLevel
		let warningPat = s:Strntok(g:Tex_IgnoredWarnings, "\n", i)
		let warningPat = escape(substitute(warningPat, '[\,]', '%\\\\&', 'g'), ' ')
		exe 'setlocal efm+=%-G%.%#'.warningPat.'%.%#'
		let i = i + 1
	endwhile
endfunction

function! <SID>SetLatexEfm()

	let pm = ( g:Tex_ShowallLines == 1 ? '+' : '-' )

	setlocal efm=

	if !g:Tex_ShowallLines
		call s:IgnoreWarnings()
	endif

	setlocal efm+=%E!\ LaTeX\ %trror:\ %m
	setlocal efm+=%E!\ %m
	setlocal efm+=%E%f:%l:\ %m

	setlocal efm+=%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#
	setlocal efm+=%+W%.%#\ at\ lines\ %l--%*\\d
	setlocal efm+=%+WLaTeX\ %.%#Warning:\ %m

	exec 'setlocal efm+=%'.pm.'Cl.%l\ %m'
	exec 'setlocal efm+=%'.pm.'Cl.%l\ '
	exec 'setlocal efm+=%'.pm.'C\ \ %m'
	exec 'setlocal efm+=%'.pm.'C%.%#-%.%#'
	exec 'setlocal efm+=%'.pm.'C%.%#[]%.%#'
	exec 'setlocal efm+=%'.pm.'C[]%.%#'
	exec 'setlocal efm+=%'.pm.'C%.%#%[{}\\]%.%#'
	exec 'setlocal efm+=%'.pm.'C<%.%#>%m'
	exec 'setlocal efm+=%'.pm.'C\ \ %m'
	exec 'setlocal efm+=%'.pm.'GSee\ the\ LaTeX%m'
	exec 'setlocal efm+=%'.pm.'GType\ \ H\ <return>%m'
	exec 'setlocal efm+=%'.pm.'G\ ...%.%#'
	exec 'setlocal efm+=%'.pm.'G%.%#\ (C)\ %.%#'
	exec 'setlocal efm+=%'.pm.'G(see\ the\ transcript%.%#)'
	exec 'setlocal efm+=%'.pm.'G\\s%#'
	exec 'setlocal efm+=%'.pm.'O(%*[^()])%r'
	exec 'setlocal efm+=%'.pm.'P(%f%r'
	exec 'setlocal efm+=%'.pm.'P\ %\\=(%f%r'
	exec 'setlocal efm+=%'.pm.'P%*[^()](%f%r'
	exec 'setlocal efm+=%'.pm.'P(%f%*[^()]'
	exec 'setlocal efm+=%'.pm.'P[%\\d%[^()]%#(%f%r'
	if g:Tex_IgnoreUnmatched && !g:Tex_ShowallLines
		setlocal efm+=%-P%*[^()]
	endif
	exec 'setlocal efm+=%'.pm.'Q)%r'
	exec 'setlocal efm+=%'.pm.'Q%*[^()])%r'
	exec 'setlocal efm+=%'.pm.'Q[%\\d%*[^()])%r'
	if g:Tex_IgnoreUnmatched && !g:Tex_ShowallLines
		setlocal efm+=%-Q%*[^()]
	endif
	if g:Tex_IgnoreUnmatched && !g:Tex_ShowallLines
		setlocal efm+=%-G%.%#
	endif

endfunction

if exists('b:tex_pdf_mapped')
	finish
endif

let b:tex_pdf_mapped = 1

" Define commands.
command! -buffer -nargs=* BuildTexPdf call s:BuildTexPdf(0, <f-args>)
command! -buffer -nargs=* BuildAndViewTexPdf call s:BuildTexPdf(1, <f-args>)

if exists('g:tex_pdf_loaded')
    finish
endif
let g:tex_pdf_loaded = 1

" Set the errorformat by calling the functions
call s:SetLatexEfm()

" 1}}}

" Compile and View {{{1
" -----------------------------------------------------------------------------

" Show the list
function! <SID>BuildTexPdf(view_results, ...)

    " record position
    let save_cursor = getpos(".")

    " save work
    silent write

    silent setlocal shell=bash
    silent setlocal shellpipe=2>&1\ \|\ tee\ %s;exit\ \${PIPESTATUS[0]}

    set makeprg=rubber\ -dfsq\ %
    Neomake!

    " redraw vim
    redraw!

endfunction


function! <SID>ViewTexPdf(...)
    sleep 500m
    call ZathuraSync()
    redraw!
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0
