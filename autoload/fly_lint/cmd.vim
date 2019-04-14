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
  for opt in a:000
    let l:opts = opts . ' ' . opt
  endfor
  return s:trim(system(self.path . opts))
endfunction

function! s:trim(str) abort
  let str = a:str
  let str = substitute(str, '^[ \t\n]\+', '', 'g')
  let str = substitute(str, '[ \t\n]\+$', '', 'g')
  return str
endfunction
