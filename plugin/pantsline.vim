scriptencoding utf-8

if exists('g:loaded_pantsline')
  finish
endif

let g:pantsline_is_loaded = 1

" 53, #5f005f = dark purple
" #c5c8c6 = mid/light grey
" 234, #1b1918 = black

" highlight PantslineKuroiPurple           ctermfg=250  ctermbg=53  guibg=#5f005f  guifg=#c5c8c6
" highlight PantslineKuroiPurpleSeparator  ctermfg=234  ctermbg=53  guibg=#5f005f  guifg=#1b1918
highlight PantslineKuroiPurple           ctermfg=53  ctermbg=250  guibg=#c5c8c6  guifg=#5f005f
highlight PantslineKuroiPurpleSeparator  ctermfg=53  ctermbg=234  guibg=#1b1918  guifg=#5f005f

" 17, #00005f = dark blue
" highlight PantslineKuroiDarkBlue           ctermfg=250  ctermbg=53  guibg=#00005f  guifg=#c5c8c6
" highlight PantslineKuroiDarkBlueSeparator  ctermfg=234  ctermbg=53  guibg=#00005f  guifg=#1b1918

" 75, #5fafff = blue
" highlight PantslineKuroiBlue           ctermfg=250  ctermbg=53  guibg=#5fafff  guifg=#1b1918
" highlight PantslineKuroiBlueSeparator  ctermfg=234  ctermbg=53  guibg=#5fafff  guifg=#1b1918

" 17, #005f5f = dark cyan
highlight PantslineKuroiDarkCyan           ctermfg=17  ctermbg=250  guibg=#c5c8c6  guifg=#005f5f
highlight PantslineKuroiDarkCyanSeparator  ctermfg=17  ctermbg=234  guibg=#1b1918  guifg=#005f5f

if !exists('g:pantsline_mode_labels')
  let g:pantsline_mode_labels = {
        \ 'n': ' NOR',
        \ 'i': ' INS',
        \ 'v': ' VIS',
        \ 'R': ' REP',
        \ '': '',
        \ }
endif

" let g:seperate_style = get(g:, 'pantsline_seperate_style', 'slant')
" let g:pantsline_colorscheme = get(g:, 'pantsline_colorscheme', 'pants')
" let g:pantsline_shortline_filetype = ['defx','coc-explorer','dbui','vista','vista_markdown','Mundo','MundoDiff','LuaTree']
" let g:pantsline_scroll_bar_chars = get(g:,'pantsline_scroll_bar_chars', [
"   \  '▁', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'
"   \  ])

" let g:pantsline_diagnostic = get(g:,'pantsline_diagnostic_tool','coc')
" let g:pantsline_diff = get(g:,'pantsline_diff_tool','coc')

" let g:pantsline_errorsign = get(g:,'pantsline_diagnostic_errorsign', '●')
" let g:pantsline_warnsign = get(g:,'pantsline_diagnostic_warnsign', '●')
" let g:pantsline_oksign = get(g:,'pantsline_diagnostic_oksign', '')

" let g:pantsline_branch_icon = get(g:,'pantsline_git_branch_icon','')
" let g:pantsline_diff_icon = get(g:,'pantsline_custom_diff_icon', ['','',''])
" let g:pantsline_funcicon = get(g:,'pantsline_function_icon','')


" let g:separator = {}
" let g:sep = pantsline#seperator#pantslineStyle(g:seperate_style)

function! s:goyo_enter()
  if exists('$TMUX')
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif

  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif

  set showmode
  set showcmd
  set scrolloff=3
  Limelight!
  " ...
endfunction

augroup pantsline
  autocmd!
  " autocmd BufNewFile,BufReadPost * call pantsline#vcs#gitbranch_detect(expand('<amatch>:p:h'))
  " autocmd BufEnter * call pantsline#vcs#gitbranch_detect(expand('%:p:h'))
  autocmd FileType,BufWinEnter,BufReadPost,BufWritePost * call pantsline#pantsline_toggle()
  autocmd BufEnter,WinEnter,BufEnter,FileChangedShellPost  * call pantsline#pantsline_toggle()
  " autocmd Colorscheme * call pantsline#colorscheme_init()
  autocmd VimResized * call pantsline#pantsline_toggle()
  autocmd WinLeave * call pantsline#setInactiveStatusLine()
  autocmd User CocStatusChange,CocGitStatusChange,ClapOnExit,GitGutter,Signify call pantsline#pantsline_toggle()
  autocmd User CocDiagnosticChange call pantsline#pantsline_toggle()
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END
