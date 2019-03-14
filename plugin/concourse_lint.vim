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
command! -bar ForceFormatPipeline call concourse_lint#force_format()

nnoremap <silent> <Plug>(validate-pipeline) :<C-u>ValidatePipeline<CR>
nnoremap <silent> <Plug>(format-pipeline) :<C-u>FormatPipeline<CR>
nnoremap <silent> <Plug>(force-format-pipeline) :<C-u>ForceFormatPipeline<CR>

if !exists('g:concourse_no_default_mapping')
  let g:concourse_no_default_mappings = v:false
endif
if !g:concourse_no_default_mappings
  nmap <Leader>vp <Plug>(validate-pipeline)
  nmap <Leader>fp <Plug>(format-pipeline)
  nmap <Leader>ffp <Plug>(force-format-pipeline)
endif

if !exists('g:concourse_lint_auto')
  let g:concourse_lint_auto = v:false
endif
if g:concourse_lint_auto
  augroup concourse_lint
    autocmd!
    autocmd BufWritePost *.yml call concourse_lint#validate()
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo
