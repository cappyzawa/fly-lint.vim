" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

if exists('g:loaded_concourse_lint')
  finish
endif

let g:loaded_concourse_lint = 1

let s:save_cpo = &cpo
set cpo&vim

" plugin code is here
command! -bar ValidatePipeline call concourse_lint#validate()
command! -bar FormatPipeline call concourse_lint#format()

let &cpo = s:save_cpo
unlet s:save_cpo
