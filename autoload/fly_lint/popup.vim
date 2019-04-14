let s:popup = {}

function! fly_lint#popup#open(formatted)
  call s:popup.open(a:formatted)
endfunction

function! fly_lint#popup#close()
  call s:popup.close()
endfunction

function! s:popup.open(str) dict abort
  let width = 80
  let height = 40
  let enter = v:true
  let focusable = v:true
  let relative = 'editor'
  let anchor = 'NW'

  let row = 0
  let col = 70

  let external = v:false

  let s:buf = nvim_create_buf(0,1)
  let str = split(a:str, "\n", 1)
  call nvim_buf_set_lines(s:buf, 0, -1, 0, str)
  call nvim_buf_set_option(s:buf, 'syntax', 'yaml')
  let self.window = nvim_open_win(s:buf, enter, {
      \   'height': height,
      \   'width': width,
      \   'relative': relative,
      \   'anchor': anchor,
      \   'row': row,
      \   'col': col,
      \   'external': external,
      \})
endfunction

function! s:popup.close() dict abort
  call nvim_win_close(self.window, 1)
endfunction
