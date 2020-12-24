" Modeline and description {{{
" Plugin install / loading.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
" }}}

" Plugin utilities {{{
" Installs and sets vim-plug up if not done yet
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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

" Display information regarding registers
Plug 'junegunn/vim-peekaboo'

" Temporary yank highlight, to avoid missing elements
Plug 'machakann/vim-highlightedyank'

" Denite {{{
" Unite ALL THE THINGS (fuzzy search through multiple 'sources')
Plug 'Shougo/denite.nvim',            { 'do': ':UpdateRemotePlugins' }

" Better fuzzy matcher for denite
Plug 'raghur/fruzzy',                   { 'do': { -> fruzzy#install() }}

" Handle yank history, as well as provide a source for denite
Plug 'Shougo/neoyank.vim'

" TODO look into bookmarks
" Plug 'kmnk/denite-dirmark'
" }}}

" Variations {{{
" Semantic highlights, each variable its own
" TODO adapt colors to solarized colorscheme
Plug 'jaxbot/semantic-highlight.vim',    { 'on': [ 'SemanticHighlight', 'SemanticHighlightToggle' ] }

" Colored parenthesis pair by pair
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
" }}}

" {{{ Folding & views
" Keep cursor and other view information
Plug 'zhimsel/vim-stay'

" Folding enhanced
Plug 'Konfekt/FastFold'

" Better folding for python
Plug 'tmhedberg/SimpylFold'

" Only display the "region" you're working on
Plug 'chrisbra/NrrwRgn'

" }}}
" }}}

" Versionning / Code management {{{
" File / Project browser {{{
Plug 'Shougo/defx.nvim',            { 'do': ':UpdateRemotePlugins' }

" Rice is always needed
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

" }}}

" Versioning {{{
" Gutter display
Plug 'mhinz/vim-signify'

" Git {{{
" Integration
Plug 'tpope/vim-fugitive'

" Commit browser (requires fugitive)
Plug 'junegunn/gv.vim'

" Git integration to NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Gitlab remotes handling
Plug 'shumphrey/fugitive-gitlab.vim'

if (filereadable(expand('~/.config/nvim/init.creds.vim')))
    " Github integration for fugitive
    " Requires access token in a configuration file
    Plug 'rhysd/github-complete.vim'
endif

" }}}
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
Plug 'zchee/deoplete-jedi'

Plug 'davidhalter/jedi-vim'

" Vim source for deoplete
Plug 'Shougo/neco-vim'

" Syntax files as source
Plug 'Shougo/neco-syntax'

" Perl source for neovim
Plug 'c9s/perlomni.vim'

" C / C++ sources for deoplete
Plug 'zchee/deoplete-clang'

" Filetype context extension for deoplete's sources
Plug 'Shougo/context_filetype.vim'

" Include sources for deoplete
Plug 'Shougo/neoinclude.vim'

"  Doc sources for deoplete
Plug 'Shougo/echodoc.vim'

" Dictionary source
Plug 'deoplete-plugins/deoplete-dictionary'

" Auto-complete pairs in deoplete
Plug 'Shougo/neopairs.vim'

" }}}

" Use neovim's floating window for completion display
Plug 'ncm2/float-preview.nvim'

" Completion with tab
Plug 'ervandew/supertab'

" Snippets {{{
Plug 'SirVer/ultisnips'
" }}}

" }}}

" Languages / Filetypes {{{

" Pandoc / Markdown / Latex / Txt / Writing {{{
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
" Latex / markdown preview
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Plug 'xuhdev/vim-latex-live-preview', { 'for': [ 'tex' ] }

" Distraction-free writing
Plug 'junegunn/goyo.vim',             { 'on': [ 'GoyoEnter', 'Goyo' ] }
Plug 'junegunn/limelight.vim',        { 'on': [ 'Limelight' ] }

" "Bad" words highlighting
Plug 'reedes/vim-wordy',              { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }

" Extends spell checking
Plug 'reedes/vim-lexical',            { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }

" Writing specific stuff (no more straight quotes, for example)
Plug 'kana/vim-textobj-user',         { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
Plug 'reedes/vim-textobj-quote',      { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
Plug 'reedes/vim-textobj-sentence',   { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
Plug 'reedes/vim-litecorrect',        { 'for': [ 'pandoc', 'markdown', 'tex', 'text' ] }
" }}}

" HTML / CSS {{{
" Highlights HSLA, RGB (HEX and others) and color names
Plug 'gorodinskiy/vim-coloresque',

if executable('zenity') || executable('yad')
    " Color picker, requires either yad or zenity
    Plug 'KabbAmine/vCoolor.vim'
endif

" Convert between utf8 and HTML entities
Plug 'idbrii/vim-textconv'

" Emmet emulation in vim (tag generation)
Plug 'mattn/emmet-vim'
" }}}

" Python {{{
" Sort imports using isort utility
" Requires isort installed : https://github.com/timothycrosley/isort
Plug 'brentyi/isort.vim'
" }}}

" CSV {{{
Plug 'chrisbra/csv.vim'
" }}}

" Nmap syntax {{{
Plug 'vim-scripts/Nmap-syntax-highlight'
" }}}

" Nginx configuration file syntax {{{
Plug 'vim-scripts/nginx.vim'
" }}}

" Haproxy configuration file syntax {{{
Plug 'vim-scripts/haproxy'
" }}}

" Powershell syntax {{{
Plug 'PProvost/vim-ps1'
" }}}

" Cisco
Plug 'momota/cisco.vim'
" }}}

" Syntax checking, linting and formatting {{{
" Programming languages
Plug 'neomake/neomake'

" Formatting
Plug 'sbdchd/neoformat'

" Writing
let g:grammalecte_cli_py=exepath('grammalecte-cli')
if exists("g:grammalecte_cli_py")
    Plug 'dpelle/vim-Grammalecte'
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

" Handle case switching, advanced substitutions and abbreviations
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
Plug 'mbbill/undotree'

" Text alignment utility
Plug 'junegunn/vim-easy-align'

if executable('task')
    " Taskwarrior interface
    Plug 'blindFS/vim-taskwarrior',       { 'on': 'TW' }
endif


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
