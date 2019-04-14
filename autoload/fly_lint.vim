" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

let s:save_cpo = &cpo
set cpo&vim

let s:all_popup = {'exists': 0}
let s:floating_window_available = has('nvim') && exists('*nvim_win_set_config')

function! s:validate() abort
  let l:cmd = fly_lint#cmd#new()
  return l:cmd.run('validate-pipeline', '-c', expand('%'))
endfunction

function! s:format() abort
  let l:cmd = fly_lint#cmd#new()
  return l:cmd.run('format-pipeline', '-c', expand('%'))
endfunction

function! s:force_format() abort
  let l:cmd = fly_lint#cmd#new()
  return l:cmd.run('format-pipeline', '-w', '-c', expand('%'))
endfunction

function! fly_lint#validate()
  echo s:validate()
endfunction

function! fly_lint#enable_auto_validate()
  augroup fly_lint
    autocmd!
    autocmd BufWritePost *.yml,*yaml call fly_lint#validate()
  augroup END
endfunction

function! fly_lint#disable_auto_validate()
  augroup fly_lint
    autocmd!
  augroup END
endfunction

function! fly_lint#format()
  let l:formatted = s:format()

  if !s:floating_window_available
    echo l:formatted
    return
  endif

  if s:all_popup.exists
    call fly_lint#popup#close()
    let s:all_popup.exists = 0
    return
  endif
  call fly_lint#popup#open(l:formatted)
  let s:all_popup.exists = 1
endfunction

function! fly_lint#force_format()
  call s:force_format()
  edit!
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
