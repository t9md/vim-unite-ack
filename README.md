Unite plugin for Ack
==================================
Syntax
----------------------------------

    :Unite ack:directory:search_word<CR>

if directory is ommited like
    :Unite ack::search_word<CR>
current directory is used.

Config
----------------------------------

### * `g:unite_source_ack_command`
command which is used.
default: `"ack-grep --nocolor --nogroup"`

### * `g:unite_source_ack_enable_highlight`
control whether ack search keyword is highlighted in unite buffer
default: `1`

### * `g:unite_source_ack_search_word_highlight`
Highlight applied to search word
default: `Search`

### * `g:unite_source_ack_ignore_case`
toggle case sensitivity for ack command(`-i` switch),
so g:unite_source_ack_command shoud not set `-i` explicitly.
this is dirty , not consistent, but usefull.
I'll refactor when time would available.

### * `g:unite_source_ack_enable_print_cmd`
control wheter executed ack command is printed or not.
defaut: `1`

### * `let g:unite_source_ack_targetdir_shortcut`
dictionary which key is `shortcut` and value is `actulal directory`
Please check configuration example.
default: `{}`

Confituration example
----------------------------------

    command! UniteAckToggleCase :let g:unite_source_ack_ignore_case=!g:unite_source_ack_ignore_case|let g:unite_source_ack_ignore_case
    " show executed commmand
    let g:unite_source_ack_enable_print_cmd = 1
    " define shortcut so that I can use :Unite ack:g:some_method to search some_method from gem directory
    let g:unite_source_ack_targetdir_shortcut = {
                \ 'g':  '/var/lib/gems/1.8/gems',
                \ 'b': '$HOME/.vim/bundle'
                \ }

    function! s:escape_visual(...) "{{{
        let escape = a:0 ? a:1 : ''
        normal `<
        let s = col('.') - 1
        normal `>
        let e = col('.') - 1
        let line = getline('.')
        let pat = line[s : e]
        return escape(pat, escape)
    endfunction"}}}
    function! s:visual_unite_input() "{{{
        return s:escape_visual(" ")
    endfunction"}}}
    function! s:visual_unite_arg() "{{{
        return s:escape_visual(' :\')
    endfunction"}}}

    " unite ack
    nnoremap <silent> <Space>a  :<C-u>exe "Unite -buffer-name=ack ack::" . escape(expand('<cword>'),' :\')<CR>
    vnoremap <silent> <Space>a  :<C-u>exe "Unite -buffer-name=ack ack::" . <SID>visual_unite_arg()<CR>
    nnoremap <silent> <Space>A  :<C-u>UniteResume ack<CR>

    command! UniteAckToggleCase :let g:unite_source_ack_ignore_case=!g:unite_source_ack_ignore_case|let g:unite_source_ack_ignore_case

Screen capture
-----------------------------------------------------------------
![vim-unite-ack.png](https://github.com/t9md/t9md/raw/master/img/vim-unite-ack.png)

