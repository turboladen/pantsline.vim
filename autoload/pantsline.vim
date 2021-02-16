scriptencoding utf-8

function! s:separator_lhs() abort
  return ''
  " return ''
endfunction

function! s:separator_rhs() abort
  return ''
  " return ''
endfunction

function! s:git_branch() abort
  if exists('*FugitiveHead')
    return '' . FugitiveHead()
  endif

  return ''
endfunction

function! s:file_format() abort
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! s:file_type_icon() abort
  if exists('*WebDevIconsGetFileTypeSymbol')
    return WebDevIconsGetFileTypeSymbol()
  endif

  return ''
endfunction

function! s:file_type() abort
  if winwidth(0) < 70
    return s:file_type_icon()
  endif

  return !empty(&filetype) ? &filetype : 'no ft'
endfunction

function! s:file_encoding() abort
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! s:file_name() abort
  let l:name = ''

  if &readonly
    let l:name .= ''
  endif

  let l:expanded_name = expand('%t')

  if empty(l:expanded_name)
    return l:name . ' No Name'
  else
    let l:name .= s:file_type_icon() . ' %-.{64}' . l:expanded_name
  endif

  if &modified
    let l:name .= '✹'
  endif

  return l:name
endfunction

function! s:mode_type() abort
  if mode() =~# '[nc]'
    return 'n'
  elseif mode() =~# '[it]'
    return 'i'
  elseif mode() =~# '[vVsS]'
    return 'v'
  elseif mode() ==# 'R'
    return 'R'
  endif

  return ''
endfunction

function! s:mode_label() abort
  return g:pantsline_mode_labels[s:mode_type()]
endfunction

function! s:inactive_status_line()
  let l:s = ' '
  let l:s .= <SID>file_name()
  let l:s .= '%w'
  let l:s .= ' %='
  let l:s .= ' %{&filetype} %p%% '

  return l:s
endfunction

function! s:status_line()
  let l:s = &paste ? ' %#Normal#PASTE ' : '%#Normal#'

  return l:s . s:mode_label()
    \ . ' %#PantslineKuroiPurpleSeparator#' . s:separator_lhs()
    \ . ' %#PantslineKuroiPurple#' . s:file_name()
    \ . ' %#PantslineKuroiPurpleSeparator#' . s:separator_rhs() . '%#Normal#'
    \ . ' ' . coc#status()
    \ . ' %='
    \ . '%#PantslineKuroiBlueSeparator#' . s:separator_lhs()
    \ . ' %#PantslineKuroiBlue#' . s:git_branch() . ' | ' . s:file_type()
    \ . ' %#PantslineKuroiBlueSeparator#' . s:separator_rhs() . '%#Normal#'
    \ . ' %l:%c%V %p%% '
endfunction

function! s:set_status_line()
  " call spaceline#colorscheme_init()

  " if index(g:spaceline_shortline_filetype, &filetype) >= 0
  "   let &l:statusline=s:short_statusline()
  "   return
  " endif

  let &l:statusline = <SID>status_line()
endfunction

function! pantsline#pantsline_toggle()
  if get(g:, 'pantsline_is_loaded', 0) == 1
    call <SID>set_status_line()
  else
    let &l:statusline=''
  endif
endfunction

function! pantsline#setInactiveStatusLine()
  let &l:statusline = <SID>inactive_status_line()

  " call pantsline#colorscheme_init()
endfunction
