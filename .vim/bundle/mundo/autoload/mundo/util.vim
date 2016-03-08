let s:save_cpo = &cpo
set cpo&vim

if exists('g:Mundo_PluginLoaded')
    finish
endif

function! mundo#util#set_default(var, val, ...)  "{{{
    let old_var = get(a:000, 0, '')
    if exists(old_var)
        let {a:var} = {old_var}
    elseif !exists(a:var)
        let {a:var} = a:val
    endif
endfunction"}}}

call mundo#util#set_default(
            \ 'g:mundo_python_path_setup', 0,
            \ 'g:gundo_python_path_setup')

call mundo#util#set_default(
            \ 'g:mundo_first_visible_line', 0,
            \ 'g:gundo_first_visible_line')

call mundo#util#set_default(
            \ 'g:mundo_last_visible_line', 0,
            \ 'g:gundo_last_visible_line')

call mundo#util#set_default(
            \ 'g:mundo_width', 45,
            \ 'g:gundo_width')

call mundo#util#set_default(
            \ 'g:mundo_preview_height', 15,
            \ 'g:gundo_preview_height')

call mundo#util#set_default(
            \ 'g:mundo_preview_bottom', 0,
            \ 'g:gundo_preview_bottom')

call mundo#util#set_default(
            \ 'g:mundo_right', 0,
            \ 'g:gundo_right')

call mundo#util#set_default(
            \ 'g:mundo_help', 0,
            \ 'g:gundo_help')

call mundo#util#set_default(
            \ 'g:mundo_map_move_older', 'j',
            \ 'g:gundo_map_move_older')

call mundo#util#set_default(
            \ 'g:mundo_map_move_newer', 'k',
            \ 'g:gundo_map_move_newer')

call mundo#util#set_default(
            \ 'g:mundo_close_on_revert', 0,
            \ 'g:gundo_close_on_revert')

call mundo#util#set_default(
            \ 'g:mundo_prefer_python3', 0,
            \ 'g:gundo_prefer_python3')

call mundo#util#set_default(
            \ 'g:mundo_auto_preview', 1,
            \ 'g:gundo_auto_preview')

call mundo#util#set_default(
            \ 'g:mundo_verbose_graph', 1,
            \ 'g:gundo_verbose_graph')

call mundo#util#set_default(
            \ 'g:mundo_playback_delay', 60,
            \ 'g:gundo_playback_delay')

call mundo#util#set_default(
            \ 'g:mundo_mirror_graph', 0,
            \ 'g:gundo_mirror_graph')

call mundo#util#set_default(
            \ 'g:mundo_inline_undo', 0,
            \ 'g:gundo_inline_undo')

call mundo#util#set_default(
            \ 'g:mundo_return_on_revert', 1,
            \ 'g:gundo_return_on_revert')

function! mundo#util#init() abort

endfunction


let g:Mundo_PluginLoaded = 1

let &cpo = s:save_cpo
unlet s:save_cpo
