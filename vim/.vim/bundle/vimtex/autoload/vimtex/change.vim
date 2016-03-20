" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#change#init_options() " {{{1
  call vimtex#util#set_default('g:vimtex_change_complete_envs', [
        \ 'itemize',
        \ 'enumerate',
        \ 'description',
        \ 'center',
        \ 'figure',
        \ 'table',
        \ 'equation',
        \ 'multline',
        \ 'align',
        \ 'split',
        \ '\[',
        \ ])
  call vimtex#util#set_default('g:vimtex_change_toggled_delims',
        \ [['\\left', '\\right']])
  call vimtex#util#set_default('g:vimtex_change_ignored_delims_pattern',
        \ '\c\\bigg\?')
  call vimtex#util#set_default('g:vimtex_change_set_formatexpr', 0)
endfunction

" }}}1
function! vimtex#change#init_script() " {{{1
endfunction

" }}}1
function! vimtex#change#init_buffer() " {{{1
  if g:vimtex_change_set_formatexpr
    setlocal formatexpr=vimtex#change#format()
  endif

  nnoremap <silent><buffer> <plug>(vimtex-delete-env)
        \ :call vimtex#change#env('')<cr>

  nnoremap <silent><buffer> <plug>(vimtex-delete-cmd)
        \ :call vimtex#change#command_delete()<cr>

  nnoremap <silent><buffer> <plug>(vimtex-change-env)
        \ :call vimtex#change#env_prompt()<cr>

  nnoremap <silent><buffer> <plug>(vimtex-change-cmd)
        \ :call vimtex#change#command()<cr>

  nnoremap <silent><buffer> <plug>(vimtex-toggle-star)
        \ :call vimtex#change#toggle_env_star()<cr>

  nnoremap <silent><buffer> <plug>(vimtex-toggle-delim)
        \ :call vimtex#change#toggle_delim()<cr>

  nnoremap <silent><buffer> <plug>(vimtex-create-cmd)
        \ :call vimtex#change#to_command()<cr>i

  inoremap <silent><buffer> <plug>(vimtex-create-cmd)
        \ <c-r>=vimtex#change#to_command()<cr>

  inoremap <silent><buffer> <plug>(vimtex-close-env)
        \ <c-r>=vimtex#change#close_environment()<cr>
endfunction

" }}}1

function! vimtex#change#format() " {{{1
  let i0 = v:lnum + v:count - 1
  let i1 = i0

  " This is a hack to make undo restore the correct position
  normal! ix
  normal! x

  while i0 >= v:lnum
    if getline(i0) =~# '[^\\]%'
      if i0 < i1
        execute 'normal!' (i0+1) . 'Ggw' . i1 . 'G'
      endif
      let i1 = i0 - 1
    elseif i0 == v:lnum
      if v:count > 1
        execute 'normal!' i0 . 'Ggw' . i1 . 'G'
      else
        return 1
      endif
    endif
    let i0 = i0 - 1
  endwhile

  return 0
endfunction

