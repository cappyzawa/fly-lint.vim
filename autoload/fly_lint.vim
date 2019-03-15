" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

let s:save_cpo = &cpo
set cpo&vim

function! fly_lint#validate()
  echo s:fly('validate-pipeline', '-c', expand("%"))
endfunction

function! fly_lint#auto_validate()
  let result = s:trim(s:fly('validate-pipeline', '-c', expand("%")))
  if result == 'looks good'
    echo result
    redraw
  else
    echo result
  endif
endfunction

function! fly_lint#enable_auto_validate()
  let g:fly_lint_auto = v:true
  augroup fly_lint
    autocmd!
    autocmd BufWritePost *.yml,*yaml call fly_lint#auto_validate()
  augroup END
endfunction

function! fly_lint#format()
  echo s:fly('format-pipeline', '-c', expand("%"))
endfunction

function! fly_lint#force_format()
  echo s:fly('format-pipeline', '-w', '-c', expand("%"))
  edit!
endfunction

function! s:fly(...)
  if executable('fly')
    let opts = ''
    for opt in a:000
      let opts = opts . ' ' . opt
    endfor
    return system('fly' . opts)
  endif
endfunction

function! s:trim(str) abort
  let str = a:str
  let str = substitute(str, '^[ \t\n]\+', '', 'g')
  let str = substitute(str, '[ \t\n]\+$', '', 'g')
  return str
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo


