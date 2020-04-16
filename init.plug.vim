" Modeline and description {{{
" Plugin install / loading.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
scriptencoding utf-8
" }}}

" Plugin utilities {{{
    " Installs and sets vim-plug up if not done yet
    if !filereadable(expand('~/.config/nvim/autoload/plug.vim')) && executable('curl')
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
call plug#begin('~/.config/nvim/plugged')

" UI {{{

    " Ruler / statusline {{{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " }}}

    " Colorschemes
    Plug 'altercation/vim-colors-solarized'

    " Indent level display
    Plug 'nathanaelkane/vim-indent-guides'

    " Folding enhanced
    Plug 'Konfekt/FastFold'

    " Keep cursor and other view information
    Plug 'zhimsel/vim-stay'

    " Display information regarding registers
    Plug 'junegunn/vim-peekaboo'

    " Denite {{{
    " Unite ALL THE THINGS (fuzzy search through multiple 'sources')
    Plug 'Shougo/denite.nvim'
    " }}}

    " Variations {{{
    " Semantic highlights, each variable its own
    " TODO adapt colors to solarized colorscheme
    Plug 'jaxbot/semantic-highlight.vim',    { 'on': [ 'SemanticHighlight', 'SemanticHighlightToggle' ] }

    " Colored parenthesis pair by pair
    Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
    " }}}
" }}}

" Versionning / Code management {{{
    " File / Project browser
    Plug 'scrooloose/nerdtree',              { 'on': [ 'NERDTree', 'NERDTreeToggle' ] }

    " Git {{{
    " Integration
    Plug 'tpope/vim-fugitive'

    " Commit browser (requires fugitive)
    Plug 'junegunn/gv.vim'

    " Git integration to NERDTree
    Plug 'Xuyuanp/nerdtree-git-plugin',      { 'on': [ 'NERDTree', 'NERDTreeToggle' ] }

    " Diff with current HEAD in a gutter
    Plug 'airblade/vim-gitgutter'

    " Gitlab remotes handling
    Plug 'shumphrey/fugitive-gitlab.vim'

    if (filereadable(expand('~/.config/nvim/init.creds.vim')))
        " Github integration for fugitive
        " Requires access token in a configuration file
        Plug 'rhysd/github-complete.vim',    { 'for': [ 'gitcommit', 'markdown' ] }
    endif

    " }}}

    if executable('patch')
        " Single/multi-patch or diff reviews
        " Requires patch command installed
        Plug 'junkblocker/patchreview-vim'
    endif
" }}}

" Tags {{{
    if executable('ctags')
        " Coming too close to an IDE maybe ?
        Plug 'majutsushi/tagbar'
        Plug 'ludovicchabant/vim-gutentags'
    endif
" }}}

