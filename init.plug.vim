" Modeline and description {{{
" Default plugin set and associated configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
scriptencoding utf-8
" }}}

" Utilities {{{
    " Installs and sets vim-plug up if not done yet
    if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
        execute '!mkdir -p ~/.config/nvim/autoload/'
        execute '!mkdir -p ~/.config/nvim/plugged'
        execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    endif

    " Handle remote plugins
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction

" }}}

" Plugin loading {{{
call plug#begin()

" Interface {{{

    " Vim airline {{{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " }}}

    " Colorschemes
    Plug 'altercation/vim-colors-solarized'

    " Indent level display
    Plug 'nathanaelkane/vim-indent-guides'

    " Semantic highlights, each variable its own
    " TODO: adapt colors to solarized colorscheme
    Plug 'jaxbot/semantic-highlight.vim'
" }}}

" Utilities {{{
    " Versionning / Code management {{{
        " Git {{{
        " Integration
        Plug 'tpope/vim-fugitive'

        if (filereadable(expand('~/.config/nvim/init.creds.vim')))
            " Github integration for fugitive
            " Requires access token in a configuration file
            " Requires curl installed on the machine
            Plug 'jaxbot/github-issues.vim'
        endif

        " Commit browser
        Plug 'int3/vim-extradite'

        " Gitlab remotes handling
        Plug 'shumphrey/fugitive-gitlab.vim'

        " Diff with current HEAD in a gutter
        Plug 'airblade/vim-gitgutter'
        " }}}

        if executable('patch')
            " Single/multi-patch or diff reviews
            " Requires patch command installed
            Plug 'junkblocker/patchreview-vim'
        endif
    " }}}

    " Tags handling {{{
    if executable('ctags')
        Plug 'majutsushi/tagbar'
    endif
    " }}}

    " Completion {{{
        " Asynchronous completion for neovim {{{
        Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
        " }}}

        " Misc completions {{{
        " Automatic pairing for '"()[]{}
        Plug 'jiangmiao/auto-pairs'
        " }}}
    " }}}

    " Languages / Filetypes {{{

        " Pandoc / Markdown / Latex / Txt {{{
        Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc' , 'markdown' ] }
        Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }

        " Accentuated characters for those not in your keymap
        " TODO: integrate as in http://junegunn.kr/2014/06/emoji-completion-in-vim/
        Plug 'airblade/vim-accent', { 'for': [ 'pandoc', 'markdown', 'latex', 'text' ] }
        " }}}

        " HTML / CSS {{{
        " Highlights HSLA, RGB (HEX and others) and color names
        Plug 'gorodinskiy/vim-coloresque', { 'for': [ 'html', 'djangohtml', 'markdown' ] }

        " Emoji completion, because we can
        Plug 'junegunn/vim-emoji', { 'for': [ 'html', 'djangohtml', 'markdown' ] }

        if executable('zenity') || executable('yad')
            " Color picker, requires either yad or zenity
            Plug 'KabbAmine/vCoolor.vim', { 'for': [ 'html', 'djangohtml', 'markdown' ] }
        endif
        " }}}

        " Python {{{
        " Sort imports using isort utility
        " Requires isort installed : https://github.com/timothycrosley/isort
        if executable('isort')
            Plug 'fisadev/vim-isort', { 'for': [ 'python' ] }
        endif

        " Python source for deoplete
        Plug 'zchee/deoplete-jedi', { 'for': [ 'python' ] }
        " }}}
    " }}}

    " Syntax checking {{{
        Plug 'neomake/neomake'
    " }}}

    " Tim Pope goodness {{{
        " Handle surrounging chars ('"()[]{}) in an easier fashion
        Plug 'tpope/vim-surround'

        " Handy bracket mappings
        Plug 'tpope/vim-unimpaired'

        " Commentary handling
        Plug 'tpope/vim-commentary'

        " Mappings for *ML and templating languages (php, django, jsp...)
        Plug 'tpope/vim-ragtag', { 'for': [ 'xml', 'html', 'djangohtml' ] }

        " Handle case swotching, advanced substitutions and abbreviations
        Plug 'tpope/vim-abolish'

        " Repeat ALL THE THINGS (including some Tpope goodness of course)
        Plug 'tpope/vim-repeat'
    " }}}

    " Motions {{{
        " Multiple cursors
        Plug 'kristijanhusak/vim-multiple-cursors'

        " Adds new textobjects : pair, quote, separator, argument
        Plug 'wellle/targets.vim'
    " }}}

    " Other {{{
        " Undo tree browser
        Plug 'mbbill/undotree'

        " Text alignment utility
        Plug 'godlygeek/tabular'

        " Unite ALL THE THINGS
        Plug 'Shougo/unite.vim'

        " Substitution preview
        Plug 'osyo-manga/vim-over'

        " ICONS EVERYWHERE, must be loaded last for interaction with other
        " plugins. Patched fonts : https://github.com/ryanoasis/nerd-fonts
        " TODO: check valid font before loading
        Plug 'ryanoasis/vim-devicons'
    " }}}

call plug#end()
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
" Interface {{{
    " vim-airline {{{
    let g:airline_theme='dark'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
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
