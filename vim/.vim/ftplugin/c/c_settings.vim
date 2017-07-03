" Run Program
nnoremap <buffer> <leader>d :VimuxRunCommand("./<C-R>=expand("%:t:r")<CR>")<CR><CR>

" Run Compiler
nnoremap <buffer> <leader>a :Neomake!<CR>

" Run root
nnoremap <buffer> <leader>r :VimuxRunCommand("root -l <C-R>=expand("%")<CR>")<CR><CR>
nnoremap <buffer> <leader>s :VimuxRunCommand(".q")<CR><CR>

" vim-clang
let g:clang_cpp_options = '-pthread -std=c++1y -m64 -I/usr/include/root'
let g:clang_c_options = '-pthread -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/libdrm -I/usr/include/libpng16 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include'

let g:clang_format_style = 'WebKit'
let g:clang_cpp_completeopt = 'menuone,longest'
let g:clang_diagsopt = ''

" CPP Highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Neomake
let g:neomake_verbose = 1
let g:neomake_c_clanggtk_maker = {
    \ 'exe': 'clang',
    \ 'args': ['-Wall',
    \          '-Wextra',
    \          '-pthread',
    \          '-I/usr/include/gtk-3.0',
    \          '-I/usr/include/at-spi2-atk/2.0',
    \          '-I/usr/include/at-spi-2.0',
    \          '-I/usr/include/dbus-1.0',
    \          '-I/usr/lib/dbus-1.0/include',
    \          '-I/usr/include/gtk-3.0',
    \          '-I/usr/include/gio-unix-2.0/',
    \          '-I/usr/include/cairo',
    \          '-I/usr/include/pango-1.0',
    \          '-I/usr/include/atk-1.0',
    \          '-I/usr/include/cairo',
    \          '-I/usr/include/pixman-1',
    \          '-I/usr/include/freetype2',
    \          '-I/usr/include/libpng16',
    \          '-I/usr/include/harfbuzz',
    \          '-I/usr/include/glib-2.0',
    \          '-I/usr/lib/glib-2.0/include',
    \          '-I/usr/include/freetype2',
    \          '-I/usr/include/harfbuzz',
    \          '-I/usr/include/libdrm',
    \          '-I/usr/include/libpng16',
    \          '-I/usr/include/gdk-pixbuf-2.0',
    \          '-I/usr/include/libpng16',
    \          '-I/usr/include/glib-2.0',
    \          '-I/usr/lib/glib-2.0/include',
    \          '-lgtk-3',
    \          '-lgdk-3',
    \          '-lpangocairo-1.0',
    \          '-lpango-1.0',
    \          '-latk-1.0',
    \          '-lcairo-gobject',
    \          '-lcairo',
    \          '-lgdk_pixbuf-2.0',
    \          '-lgio-2.0',
    \          '-lgobject-2.0',
    \          '-lglib-2.0',
    \          '-o%:t:r',
    \          '-pedantic'],
    \ 'errorformat': '%E%f:%l:%c: fatal error: %m,' .
    \                '%E%f:%l:%c: error: %m,' .
    \                '%W%f:%l:%c: warning: %m,' .
    \                '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
    \                '%E%m'
    \ }

let g:neomake_cpp_clang_maker = {
    \ 'exe': 'clang++',
    \ 'args': ['-Wall',
    \          '-Wextra',
    \          '-L/usr/lib/root',
    \          '-lGui',
    \          '-lCore',
    \          '-lRIO',
    \          '-lNet',
    \          '-lHist',
    \          '-lGraf',
    \          '-lGraf3d',
    \          '-lGpad',
    \          '-lTree',
    \          '-lRint',
    \          '-lPostscript',
    \          '-lMatrix',
    \          '-lPhysics',
    \          '-lMathCore',
    \          '-lThread',
    \          '-lMultiProc',
    \          '-pthread',
    \          '-lm',
    \          '-ldl',
    \          '-rdynamic',
    \          '-m64',
    \          '-o%:t:r',
    \          '-pedantic'],
    \ 'errorformat': '%E%f:%l:%c: fatal error: %m,' .
    \                '%E%f:%l:%c: error: %m,' .
    \                '%W%f:%l:%c: warning: %m,' .
    \                '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
    \                '%E%m'
    \ }
let g:neomake_cpp_enabled_makers = ['clang']
