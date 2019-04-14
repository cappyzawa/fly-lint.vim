let s:popup = {
      \ 'window': 0,
      \ }

function! fly_lint#popup#open(formatted)
  call s:popup.open(a:formatted)
endfunction

function! fly_lint#popup#close()
  call s:popup.close()
endfunction

function! s:popup.open(str) dict abort
  let s:buf = nvim_create_buf(0,1)
  let l:str = split(a:str, "\n", 1)
  call nvim_buf_set_lines(s:buf, 0, -1, 0, l:str)
  call nvim_buf_set_option(s:buf, 'syntax', 'yaml')
  let l:self.window = nvim_open_win(s:buf, v:true, {
      \   'height': 80,
      \   'width': 40,
      \   'relative': 'enditor',
      \   'focusable': v:true,
      \   'anchor': 'NW',
      \   'row': 0,
      \   'col': 70,
      \   'external': v:false,
      \})
endfunction

function! s:popup.close() dict abort
  call nvim_win_close(l:self.window, 1)
endfunction