" }}}1
function! vimtex#change#get_command(...) " {{{1
  let l:position = a:0 > 0 ? a:1 : searchpos('\S', 'bcn')
  let l:line = getline(l:position[0])
  let l:char = l:line[l:position[1]-1]

  " Lists of relevant syntax regions
  let l:commands = [
        \ 'texStatement',
        \ 'texTypeSize',
        \ 'texTypeStyle',
        \ 'texBeginEnd',
        \ ]
  let l:argument = [
        \ 'texMatcher',
        \ 'texItalStyle',
        \ 'texRefZone',
        \ 'texBeginEndName',
        \ ]

  for l:syntax in reverse(map(call('synstack', l:position),
        \ 'synIDattr(v:val, ''name'')'))
    if index(l:commands, l:syntax) >= 0
      let l:p = searchpos('\\', 'bcn')
      let l:c = matchstr(l:line, '\\\zs\w\+', l:p[1]-1)
      return [l:c] + l:p
    elseif index(l:argument, l:syntax) >= 0
          \ || (l:syntax ==# 'Delimiter' && l:char =~# '{\|}')
      let l:curpos = exists('*getcurpos') ? getcurpos() : getpos('.')
      keepjumps normal! vaBoh
      let l:result = vimtex#change#get_command(searchpos('\S', 'bcn'))
      call setpos('.', l:curpos)
      return l:result
    endif
  endfor

  return ['', 0, 0]
endfunction

function! vimtex#change#command() " {{{1
  " Get old command
  let [l:old, l:line, l:col] = vimtex#change#get_command()
  if l:old ==# '' | return | endif

  " Get new command
  let l:new = input('Change ' . old . ' for: ')
  let l:new = empty(l:new) ? l:old : l:new

  " Store current cursor position
  let l:curpos = exists('*getcurpos') ? getcurpos() : getpos('.')
  if l:line == l:curpos[1]
    let l:curpos[2] += len(l:new) - len(l:old)
  endif

  " This is a hack to make undo restore the correct position
  normal! ix
  normal! x

  " Perform the change
  let l:tmppos = copy(l:curpos)
  let l:tmppos[1:2] = [l:line, l:col+1]
  cal setpos('.', l:tmppos)
  let l:savereg = @a
  let @a = l:new
  normal! cea
  let @a = l:savereg

  " Restore cursor position and create repeat hook
  call setpos('.', l:curpos)
  silent! call repeat#set("\<plug>(vimtex-change-cmd)" . new . '', v:count)
endfunction

function! vimtex#change#command_delete() " {{{1
  " Get old command
  let [l:old, l:line, l:col] = vimtex#change#get_command()
  if l:old ==# '' | return | endif

  " Store current cursor position
  let l:curpos = exists('*getcurpos') ? getcurpos() : getpos('.')
  if l:line == l:curpos[1]
    let l:curpos[2] -= len(l:old)+1
  endif

  " Save selection
  let l:vstart = [l:curpos[0], line("'<"), col("'<"), l:curpos[3]]
  let l:vstop = [l:curpos[0], line("'<"), col("'>"), l:curpos[3]]

  " This is a hack to make undo restore the correct position
  normal! ix
  normal! x

  " Use temporary cursor position
  let l:tmppos = copy(l:curpos)
  let l:tmppos[1:2] = [l:line, l:col]
  call setpos('.', l:tmppos)
  normal! de

  " Delete surrounding braces if present
  if getline('.')[l:col-1 :] =~# '^\s*{'
    call searchpos('{', 'c')
    keepjumps normal! vaBomzoxg`zx
    if l:line == l:curpos[1]
      let l:curpos[2] -= 1
      if l:curpos[2] < 0
        let l:curpos[2] = 0
      endif
    endif
  endif

  " Restore cursor position and visual selection
  call setpos('.', l:curpos)
  call setpos("'<", l:vstart)
  call setpos("'>", l:vstop)

  " Create repeat hook
  silent! call repeat#set("\<plug>(vimtex-delete-cmd)", v:count)
endfunction

function! vimtex#change#close_environment() " {{{1
  " Close delimiters
  let [lnum, cnum] = searchpairpos('\C\\left\>', '', '\C\\right\>', 'bnW',
        \ 'vimtex#util#in_comment()')
  if lnum > 0
    let line = strpart(getline(lnum), cnum - 1)
    let bracket = matchstr(line, '^\\left\zs\((\|\[\|\\{\||\|\.\)\ze')
    for [open, close] in [
          \ ['(', ')'],
          \ ['\[', '\]'],
          \ ['\\{', '\\}'],
          \ ['|', '|'],
          \ ['\.', '|'],
          \ ]
      let bracket = substitute(bracket, open, close, 'g')
    endfor
    return '\right' . bracket
  endif

  " Close environment
  let env = vimtex#util#get_env()
  if env ==# '\['
    return '\]'
  elseif env ==# '\('
    return '\)'
  elseif env !=# ''
    return '\end{' . env . '}'
  endif
endfunction

function! vimtex#change#delim(open, close) " {{{1
  let [d1, l1, c1, d2, l2, c2] = vimtex#util#get_delim()

  let line = getline(l1)
  let line = strpart(line,0,c1 - 1) . a:open . strpart(line, c1 + len(d1) - 1)
  call setline(l1, line)

  if l1 ==# l2
    let n = len(a:open) - len(d1)
    let c2 += n
    let pos = getpos('.')
    let pos[2] += n
    call setpos('.', pos)
  endif

  let line = getline(l2)
  let line = strpart(line,0,c2 - 1) . a:close . strpart(line, c2 + len(d2) - 1)
  call setline(l2, line)
endfunction

function! vimtex#change#env(new) " {{{1
  let [env, l1, c1, l2, c2] = vimtex#util#get_env(1)

  if a:new ==# ''
    let beg = ''
    let end = ''
  elseif a:new ==# '\[' || a:new ==# '['
    let beg = '\['
    let end = '\]'
  elseif a:new ==# '\(' || a:new ==# '('
    let beg = '\('
    let end = '\)'
  else
    let beg = '\begin{' . a:new . '}'
    let end = '\end{' . a:new . '}'
  endif

  let n1 = len(env) - 1
  let n2 = len(env) - 1
  if env !=# '\[' && env !=# '\('
    let n1 += 8
    let n2 += 6
  endif

  let line = getline(l1)
  let line = strpart(line, 0, c1 - 1) . l:beg . strpart(line, c1 + n1)
  call setline(l1, line)
  let line = getline(l2)
  let line = strpart(line, 0, c2 - 1) . l:end . strpart(line, c2 + n2)
  call setline(l2, line)

  if a:new ==# ''
    silent! call repeat#set("\<plug>(vimtex-delete-env)", v:count)
  else
    silent! call repeat#set(
          \ "\<plug>(vimtex-change-env)" . a:new . '', v:count)
  endif
endfunction

function! vimtex#change#env_prompt() " {{{1
  let new_env = input('Change ' . vimtex#util#get_env() . ' for: ', '',
        \ 'customlist,' . s:sidwrap('input_complete'))
  if empty(new_env)
    return
  else
    call vimtex#change#env(new_env)
  endif
endfunction

function! vimtex#change#to_command() " {{{1
  " Get current line
  let line = getline('.')

  " Get cursor position
  let pos = getpos('.')

  " Return if there is no word at cursor
  if mode() ==# 'n'
    let column = pos[2] - 1
  else
    let column = pos[2] - 2
  endif
  if column <= 1 || line[column] =~# '\s'
    return ''
  endif

  " Prepend a backslash to beginning of the current word
  normal! B
  let column = getpos('.')[2]
  if line[column - 1] !=# '\'
    let line = strpart(line, 0, column - 1) . '\' . strpart(line, column - 1)
    call setline('.', line)
  endif

  " Append opening braces to the end of the current word
  normal! E
  let column = getpos('.')[2]
  let pos[2] = column + 1
  if line[column - 1] !=# '{'
    let line = strpart(line, 0, column) . '{' . strpart(line, column)
    call setline('.', line)
    let pos[2] += 1
  endif

  " Restore cursor position
  call setpos('.', pos)
  return ''
endfunction

function! vimtex#change#toggle_delim() " {{{1
  "
  " Toggle \left and \right variants of delimiters
  "
  let [d1, l1, c1, d2, l2, c2] = vimtex#util#get_delim()
  let [newd1, newd2] = s:toggle_delim_get_new(d1, d2)
  if newd1 ==# '' | return 0 | endif

  let line = getline(l1)
  let line = strpart(line, 0, c1 - 1) . newd1 . strpart(line, c1 + len(d1) - 1)
  call setline(l1, line)

  if l1 ==# l2
    let n = len(newd1) - len(d1)
    let c2 += n
    let pos = getpos('.')
    let pos[2] += n
    call setpos('.', pos)
  endif

  let line = getline(l2)
  let line = strpart(line, 0, c2 - 1) . newd2 . strpart(line, c2 + len(d2) - 1)
  call setline(l2, line)

  silent! call repeat#set("\<plug>(vimtex-toggle-delim)", v:count)
endfunction

function! vimtex#change#toggle_env_star() " {{{1
  let env = vimtex#util#get_env()

  if env ==# '\('
    return
  elseif env ==# '\['
    let new_env = equation
  elseif env[-1:] ==# '*'
    let new_env = env[:-2]
  else
    let new_env = env . '*'
  endif

  call vimtex#change#env(new_env)

  silent! call repeat#set("\<plug>(vimtex-toggle-star)", v:count)
endfunction


function! vimtex#change#wrap_selection(wrapper) " {{{1
  keepjumps normal! `>a}
  execute 'keepjumps normal! `<i\' . a:wrapper . '{'
endfunction

function! vimtex#change#wrap_selection_prompt(...) " {{{1
  let env = input('Environment: ', '',
        \ 'customlist,' . s:sidwrap('input_complete'))
  if empty(env)
    return
  endif

  " Make sure custom indentation does not interfere
  let ieOld = &indentexpr
  setlocal indentexpr=""

  if visualmode() ==# 'V'
    execute 'keepjumps normal! `>o\end{' . env . '}'
    execute 'keepjumps normal! `<O\begin{' . env . '}'
    " indent and format, if requested.
    if a:0 && a:1
      normal! gv>
      normal! gvgq
    endif
  else
    execute 'keepjumps normal! `>a\end{' . env . '}'
    execute 'keepjumps normal! `<i\begin{' . env . '}'
  endif

  exe 'setlocal indentexpr=' . ieOld
endfunction
" }}}1

function! s:sidwrap(func) " {{{1
  return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\ze.*$') . a:func
endfunction

function! s:input_complete(lead, cmdline, pos) " {{{1
  return filter(g:vimtex_change_complete_envs, 'v:val =~# ''^' . a:lead . '''')
endfunction

function! s:search_and_skip_comments(pat, ...) " {{{1
  " Usage: s:search_and_skip_comments(pat, [flags, stopline])
  let flags             = a:0 >= 1 ? a:1 : ''
  let stopline  = a:0 >= 2 ? a:2 : 0
  let saved_pos = getpos('.')

  " search once
  let ret = search(a:pat, flags, stopline)

  if ret
    " do not match at current position if inside comment
    let flags = substitute(flags, 'c', '', 'g')

    " keep searching while in comment
    while vimtex#util#in_comment()
      let ret = search(a:pat, flags, stopline)
      if !ret
        break
      endif
    endwhile
  endif

  if !ret
    " if no match found, restore position
    call setpos('.', saved_pos)
  endif

  return ret
endfunction
" }}}1
function! s:toggle_delim_get_new(d1,d2) " {{{1
  if a:d1 =~# g:vimtex_change_ignored_delims_pattern
    return ['', '']
  endif

  let newd1 = ''
  let newd2 = ''
  let delim = g:vimtex_change_toggled_delims

  for i in range(len(delim))
    let d1_1 = type(delim[i]) == 3 ? delim[i][0] : delim[i]
    let d2_1 = type(delim[i]) == 3 ? delim[i][1] : delim[i]
    if a:d1 =~# d1_1 . '\>'
      if i+1 == len(delim)
        let newd1 = substitute(a:d1, d1_1, '', '')
        let newd2 = substitute(a:d2, d2_1, '', '')
      else
        let d1_2 = type(delim[i+1]) == 3 ? delim[i+1][0] : delim[i+1]
        let d2_2 = type(delim[i+1]) == 3 ? delim[i+1][1] : delim[i+1]
        let newd1 = substitute(a:d1, d1_1, d1_2, '')
        let newd2 = substitute(a:d2, d2_1, d2_2, '')
      endif
      break
    endif
  endfor

  if newd1 ==# ''
    if len(a:d1) > 0
      let d1_1 = type(delim[0]) == 3 ? delim[0][0] : delim[0]
      let d2_1 = type(delim[0]) == 3 ? delim[0][1] : delim[0]
      let newd1 = substitute(a:d1, '^', d1_1, '')
      let newd2 = substitute(a:d2, '^', d2_1, '')
    endif
  endif

  return [newd1, newd2]
endfunction

" }}}1

" vim: fdm=marker sw=2