" Completion {{{
    " Asynchronous completion for neovim {{{
    if has('nvim')
        Plug 'Shougo/deoplete.nvim',            { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    let g:deoplete#enable_at_startup = 1


    " Ctags source for deoplete
    Plug 'deoplete-plugins/deoplete-tag'

    " Python source for deoplete
    Plug 'zchee/deoplete-jedi',             { 'for': [ 'python', 'htmldjango' ] }

    " Vim source for deoplete
    Plug 'Shougo/neco-vim',                 { 'for': [ 'vim' ] }

    " Perl source for neovim
    Plug 'c9s/perlomni.vim',                { 'for': [ 'perl' ] }

    " C / C++ sources for deoplete
    Plug 'zchee/deoplete-clang',            { 'for': [ 'c', 'cpp', 'objc', 'objcpp' ] }

    " Filetype context extension for deoplete's sources
    Plug 'Shougo/context_filetype.vim'

    " Include sources for deoplete
    Plug 'Shougo/neoinclude.vim'

    "  Doc sources for deoplete
    Plug 'Shougo/echodoc.vim'

    " Auto-complete pairs in deoplete
    Plug 'Shougo/neopairs.vim'

    " }}}

    " Completion with tab
    Plug 'ervandew/supertab'

    " Misc completions {{{
    " Automatic pairing for '"()[]{}
    Plug 'jiangmiao/auto-pairs'
    " }}}
" }}}

" Languages / Filetypes {{{

    " Pandoc / Markdown / Latex / Txt / Writing {{{
        Plug 'vim-pandoc/vim-pandoc',         { 'for': [ 'pandoc', 'markdown' ] }
        Plug 'vim-pandoc/vim-pandoc-syntax',  { 'for': [ 'pandoc', 'markdown' ] }
        Plug 'lervag/vimtex',                 { 'for': [ 'tex' ] }
        Plug 'xuhdev/vim-latex-live-preview', { 'for': [ 'tex' ] }

        " Accentuated characters for those not in your keymap
        " TODO integrate as in http://junegunn.kr/2014/06/emoji-completion-in-vim/
        Plug 'airblade/vim-accent',           { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }

        " Distraction-free writing
        Plug 'junegunn/goyo.vim',             { 'on': [ 'GoyoEnter', 'Goyo' ] }
        Plug 'junegunn/limelight.vim',        { 'on': [ 'Limelight' ] }

        " "Bad" words highlighting
        Plug 'reedes/vim-wordy',              { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }

        " Extends spell checking
        Plug 'reedes/vim-lexical',            { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }

        " Markdown preview
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

        " Writing specific stuff (no more straight quotes, for example)
        Plug 'kana/vim-textobj-user',         { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
        Plug 'reedes/vim-textobj-quote',      { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
        Plug 'reedes/vim-textobj-sentence',   { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
        Plug 'reedes/vim-litecorrect',        { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
    " }}}

    " HTML / CSS {{{
        " Highlights HSLA, RGB (HEX and others) and color names
        Plug 'gorodinskiy/vim-coloresque',

        " Emoji completion, because we can
        Plug 'junegunn/vim-emoji',            { 'for': [ 'html', 'htmldjango', 'markdown', 'pandoc'] }

        if executable('zenity') || executable('yad')
            " Color picker, requires either yad or zenity
            Plug 'KabbAmine/vCoolor.vim',     { 'for': [ 'html', 'htmldjango', 'markdown', 'pandoc', 'css' ] }
        endif

        " Convert between utf8 and HTML entities
        Plug 'idbrii/vim-textconv',           { 'for': [ 'html', 'htmldjango', 'markdown', 'pandoc' ] }

        " Emmet emulation in vim (tag generation)
        Plug 'mattn/emmet-vim',               { 'for': [ 'html', 'htmldjango', 'markdown', 'pandoc' ] }
    " }}}

    " Python {{{
        " Sort imports using isort utility
        " Requires isort installed : https://github.com/timothycrosley/isort
        if executable('isort')
            Plug 'fisadev/vim-isort',         { 'for': [ 'python', 'htmldjango' ] }
        endif

        " Virtual environment handling
        Plug 'jmcantrell/vim-virtualenv',     { 'for': [ 'python', 'htmldjango' ] }

        " Better folding for python
        Plug 'tmhedberg/SimpylFold',          { 'for': [ 'python' ] }

        " Proper pep8 indentation scheme
        Plug 'vim-scripts/indentpython.vim',  { 'for': [ 'python' ] }
    " }}}

    " CSV {{{
        Plug 'chrisbra/csv.vim',              { 'for': [ 'csv' ] }
    " }}}

    " Nmap syntax {{{
        Plug 'vim-scripts/Nmap-syntax-highlight',          { 'for': [ 'nmap' ] }
    " }}}

    " Nginx configuration file syntax {{{
        Plug 'vim-scripts/nginx.vim',                      { 'for': [ 'nginx' ] }
    " }}}

    " Haproxy configuration file syntax {{{
        Plug 'vim-scripts/haproxy',                    { 'for': [ 'haproxy' ] }
    " }}}

    " Powershell syntax {{{
        Plug 'PProvost/vim-ps1',                           { 'for': [ 'ps1' ] }
    " }}}

    " Solidity {{{
        Plug 'tomlion/vim-solidity'
    " }}}

    " Cisco
        Plug 'CyCoreSystems/vim-cisco-ios'
    " }}}

" Syntax checking {{{
    " Programming languages
    Plug 'neomake/neomake'

    " Writing
    if exists("g:grammalecte_cli_py")
        Plug 'dpelle/vim-Grammalecte',                     { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
    endif
" }}}

" Tim Pope goodness {{{
    " Handle surrounging chars ('"()[]{}) in an easier fashion
    Plug 'tpope/vim-surround'

    " Handy bracket mappings
    Plug 'tpope/vim-unimpaired'

    " Commentary handling
    Plug 'tpope/vim-commentary'

    " Mappings for *ML and templating languages (php, django, jsp...)
    Plug 'tpope/vim-ragtag',                  { 'for': [ 'xml', 'html', 'htmldjango' ] }

    " Handle case swotching, advanced substitutions and abbreviations
    Plug 'tpope/vim-abolish'

    " Repeat ALL THE THINGS (including some Tpope goodness of course)
    Plug 'tpope/vim-repeat'
" }}}

" Motions {{{
    " Multiple cursors
    Plug 'terryma/vim-multiple-cursors'

    " Adds new textobjects : pair, quote, separator, argument
    Plug 'wellle/targets.vim'

    " Adds target 'after' as a textobject
    Plug 'junegunn/vim-after-object'
" }}}

" Search {{{
    " Augmented '/' (requires vim-pseudocl)
    Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
" }}}

" Other {{{

    " Undo tree browser
    Plug 'mbbill/undotree',                  { 'on': 'UndotreeToggle' }

    " Text alignment utility
    Plug 'junegunn/vim-easy-align',          { 'on': [ '<Plug>EasyAlign', 'EasyAlign' ] }

    " Only display the "region" you're working on
    Plug 'chrisbra/NrrwRgn'

    if executable('task')
        " Taskwarrior interface
        Plug 'blindFS/vim-taskwarrior',       { 'on': 'TW' }
    endif

    " Personal wiki and notes, plus a whole lot of stuff
    Plug 'vimwiki/vimwiki'

    " ICONS EVERYWHERE, must be loaded last for interaction with other
    " plugins. Patched fonts : https://github.com/ryanoasis/nerd-fonts
    " TODO check valid font before loading
    Plug 'ryanoasis/vim-devicons'
" }}}

call plug#end()

" }}}

" 'Plugins' and their configuration if available {{{
if filereadable(expand('~/.config/nvim/init.plugconf.vim'))
    source ~/.config/nvim/init.plugconf.vim
endif
" }}}
