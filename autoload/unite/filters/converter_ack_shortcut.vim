let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#converter_ack_shortcut#define()"{{{
  return s:converter
endfunction"}}}

let s:converter = {
      \ 'name' : 'converter_ack_shortcut',
      \ 'description' : 'ack shortcut converter',
      \}

function! s:reverse_sort_by_length(list)
  function! l:f(v1, v2)
    return a:v1 == a:v2 ? 0 : len(a:v1) > len(a:v2) ? 1 : -1
  endfunction
  return reverse(sort(a:list, function("l:f")))
endfunction

function! s:reverse_convert_shortcut(path)
  let path = a:path
  let path = fnamemodify(a:path, ":~")

  let s:reverse_shortcut = {}
  for [key, val] in items(g:unite_source_ack_targetdir_shortcut)
    let s:reverse_shortcut[fnamemodify(expand(val), ":~")] = "[". key. "]"
  endfor
  for p in s:reverse_sort_by_length(keys(s:reverse_shortcut))
    let path = substitute(path, escape(p,'~.'), get(s:reverse_shortcut, p), '')
  endfor

  return path
endfunction

function! s:path_string(path)
endfunction

function! s:converter.filter(candidates, context)"{{{
  let candidates = a:candidates
  for candidate in a:candidates
    let candidate.word = s:reverse_convert_shortcut(candidate.word)
  endfor
  return candidates
endfunction"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker

