Unite plugin for Ack
==================================
Try
----------------------------------

`Unite ack` or `:UniteWithCursorWord ack`

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


Keymap example
----------------------------------

    function! s:SelectedText() "{{{
        normal `<
        let s = col('.') - 1
        normal `>
        let e = col('.') - 1
        let line = getline('.')
        let pat = line[s : e]
        return pat
    endfunction"}}}
    nnoremap <silent> <Space>a  :<C-u>UniteWithCursorWord ack<CR>
    vnoremap <silent> <Space>a  :<C-u>exe "Unite -buffer-name=ack -input=" .  escape(<SID>SelectedText(), " ") . " ack"<CR>
    nnoremap <silent> <Space>A  :<C-u>UniteResume ack<CR>

    command! UniteAckToggleCase :let g:unite_source_ack_ignore_case=!g:unite_source_ack_ignore_case|let g:unite_source_ack_ignore_case


Screen capture
-----------------------------------------------------------------
![vim-unite-ack.png](https://github.com/t9md/t9md/raw/master/img/vim-unite-ack.png)

