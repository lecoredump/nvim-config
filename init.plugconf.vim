" Modeline and description {{{
" Plug in configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
" }}}

" Plugins configuration {{{
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

    " Theme configuration {{{
    " Handle solarized installed case to prevent error display
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

    " Themes switches (semantic / parenthesis matching)
    nnoremap <Leader>s :SemanticHighlightToggle<CR>
    nnoremap <Leader>m :RainbowParentheses!!<CR>
    " }}}

    " Indent guide {{{
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    " }}}

    " Folding {{{

    " FastFold
    " Update folds on buffer save
    let g:fastfold_savehook = 1
    " Minimum number of line for folding to be enabled
    let g:fastfold_minlines = 0
    " TODO : configure syntax folding

    " }}}

    " View management {{{
    set viewoptions=cursor,folds,slash,unix
    " }}}
" }}}

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

        " Python {{{
        let g:deoplete#sources#jedi#statement_length = 250
        let g:deoplete#sources#jedi#show_docstring = 1
        let g:deoplete#sources#jedi#enable_typeinfo = 1

        " }}}

        " C {{{
        let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
        let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
        " }}}

        " Doc display {{{
        let g:echodoc_enable_at_startup = 1
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

        " Markdown preview configuration
        let g:md_pdf_viewer="zathura"
        let g:md_args="--template eisvogel --listings -N"

        " Autocmds for specific filetypes
        augroup writing_init
            autocmd!
            autocmd FileType pandoc,markdown,text call lexical#init()
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
        let g:SimpylFold_docstring_preview = 1

        " Do not fold imports
        let g:SimpylFold_fold_import = 0

        " Virtualenv default directory
        let g:virtualenv_directory = '~/.pyenv'

        " Misc autocommands
        augroup ft_python
            autocmd!
            " Automatically sort imports on save for python files
            autocmd BufWritePre,FileWritePre *.py Isort
            " SimpyFold configuration
            autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
            autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
            " Specific fold for Django settings
            autocmd BufWinEnter settings.py,base.py,dev.py,prod.py setlocal foldmethod=marker
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
    let g:neomake_open_list = 0

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

" Motions {{{
    " vim-multiple-cursors {{{
    " Called once right before you start selecting multiple cursors
    function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
    endfunction

    " Called once only when the multiple selection is canceled (default <Esc>)
    function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
    endfunction
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
    vnoremap <Enter> <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nnoremap ga <Plug>(EasyAlign)
    " }}}

    " Vimwiki {{{
    let default_wiki = {}
    let default_wiki.path = '~/docs/wiki/'
    let default_wiki.html_template = '~/docs/wiki/exports/template.tpl'
    let default_wiki.auto_export = 1
    let default_wiki.auto_toc = 1
    let default_wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
    let default_wiki.auto_tags = 1
    let g:vimwiki_list = [default_wiki]
    let g:vimwiki_html_header_numbering = 2
    " }}}
" }}}
" }}}
