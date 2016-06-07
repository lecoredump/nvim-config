" Modeline and description {{{
" Plugin configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
scriptencoding utf-8
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
    " Handle installation case to prevent error display
    if filereadable(expand('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim'))
        colorscheme solarized
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast='normal'
        let g:solarized_visibility='normal'
    endif
    " }}}

    " Indent guide {{{
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    " }}}
" }}}

" Versionning / Code Management {{{
    " Nerdtree
    noremap <C-e> :NERDTreeToggle<CR>

    " Git {{{
    let g:gitgutter_eager = 1
    let g:gitgutter_realtime = 1
    " }}}
" }}}

" Completion {{{
    " Deoplete {{{
        let g:deoplete#enable_at_startup = 1

        " Python {{{
        let g:deoplete#sources#jedi#statement_length = 250
        let g:deoplete#sources#jedi#show_docstring = 1
        " }}}

        " C {{{
        let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
        let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
        " }}}

        " Doc display {{{
        let g:echodoc_enable_at_startup = 1
        " }}}
    " }}}

    " Supertab default completion
    " let g:SuperTabDefaultCompletionType = 'context'
    " let g:SuperTabContextDefaultCompletionType = '<c-n>'
" }}}

" Languages / Filetypes {{{
    " Pandoc / Markdown / Latex / Txt / Writing {{{
        " Limelight conceal color for solarized theme
        let g:limelight_conceal_ctermfg = 'black'
        " Goyo & Limelight interaction
        augroup goyo_lime
            autocmd! User GoyoEnter Limelight
            autocmd! User GoyoLeave Limelight!
        augroup END
    " }}}

    " HTML / CSS {{{
        " Color picker config
        " TODO : change colors to fit solarized theme
        if executable('yad')
            let g:vcoolor_custom_picker = 'yad --color --alpha --extra --gtk-palette --expand-palette'
        elseif executable('zenity')
            let g:vcoolor_custom_picker = 'zenity --show-palette'
        endif
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
        autocmd! BufWritePost * Neomake
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
