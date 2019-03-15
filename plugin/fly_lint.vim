" execute fly validate-pipeline or format-pipeline
" Author: cappyzawa <cappyzawa@yahoo.ne.jp>

if exists('g:loaded_fly_lint')
  finish
endif

let g:loaded_fly_lint = 1

let s:save_cpo = &cpo
set cpo&vim

" plugin code is here
command! -bar ValidatePipeline call fly_lint#validate()
command! -bar FormatPipeline call fly_lint#format()
command! -bar ForceFormatPipeline call fly_lint#force_format()
command! -bar EnableAutoValidatePipeline call fly_lint#enable_auto_validate()

nnoremap <silent> <Plug>(validate-pipeline) :<C-u>ValidatePipeline<CR>
nnoremap <silent> <Plug>(format-pipeline) :<C-u>FormatPipeline<CR>
nnoremap <silent> <Plug>(force-format-pipeline) :<C-u>ForceFormatPipeline<CR>
nnoremap <silent> <Plug>(enable-auto-validate-pipeline) :<C-u>EnableAutoValidatePipeline<CR>

if !exists('g:fly_lint_no_default_mapping')
  let g:fly_lint_no_default_mappings = v:false
endif
if !g:fly_lint_no_default_mappings
  nmap <Leader>vp <Plug>(validate-pipeline)
  nmap <Leader>fp <Plug>(format-pipeline)
  nmap <Leader>ffp <Plug>(force-format-pipeline)
  nmap <Leader>ea <Plug>(enable-auto-validate-pipeline)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
