" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:all_popup = {'exists': 0}
let s:floating_window_available = has('nvim') && exists('*nvim_win_set_config')

function! fly_lint#validate()
  echo s:fly('validate-pipeline', '-c', expand('%'))
endfunction

function! fly_lint#auto_validate()
  let result = s:trim(s:fly('validate-pipeline', '-c', expand('%')))
  if result ==# 'looks good'
    echo result
    redraw
  else
    echo result
  endif
endfunction

function! fly_lint#enable_auto_validate()
  augroup fly_lint
    autocmd!
    autocmd BufWritePost *.yml,*yaml call fly_lint#auto_validate()
  augroup END
endfunction

function! fly_lint#disable_auto_validate()
  augroup fly_lint
    autocmd!
  augroup END
endfunction


function! fly_lint#format()
  let formatted = s:fly('format-pipeline', '-c', expand('%'))

  if !s:floating_window_available
    echo formatted
    return
  endif

  if s:all_popup.exists
    call fly_lint#popup#close()
    let s:all_popup.exists = 0
    return
  endif
  call fly_lint#popup#open(formatted)
  let s:all_popup.exists = 1
endfunction

function! fly_lint#force_format()
  echo s:fly('format-pipeline', '-w', '-c', expand('%'))
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

let &cpoptions = s:save_cpo
unlet s:save_cpo
