" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

let s:viewers = [
      \ 'general',
      \ 'mupdf',
      \ 'zathura',
      \ ]
for viewer in s:viewers
  execute 'let s:' . viewer . ' = {}'
endfor

function! vimtex#view#init_options() " {{{1
  call vimtex#util#set_default('g:vimtex_view_enabled', 1)
  if !g:vimtex_view_enabled | return | endif

  call vimtex#util#set_default('g:vimtex_view_method', 'general')
endfunction

" }}}1
function! vimtex#view#init_script() " {{{1
endfunction

" }}}1
function! vimtex#view#init_buffer() " {{{1
  if !g:vimtex_view_enabled | return | endif

  "
  " Add viewer to the data blob
  "
  let viewer = 's:' . g:vimtex_view_method
  if !exists(viewer)
    echoerr 'vimtex viewer ' . g:vimtex_view_method . ' does not exist!'
    echo "\nPlease see :h g:vimtex_view_method\n\n"
    let b:vimtex.viewer = {}
    return
  endif
  execute 'let b:vimtex.viewer = deepcopy(' . viewer . ')'
  call b:vimtex.viewer.init()

  "
  " Create view and/or callback hooks (if they exist)
  "
  for point in ['view', 'callback']
    execute 'let hook = ''g:vimtex_view_'
          \ . g:vimtex_view_method . '_hook_' . point . ''''
    if exists(hook)
      execute 'let hookfunc = ''*'' . ' . hook
      if exists(hookfunc)
        execute 'let b:vimtex.viewer.hook_' . point . ' = function(' . hook . ')'
      endif
    endif
  endfor

  "
  " Define commands
  "
  command! -buffer -nargs=? -complete=file VimtexView
        \ call b:vimtex.viewer.view(<q-args>)
  if has_key(b:vimtex.viewer, 'reverse_search')
    command! -buffer -nargs=* VimtexRSearch
          \ call b:vimtex.viewer.reverse_search()
  endif

  "
  " Define mappings
  "
  nnoremap <buffer> <plug>(vimtex-view)
        \ :call b:vimtex.viewer.view('')<cr>
  if has_key(b:vimtex.viewer, 'reverse_search')
    nnoremap <buffer> <plug>(vimtex-reverse-search)
          \ :call b:vimtex.viewer.reverse_search()<cr>
  endif
endfunction

" }}}1

"
" Define viewers
"
" {{{1 General
function! s:general.init() dict " {{{2
  "
  " Set default options
  "

  call vimtex#util#set_default_os_specific('g:vimtex_view_general_viewer',
        \ {
        \   'linux' : 'xdg-open',
        \   'mac'   : 'open',
        \ })
  call vimtex#util#set_default('g:vimtex_view_general_options', '@pdf')
  call vimtex#util#set_default('g:vimtex_view_general_options_latexmk', '')

  if !executable(g:vimtex_view_general_viewer)
    echoerr 'vimtex viewer is not executable!'
    echoerr 'g:vimtex_view_general_viewer = '
          \ . g:vimtex_view_general_viewer
  endif
endfunction

" }}}2
function! s:general.view(file) dict " {{{2
  let outfile = a:file !=# '' ? a:file : b:vimtex.out()
  if s:output_not_readable(outfile) | return | endif

  " Parse options
  let opts = g:vimtex_view_general_options
  let opts = substitute(opts, '@line', line('.'), 'g')
  let opts = substitute(opts, '@col', col('.'), 'g')
  let opts = substitute(opts, '@tex',
        \ vimtex#util#shellescape(expand('%:p')), 'g')
  let opts = substitute(opts, '@pdf', vimtex#util#shellescape(outfile), 'g')

  " Construct the command
  let exe = {}
  let exe.cmd = g:vimtex_view_general_viewer . ' ' . opts
  call vimtex#util#execute(exe)
  let self.cmd_view = exe.cmd

  if has_key(self, 'hook_view')
    call self.hook_view()
  endif
endfunction

" }}}2
function! s:general.latexmk_append_argument() dict " {{{2
  return vimtex#latexmk#add_option('pdf_previewer',
        \   g:vimtex_view_general_viewer . ' '
        \ . g:vimtex_view_general_options_latexmk)
endfunction

" }}}2

" {{{1 MuPDF
function! s:mupdf.init() dict " {{{2
  " Only initialize once
  if has_key(self, 'xwin_id') | return | endif

  "
  " Default MuPDF settings
  "
  call vimtex#util#set_default('g:vimtex_view_mupdf_options', '')
  call vimtex#util#set_default('g:vimtex_view_mupdf_send_keys', '')
  call vimtex#util#set_default('g:vimtex_view_mupdf_hook_callback',
        \ 's:focus_vim')
  call vimtex#util#set_default('g:vimtex_view_mupdf_hook_view',
        \ 's:focus_viewer')

  if !executable('mupdf')
    echoerr 'vimtex viewer MuPDF is not executable!'
  endif

  if !executable('xdotool')
    call vimtex#echo#warning('vimtex viewer MuPDF requires xdotool!')
  endif

  let self.class = 'MuPDF'
  let self.xwin_id = 0
  let self.xwin_exists = function('s:xwin_exists')
  let self.xwin_get_id = function('s:xwin_get_id')
  let self.xwin_send_keys = function('s:xwin_send_keys')
  let self.focus_vim = function('s:focus_vim')
  let self.focus_viewer = function('s:focus_viewer')
endfunction

" }}}2
function! s:mupdf.view(file) dict " {{{2
  let outfile = a:file !=# '' ? a:file : b:vimtex.out()
  if s:output_not_readable(outfile) | return | endif

  if !self.xwin_exists()
    call self.start(outfile)
  else
    call self.forward_search(outfile)
  endif

  if has_key(self, 'hook_view')
    call self.hook_view()
  endif
endfunction

" }}}2
function! s:mupdf.start(outfile) dict " {{{2
  let exe = {}
  let exe.cmd  = 'mupdf ' .  g:vimtex_view_mupdf_options
  let exe.cmd .= ' ' . vimtex#util#shellescape(a:outfile)
  call vimtex#util#execute(exe)
  let self.cmd_start = exe.cmd

  sleep 300m

  call self.xwin_get_id()
  call self.xwin_send_keys(g:vimtex_view_mupdf_send_keys)
  call self.forward_search(a:outfile)
endfunction

" }}}2
function! s:mupdf.forward_search(outfile) dict " {{{2
  if !executable('xdotool') | return | endif
  if !executable('synctex') | return | endif

  let self.cmd_synctex_view = 'synctex view -i '
        \ . (line('.') + 1) . ':'
        \ . (col('.') + 1) . ':'
        \ . vimtex#util#shellescape(expand('%:p'))
        \ . ' -o ' . vimtex#util#shellescape(a:outfile)
        \ . " | grep -m1 'Page:' | sed 's/Page://' | tr -d '\n'"
  let self.page = system(self.cmd_synctex_view)

  if self.page > 0
    let exe = {}
    let exe.cmd  = 'xdotool'
    let exe.cmd .= ' type --window ' . self.xwin_id
    let exe.cmd .= ' "' . self.page . 'g"'
    call vimtex#util#execute(exe)
    let self.cmd_forward_search = exe.cmd
  endif

  call self.focus_viewer()
endfunction

" }}}2
function! s:mupdf.reverse_search() dict " {{{2
  if !executable('xdotool') | return | endif
  if !executable('synctex') | return | endif

  let outfile = b:vimtex.out()
  if s:output_not_readable(outfile) | return | endif

  if !self.xwin_exists()
    call vimtex#echo#warning(
          \ 'vimtex reverse search failed (is MuPDF open?)')
    return
  endif

  " Get page number
  let self.cmd_getpage  = 'xdotool getwindowname ' . self.xwin_id
  let self.cmd_getpage .= " | sed 's:.* - \\([0-9]*\\)/.*:\\1:'"
  let self.cmd_getpage .= " | tr -d '\n'"
  let self.page = system(self.cmd_getpage)
  if self.page <= 0 | return | endif

  " Get file
  let self.cmd_getfile  = 'synctex edit '
  let self.cmd_getfile .= "-o \"" . self.page . ':288:108:' . outfile . "\""
  let self.cmd_getfile .= "| grep 'Input:' | sed 's/Input://' "
  let self.cmd_getfile .= "| head -n1 | tr -d '\n' 2>/dev/null"
  let self.file = system(self.cmd_getfile)

  " Get line
  let self.cmd_getline  = 'synctex edit '
  let self.cmd_getline .= "-o \"" . self.page . ':288:108:' . outfile . "\""
  let self.cmd_getline .= "| grep -m1 'Line:' | sed 's/Line://' "
  let self.cmd_getline .= "| head -n1 | tr -d '\n'"
  let self.line = system(self.cmd_getline)

  " Go to file and line
  silent exec 'edit ' . fnameescape(self.file)
  if self.line > 0
    silent exec ':' . self.line
    " Unfold, move to top line to correspond to top pdf line, and go to end of
    " line in case the corresponding pdf line begins on previous pdf page.
    normal! zvztg_
  endif
endfunction

" }}}2
function! s:mupdf.latexmk_callback() dict " {{{2
  if !self.xwin_exists()
    if self.xwin_get_id()
      call self.xwin_send_keys(g:vimtex_view_mupdf_send_keys)
      call self.forward_search(b:vimtex.out())
      if has_key(self, 'hook_callback')
        call self.hook_callback()
      endif
    endif
  endif
endfunction

" }}}2
function! s:mupdf.latexmk_append_argument() dict " {{{2
  let cmd  = vimtex#latexmk#add_option('new_viewer_always', '0')
  let cmd .= vimtex#latexmk#add_option('pdf_update_method', '2')
  let cmd .= vimtex#latexmk#add_option('pdf_update_signal', 'SIGHUP')
  let cmd .= vimtex#latexmk#add_option('pdf_previewer',
        \ 'mupdf ' .  g:vimtex_view_mupdf_options)
  return cmd
endfunction

" }}}2

" {{{1 Zathura
function! s:zathura.init() dict " {{{2
  " Only initialize once
  if has_key(self, 'xwin_id') | return | endif

  "
  " Default Zathura settings
  "
  call vimtex#util#set_default('g:vimtex_view_zathura_options', '')
  call vimtex#util#set_default('g:vimtex_view_zathura_hook_callback',
        \ 's:focus_vim')
  call vimtex#util#set_default('g:vimtex_view_zathura_hook_view',
        \ 's:focus_viewer')

  if !executable('zathura')
    echoerr 'vimtex viewer Zathura is not executable!'
  endif

  if !executable('xdotool')
    call vimtex#echo#warning('vimtex viewer Zathura requires xdotool!')
  endif

  let self.class = 'Zathura'
  let self.xwin_id = 0
  let self.xwin_get_id = function('s:xwin_get_id')
  let self.xwin_exists = function('s:xwin_exists')
endfunction

" }}}2
function! s:zathura.view(file) dict " {{{2
  let outfile = a:file !=# '' ? a:file : b:vimtex.out()
  if s:output_not_readable(outfile) | return | endif

  if !self.xwin_exists()
    call self.start(outfile)
  else
    call self.forward_search(outfile)
  endif

  if has_key(self, 'hook_view')
    call self.hook_view()
  endif
endfunction

" }}}2
function! s:zathura.start(outfile) dict " {{{2
  let exe = {}
  let exe.cmd  = 'zathura ' .  g:vimtex_view_zathura_options
  let exe.cmd .= ' -x "' . exepath(v:progname)
        \ . ' --servername ' . v:servername
        \ . ' --remote +\%{line} \%{input}"'
  let exe.cmd .= ' ' . vimtex#util#shellescape(a:outfile)
  call vimtex#util#execute(exe)
  let self.cmd_start = exe.cmd

  sleep 300m

  call self.xwin_get_id()
  call self.forward_search(a:outfile)
endfunction

" }}}2
function! s:zathura.forward_search(outfile) dict " {{{2
  let exe = {}
  let exe.cmd  = 'zathura --synctex-forward '
  let exe.cmd .= line('.')
  let exe.cmd .= ':' . col('.')
  let exe.cmd .= ':' . vimtex#util#shellescape(expand('%:p'))
  let exe.cmd .= ' ' . vimtex#util#shellescape(a:outfile)
  call vimtex#util#execute(exe)
  let self.cmd_forward_search = exe.cmd
endfunction

" }}}2
function! s:zathura.latexmk_callback() dict " {{{2
  if !self.xwin_exists()
    if self.xwin_get_id()
      call self.forward_search(b:vimtex.out())
      if has_key(self, 'hook_callback')
        call self.hook_callback()
      endif
    endif
  endif
endfunction

" }}}2
function! s:zathura.latexmk_append_argument() dict " {{{2
  let cmd  = vimtex#latexmk#add_option('new_viewer_always', '0')
  let cmd .= vimtex#latexmk#add_option('pdf_previewer',
        \ 'zathura ' . g:vimtex_view_zathura_options
        \ . ' -x \"' . exepath(v:progname)
        \ . ' --servername ' . v:servername
        \ . ' --remote +\%{line} \%{input}\" \%S')

  return cmd
endfunction

" }}}2
" }}}1

"
" Common functionality
"
function! s:output_not_readable(output) " {{{1
  if !filereadable(a:output)
    call vimtex#echo#warning('vimtex viewer can not read PDF file!')
    return 1
  else
    return 0
  endif
endfunction

" }}}1
function! s:xwin_get_id() dict " {{{1
  if !executable('xdotool') | return 0 | endif
  if self.xwin_id > 0 | return 0 | endif

  let cmd = 'xdotool search --class ' . self.class
  let xwin_ids = split(system(cmd), '\n')
  if len(xwin_ids) == 0
    call vimtex#echo#warning(
          \ 'vimtex viewer can not find ' . self.class . ' window ID!')
    let self.xwin_id = 0
  else
    let self.xwin_id = xwin_ids[-1]
  endif

  return self.xwin_id
endfunction

" }}}1
function! s:xwin_exists() dict " {{{1
  if !executable('xdotool') | return 0 | endif

  let cmd = 'xdotool search --class ' . self.class
  if index(split(system(cmd), '\n'), self.xwin_id) >= 0
    return 1
  endif

  if self.xwin_id > 0
    let self.xwin_id = 0
  endif

  return 0
endfunction

" }}}1
function! s:xwin_send_keys(keys) dict " {{{1
  if !executable('xdotool') | return | endif

  if a:keys !=# ''
    let cmd  = 'xdotool key --window ' . self.xwin_id
    let cmd .= ' ' . a:keys
    silent call system(cmd)
  endif
endfunction

" }}}1

"
" Hook functions (used as default hooks in some cases)
"
function! s:focus_viewer() dict " {{{1
  if !executable('xdotool') | return | endif

  if self.xwin_id > 0
    silent call system('xdotool windowfocus ' . self.xwin_id . ' --sync')
    silent call system('xdotool windowraise ' . self.xwin_id)
  endif
endfunction

" }}}1
function! s:focus_vim() dict " {{{1
  if !executable('xdotool') | return | endif

  silent call system('xdotool windowfocus ' . v:windowid . ' --sync')
  silent call system('xdotool windowraise ' . v:windowid)
endfunction

" }}}1

" vim: fdm=marker sw=2
