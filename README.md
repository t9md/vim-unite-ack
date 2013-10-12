!!CAUTION!! NO LONGER MAINTAINED
==================================
I won't maintain or update this program.
Since you now can set `let g:unite_source_grep_command = 'ag'` and it's comfortably fast.

2013-10-12

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

### * `let g:unite_source_ack_targetdir_shortcut`
dictionary which key is `shortcut` and value is `actulal directory`
Please check configuration example.
default: `{}`

### convert output of unite ack with shortcut
set custom filter following
    call unite#custom_filters('ack', ['matcher_default', 'sorter_default', 'converter_ack_shortcut'])

Confituration example
----------------------------------

    command! UniteAckToggleCase :let g:unite_source_ack_ignore_case=!g:unite_source_ack_ignore_case|let g:unite_source_ack_ignore_case
    " show executed commmand
    let g:unite_source_ack_enable_print_cmd = 1
    " define shortcut so that I can use :Unite ack:g:some_method to search some_method from gem directory

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

    " shortcut
    let g:unite_source_ack_targetdir_shortcut = {
                \ 'bundle': '$HOME/.vim/bundle',
                \ 'neco': "$HOME/.vim/bundle/neocomplcache",
                \ 'unite': "$HOME/.vim/bundle/unite.vim",
                \ 'vagrant':  '/var/lib/gems/1.8/gems/vagrant-0.7.5',
                \ 'gem':  '/var/lib/gems/1.8/gems',
                \ 'chef':  '/var/lib/gems/1.8/gems/chef-0.10.0',
                \ 'nova': "$HOME/local/github/openstack/nova-2011.1/nova",
                \ }

    " set filter to use converter_ack_shortcut to let candidate cosmically
    " converted with shortcut
    call unite#custom_filters('ack', ['matcher_default', 'sorter_default', 'converter_ack_shortcut'])
    " command which use shortcut
    command! -nargs=1 SearchBundle :Unite ack:bundle:<args>
    command! -nargs=1 SearchGem    :Unite ack:gem:<args>
    command! -nargs=1 SearchUnite  :Unite ack:unite:<args>
    command! -nargs=1 SearchNeco   :Unite ack:neco:<args>

Screen capture
-----------------------------------------------------------------
![vim-unite-ack.png](https://github.com/t9md/t9md/raw/master/img/vim-unite-ack.png)

