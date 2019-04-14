" execute fly command
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

let s:cmd = {
  \ 'path': 'fly',
  \ }

function! fly_lint#cmd#new()
  return s:cmd
endfunction

function! s:cmd.run(...) dict abort
  let l:opts = ''
  for l:opt in a:000
    let l:opts = l:opts . ' ' . l:opt
  endfor
  return s:trim(system(l:self.path . l:opts))
endfunction

function! s:trim(str) abort
  let l:str = a:str
  let l:str = substitute(l:str, '^[ \t\n]\+', '', 'g')
  let l:str = substitute(l:str, '[ \t\n]\+$', '', 'g')
  return l:str
endfunction
