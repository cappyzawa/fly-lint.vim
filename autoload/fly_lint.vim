" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:all_popup = {'exists': 0}
let s:floating_window_available = has('nvim') && exists('*nvim_win_set_config')

function! fly_lint#validate()
  let cmd = fly_lint#cmd#new()
  echo cmd.run('validate-pipeline', '-c', expand('%'))
endfunction

function! fly_lint#auto_validate()
  let cmd = fly_lint#cmd#new()
  let result = cmd.run('validate-pipeline', '-c', expand('%'))
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
  let cmd = fly_lint#cmd#new()
  let formatted = cmd.run('format-pipeline', '-c', expand('%'))

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
  let cmd = fly_lint#cmd#new()
  echo cmd.run('format-pipeline', '-w', '-c', expand('%'))
  edit!
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
