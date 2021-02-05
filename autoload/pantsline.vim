function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})

  if empty(info) | return '' | endif

  let msgs = []

  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif

  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif

  return '[' . join(msgs, ',') . '] '
endfunction

function! StatusCurrentFunction() abort
  return get(g:,'coc_status','')
endfunction

function! s:StatusLine()
  let l:s = ''

  if a:current
    " let l:s .= crystalline#mode()
    let l:s .= '%{&paste ?"| PASTE ":""}%{&spell?"| SPELL ":""}'
    " let l:s .= crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif

  let l:s .= ' %f%h%w%m%r %{StatusDiagnostic()}'

  if a:current
    " let l:s .= crystalline#right_sep('', 'Fill') . ' %{StatusCurrentFunction()}'
    let l:s .= ' %{StatusCurrentFunction()}'
  endif

  let l:s .= '%='

  if a:current
    " let l:s .= crystalline#left_sep('', 'Fill') . ' %{&ft} '
    let l:s .= ' %{&ft} '
    " let l:s .= crystalline#left_mode_sep('')
  endif

  " if a:width > 80
    let l:git_branch = fugitive#head()

    if l:git_branch != ""
      let l:formatted_git_branch = get(l:, 'git_branch', '') . ' | '
    else
      let l:formatted_git_branch = ''
    endif

    let l:s .= ' '. get(l:, 'formatted_git_branch', '') . '%l/%L:%c%V %p%% '
  " else
  "   let l:s .= ' '
  " endif

  return l:s
endfunction

function! s:SetStatusline()
    " call spaceline#colorscheme_init()

    " if index(g:spaceline_shortline_filetype, &filetype) >= 0
    "   let &l:statusline=s:short_statusline()
    "   return
    " endif

    let &l:statusline = s:StatusLine()
endfunction

function! pantsline#pantsline_toggle()
  if get(g:, 'pantsline_is_loaded', 0) == 1
    call s:SetStatusline()
  else
    let &l:statusline=''
  endif
endfunction
