let s:unite_source = {}
let s:unite_source.name = 'ack'
let s:unite_source.description = 'ack the sources'
let s:unite_source.hooks = {}
let s:unite_source.syntax = "uniteSource_Ack"

call unite#util#set_default('g:unite_source_ack_command',
            \ "ack-grep --nocolor --nogroup")
call unite#util#set_default('g:unite_source_ack_highlight', 1)
call unite#util#set_default('g:unite_source_ack_highlight_color',
            \ "gui=bold ctermfg=255 ctermbg=4 guifg=#ffffff guibg=#0a7383" )

function! s:unite_source.hooks.on_init(args, context) "{{{
    let a:context.source__search = !empty(a:context.input)
                \ ? a:context.input
                \ : input('Search: ')
    " let a:context.input = "ijjj"
endfunction"}}}

function! s:unite_source.hooks.on_syntax(args, context) "{{{
    if !g:unite_source_ack_highlight | return | endif
    let syncmd = "syntax match uniteSource_Ack_target '" . a:context.source__search . "' containedin=uniteSource_Ack"
    exe syncmd
    exe "highlight uniteSource_Ack_target " . g:unite_source_ack_highlight_color
endfunction"}}}

function! s:unite_source.gather_candidates(args, context)
    let cmd=g:unite_source_ack_command . " '" . a:context.source__search . "'"
    let lines = split(system(cmd), "\n")
    let candidates = []
    for l in lines
        let [fname, line] = matchlist(l,'\v(.{-}):(\d+):')[1:2]
        call add(candidates, { "word": l, "source": "ack", "kind": "jump_list", "action__path": fname, "action__line": line})
    endfor
    return candidates
endfunction

" let b:develop = 1
if exists("b:develop")
    call unite#define_source(s:unite_source)
    unlet s:unite_source
    finish
endif

function! unite#sources#ack#define() "{{{
  return s:unite_source
endfunction "}}}
" }}}
