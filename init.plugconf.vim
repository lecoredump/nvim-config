" Modeline and description {{{
" Plugin configuration.
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

" Disable indent guides for terminal buffer
autocmd BufWinEnter,WinEnter term://* :IndentGuidesDisable<CR>
" }}}

" Folding {{{

" FastFold {{{
" Update folds on buffer save
let g:fastfold_savehook = 1
" Minimum number of line for folding to be enabled
let g:fastfold_minlines = 0
" TODO : configure syntax folding

" }}}

" Which command opens a fold

" Enable folding for following filetypes
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:ruby_fold = 1
let g:sh_fold_enabled= 7
let g:php_folding = 1
let g:perl_fold = 1

" }}}

" View management {{{
set viewoptions=cursor,curdir,options,folds,slash,unix
" }}}
" }}}

" Versionning / Project Management {{{
" defx
if filereadable(expand('~/.config/nvim/plugged/defx.nvim/plugin/defx.vim'))
    if filereadable(expand('~/.config/nvim/init.defx.vim'))
        source ~/.config/nvim/init.defx.vim
    endif
endif
"

" Versionning gutter display {{{
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'
let g:signify_disable_by_default = 0

" Display deleted line count (up to 99)
let g:signify_sign_show_count = 1
" }}}
" }}}

" Completion {{{
" deoplete {{{
" Default configuration :
" - full fuzzy matching
" - don't search in String, Constants or Comments
" - 4 processes and no immediate refresh
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length'])
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String', 'Constant'])
call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'converter_auto_delimiter', 'converter_remove_overlap', 'converter_truncate_abbr', 'converter_truncate_kind', 'converter_truncate_info', 'converter_truncate_menu'])
call deoplete#custom#option('num_processes', 4)
call deoplete#custom#option('auto_complete_delay', 50)
call deoplete#custom#option('auto_complete_delay', 50)
call deoplete#custom#option('refresh_always', v:false)
autocmd CompleteDone * silent! pclose!

" Python {{{
let g:deoplete#sources#jedi#statement_length = 250
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_typeinfo = 1

" Jedi configuration
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_splits_not_buffers = 'winwidth'
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1


" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>_K'
let g:jedi#auto_close_doc = 1
" }}}

" C {{{
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
" }}}

" Neopair completion
let g:neopairs#enable = 1

" Doc display
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'popup'
" TODO : check context_filetype source default list
" }}}

" Preview window configuration (float-preview.nvim)
function! DisableExtras()
    call nvim_win_set_option(g:float_preview#win, 'number', v:false)
    call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
    call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
endfunction

autocmd User FloatPreviewWinOpen call DisableExtras()



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
nnoremap <F2> :Goyo<CR>

" }}}

" vim-pandoc {{{
" TODO : finish pandoc config
" Support for markdown
let g:pandoc#filetypes#handled = [ 'pandoc', 'markdown' ]
let g:pandoc#filetypes#pandoc_markdown = 0
" Display output buffer on errors
let g:pandoc#command#use_message_buffers = 1

" Folding {{{
let g:pandoc#folding#mode = 'relative'
let g:pandoc#folding#fold_yaml = 1
" }}}

" }}}

" Quote textobject config {{{
" Integrate to matchit
let g:textobj#quote#matchit = 1

" Educate by default
let g:textobj#quote#educate = 1
" }}}

" " Markdown preview configuration
" TODO : update configuration to use browser in Docker container
" let g:md_pdf_viewer="zathura"
" let g:md_args="--template eisvogel --listings -N"

" Autocmds for specific filetypes
augroup writing_init
    autocmd!
    autocmd FileType pandoc,markdown,text call textobj#quote#init()
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

" Include trailing blank lines in folds
let g:SimpylFold_fold_blank = 1

" Do not fold imports
let g:SimpylFold_fold_import = 0

" }}}
" }}}

" Syntax checking {{{
" Neomake {{{
" Logfile for debugging purposes
" let g:neomake_logfile = '/tmp/nvim.neomake.log'
" Gutter signs definition
let g:neomake_error_sign = {'text': '', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': '', 'texthl': 'NeomakeInfoSign'}

" Automatically open quickfix view if necessary
let g:neomake_open_list = 0

function! MyOnBattery()
    if has('macunix')
        return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
    elseif has('unix')
        return readfile('/sys/class/power_supply/AC/online') == ['0']
    endif
    return 0
endfunction

if MyOnBattery()
    call neomake#configure#automake('w')
else
    call neomake#configure#automake('nrwi', 500)
endif

augroup neomake_autorun
    autocmd!
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

" Denite {{{
if filereadable(expand('~/.config/nvim/plugged/denite.nvim/plugin/denite.vim'))
    if filereadable(expand('~/.config/nvim/init.denite.vim'))
        source ~/.config/nvim/init.denite.vim
    endif
endif
" }}}

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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
