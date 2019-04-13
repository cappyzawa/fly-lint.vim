let s:popup = {}
let s:floating_window_available = has('nvim') && exists('*nvim_win_set_config')

function! s:popup__close() dict abort
  if !has_key(self, 'bufnr')
    " Already closed
    return
  endif

  let winnr = self.get_winnr()
  if winnr > 0
    " Without this 'noautocmd', the BufWipeout event will be triggered and
    " this function will be called again.
    noautocmd execute winnr . 'wincmd c'
  endif

  unlet self.bufnr
  unlet self.win_id

  if has_key(self.opts, 'did_close')
    call self.opts.did_close(self)
  endif
endfunction
