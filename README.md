Unite plugin for Ack
==================================

## try

**:Unite ack**  
or
**:UniteWithCursorWord ack**  

## config
* g:unite_source_ack_command
command which is used.
    default: "ack-grep --nocolor --nogroup"

* g:unite_source_ack_highlight
control whether ack search keyword is highlighted in unite buffer
    default: 1

g:unite_source_ack_highlight_color
color setting applied to search keyword when g:unite_source_ack_highlight is true

    default: "gui=bold ctermfg=255 ctermbg=4 guifg=#ffffff guibg=#0a7383"
