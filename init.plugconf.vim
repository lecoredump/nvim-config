" Modeline and description {{{
" Plug in configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
scriptencoding utf-8
" }}}

" Plugins configuration {{{
" Versionning / Code Management {{{
    " Nerdtree
    noremap <C-e> :NERDTreeToggle<CR>
    inoremap <C-e> <Esc>:NERDTreeToggle<CR>

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
    let g:SuperTabDefaultCompletionType = 'context'
    let g:SuperTabContextDefaultCompletionType = '<c-n>'
" }}}

" Languages / Filetypes {{{
    " Pandoc / Markdown / Latex / Txt / Writing {{{
        " Goyo & Limelight interaction {{{
        " Limelight conceal color for solarized theme
        let g:limelight_conceal_ctermfg = 'black'

        augroup goyo_lime
            autocmd!
            autocmd User GoyoEnter Limelight
            autocmd User GoyoLeave Limelight!
        augroup END

        " Allow automatic diff display in the gutter even in Goyo
        nnoremap <F2> :Goyo<CR>:GitGutterEnable<CR>

        " }}}

        " vim-pandoc {{{
        " TODO : finish pandoc config
        " Support for markdown
        let g:pandoc#filetypes#handled = [ 'pandoc', 'markdown' ]

        " Smart formatting
        let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1

        " Fold YAML header
        let g:pandoc#folding#fold_yaml = 1

        " Display output buffer on errors
        let g:pandoc#command#use_message_buffers = 1
        " }}}

        " Quote textobject config {{{
        " Integrate to matchit
        let g:textobj#quote#matchit = 1

        " Educate by default
        let g:textobj#quote#educate = 1
        " }}}

        " Autocmds for specific filetypes
        augroup writing_init
            autocmd!
            autocmd FileType pandoc,markdown,tex,text call pencil#init()
                        \ | call lexical#init()
                        \ | call litecorrect#init()
                        \ | call textobj#quote#init()
                        \ | call textobj#sentence#init()
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
    " Python {{{
        " Preview docstring in folded classes and methods
        let g:SimpyFold_docstring_preview = 1

        augroup ft_python
            autocmd!
            " Automatically sort imports on save for python files
            autocmd BufWritePre,FileWritePre *.py Isort
            " SimpyFold configuration
            autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
            autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
        augroup END
    " }}}
" }}}

" Syntax checking {{{
    " Neomake {{{
    " Logfile for debugging purposes
    let g:neomake_logfile = '/tmp/nvim.neomake.log'
    " Gutter signs definition
    let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
    let g:neomake_warning_sign = {'text': '', 'texthl': 'NeomakeWarningSign'}
    let g:neomake_message_sign = {'text': '', 'texthl': 'NeomakeMessageSign'}
    let g:neomake_info_sign = {'text': '', 'texthl': 'NeomakeInfoSign'}
    " Automatically open quickfix view if necessary
    let g:neomake_open_list = 2

    augroup neomake_autorun
        autocmd!
        " Run neomake on buffersitch and filewrite
        autocmd BufWritePost,BufWinEnter * Neomake
        " Define colors for gutter signs
        autocmd ColorScheme * highlight NeomakeErrorSign ctermfg=196 guifg=#ff0000
        autocmd ColorScheme * highlight NeomakeWarningSign ctermfg=202 guifg=#ff5f00
        autocmd ColorScheme * highlight NeomakeMessageSign ctermfg=226 guifg=#ffff00
        autocmd ColorScheme * highlight NeomakeInfoSign ctermfg=46 guifg=#00ff00
    augroup END
    " }}}
" }}}

" UI {{{
    " vim-airline {{{
    let g:airline_theme='dark'
    let g:airline_powerline_fonts = 1
    " Display buffer list in tabline on single tab
    let g:airline#extensions#tabline#enabled = 1
    " Enable NrrwRgn integration
    if exists(expand('~/.config/nvim/plugged/NrrwRgn'))
        let g:airline#extensions#nrrwrgn#enabled = 1
    endif
    " }}}

    " Solarized config {{{
    " Handle installation case to prevent error display
    if filereadable(expand('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim'))
        colorscheme solarized
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast='normal'
        let g:solarized_visibility='normal'
    else
        colorscheme desert
    endif
    set background=dark
    " }}}

    " Indent guide {{{
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
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
    nnoremap <leader>l :Unite file file_rec<CR>
    " }}}

    " EasyAlign {{{
    " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    vmap <Enter> <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
    " }}}
" }}}
" }}}
