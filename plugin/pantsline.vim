scriptencoding utf-8

if exists('g:pantsline_is_loaded') || v:version < 700
  finish
endif

let g:pantsline_is_loaded = 1

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

augroup pantsline
  autocmd!
"   autocmd BufNewFile,BufReadPost * call pantsline#vcs#gitbranch_detect(expand('<amatch>:p:h'))
"   autocmd BufEnter * call pantsline#vcs#gitbranch_detect(expand('%:p:h'))
  autocmd FileType,BufWinEnter,BufReadPost,BufWritePost * call pantsline#pantsline_toggle()
  autocmd BufEnter,WinEnter,BufEnter,FileChangedShellPost  * call pantsline#pantsline_toggle()
"   autocmd Colorscheme * call pantsline#colorscheme_init()
  autocmd VimResized * call pantsline#pantsline_toggle()
"   autocmd WinLeave * call pantsline#setInActiveStatusLine()
  autocmd User CocStatusChange,CocGitStatusChange,ClapOnExit,GitGutter,Signify call pantsline#pantsline_toggle()
  autocmd User CocDiagnosticChange call pantsline#pantsline_toggle()
augroup END
