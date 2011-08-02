call unite#util#set_default('g:unite_source_ack_command', "ack-grep --nocolor --nogroup")
call unite#util#set_default('g:unite_source_ack_enable_highlight', 1)
call unite#util#set_default('g:unite_source_ack_search_word_highlight', 'Search')
call unite#util#set_default('g:unite_source_ack_ignore_case', 0)
call unite#util#set_default('g:unite_source_ack_enable_print_cmd', 0)
call unite#util#set_default('g:unite_source_ack_targetdir_shortcut', {})
call unite#util#set_default('g:unite_source_ack_enable_convert_targetdir_shortcut', 0)

let s:unite_source = {}
let s:unite_source.name = 'ack'
let s:unite_source.description = 'ack the sources'
let s:unite_source.hooks = {}
let s:unite_source.syntax = "uniteSource__Ack"


function! s:unite_source.hooks.on_init(args, context) "{{{
    execute 'highlight default link uniteSource__Ack_target ' . g:unite_source_ack_search_word_highlight
    let targetdir  = get(a:args, 0, '')
    let search     = get(a:args, 1, '')
    if empty(search)  | let search = input('Search: ')| endif
    
    let a:context.source__directory = get(g:unite_source_ack_targetdir_shortcut, targetdir, targetdir)
    let a:context.source__search = search
endfunction"}}}

function! s:unite_source.hooks.on_syntax(args, context) "{{{
    if !g:unite_source_ack_enable_highlight | return | endif
    if g:unite_source_ack_ignore_case
        syn case ignore
    endif
    execute "syntax match uniteSource__Ack_target '" . a:context.source__search . "' containedin=uniteSource__Ack"
endfunction"}}}

function! s:unite_source.gather_candidates(args, context)
    " call unite#print_message( string(a:args ))
    let ack_cmd = g:unite_source_ack_command
    if g:unite_source_ack_ignore_case
        let ack_cmd.= " -i "
    endif
    let cmd=ack_cmd . " '" . a:context.source__search . "' "

    if !empty(a:context.source__directory)
        let cmd = cmd . " " . a:context.source__directory
    endif

    if g:unite_source_ack_enable_print_cmd
        call unite#print_message(cmd)
    endif
    
    let lines = split(system(cmd), "\n")
    let candidates = []
    for line in lines
        let [fname, lineno, text ] = matchlist(line,'\v(.{-}):(\d+):(.*)$')[1:3]
        call add(candidates, {
                    \ "word": fname . ":" . lineno . ":" . text,
                    \ "source": "ack",
                    \ "kind": "jump_list",
                    \ "action__path": fname,
                    \ "action__line": lineno,
                    \ "action__text": text,
                    \ } )
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
" vim: expandtab:ts=4:sts=4:sw=4
