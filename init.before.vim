" Modeline and description {{{
" Definitions needed before loading the rest of the configuration
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
" }}}

" Plugin configuration {{{
" Grammalecte
if filereadable('/usr/bin/grammalecte_cli_py')
    let g:grammalecte_cli_py='/usr/bin/grammalecte_cli_py'
endif
" }}}

" Misc configuration {{{
" Prevent trailing whitespaces from being trimmed on write for given filetypes
let g:specific_strip_whitespace_filetypes=[ 'pandoc', 'markdown' ]
" }}}
