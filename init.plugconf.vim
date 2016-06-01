" Modeline and description {{{
" Plugin configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
scriptencoding utf-8
" }}}

" Configuration functions {{{

" Handle multiple completion types
" TODO: handle list based on filetype
function! CompletionChain(findstart, base)
  if a:findstart
    " Test against the functions one by one
    for l:func in g:user_completion_chain
      let l:pos = call(l:func, [a:findstart, a:base])
      " If a function can complete the prefix,
      " remember the name and return the result from the function
      if l:pos >= 0
        let s:current_completion = l:func
        return l:pos
      endif
    endfor

    " No completion can be done
    unlet! s:current_completion
    return -1
  elseif exists('s:current_completion')
    " Simply pass the arguments to the selected function
    return call(s:current_completion, [a:findstart, a:base])
  else
    return []
  endif
endfunction

" }}}

" Plugins configuration {{{
" UI {{{
    " vim-airline {{{
    let g:airline_theme='dark'
    let g:airline_powerline_fonts = 1
    " Display buffer list in tabline on single tab
    let g:airline#extensions#tabline#enabled = 1
    " Enable NrrwRgn integration
    let g:airline#extensions#nrrwrgn#enabled = 1
    " }}}

    " Solarized config {{{
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast='normal'
    let g:solarized_visibility='normal'
    " Handle installation case to prevent error display
    if filereadable(expand('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim'))
        colorscheme solarized
    endif
    " }}}

    " Indent guide {{{
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    " }}}
" }}}

" Utilities {{{
    " Versionning {{{
        " Git {{{
        let g:gitgutter_eager = 1
        let g:gitgutter_realtime = 1
        " }}}
        " }}}
    " Completion {{{
        " Deoplete {{{
        let g:deoplete#enable_at_startup = 1

        " Tab completion
        " TODO: Needs to handle actual tab input
        inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

        " }}}
    " }}}

    " Languages / Filetypes {{{
        " HTML / CSS {{{
        " Color picker config
        " TODO : change colors to fit solarized theme
        if executable('yad')
            let g:vcoolor_custom_picker = 'yad --color --alpha --extra --gtk-palette --expand-palette'
        elseif executable('zenity')
            let g:vcoolor_custom_picker = 'zenity --show-palette'
        endif
        " }}}

        " Python {{{
        let g:deoplete#sources#jedi#statement_length = 250
        let g:deoplete#sources#jedi#show_docstring = 1
        " }}}
    " }}}

    " Syntax checking {{{
        " Neomake {{{
        " Open quickfix after check if necessary
        let g:neomake_open_list = 2
        " Run each maker one after another
        let g:neomake_serialize = 1
        let g:neomake_warning_sign= {
            \ 'text': '',
            \ 'texthl': 'WarningMsg',
            \ }
        let g:neomake_error_sign = {
            \ 'text': '',
            \ 'texthl': 'WarningMsg',
            \ }

        augroup neomake
            autocmd! BufWritePost *.* Neomake
        augroup END
        " }}}
    " }}}

    " Misc {{{
        " Undo tree tab {{{
        if has('persistent_undo')
            set undodir=~/.config/nvim/.undo/
            set undofile
        endif
        let g:undotree_WindowLayout = 4
        let g:undotree_SetFocusWhenToggle = 1
        nnoremap <leader>u :UndotreeToggle<CR>
        " }}}
        " Unite {{{
        nnoremap <C-l> :Unite file file_rec<CR>
        " }}}
    " }}}
" }}}

" }}}

