" Modeline and description {
" Default plugin set and associated configuration.
" Uses https://github.com/junegunn/vim-plug for plugin management.
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={,} foldmethod=marker :
" }

" Utility functions {

"" Handle remote plugins
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" }

" Plugin loading {
call plug#begin()

" Interface {

    " Vim airline {
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " }

    " Colorschemes
    Plug 'altercation/vim-colors-solarized'

    " Indent level display
    Plug 'nathanaelkane/vim-indent-guides'

    " Syntax {
        " Pandoc {
        Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc' , 'markdown' ] }
        Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
        " }
    " }

    " Tagbar
    if executable('ctags')
        Plug 'majutsushi/tagbar'
    endif

" }

" Utilities {
    " Versionning {
        " Git {
        " Integration
        Plug 'tpope/vim-fugitive'

        " Commit browser
        Plug 'int3/vim-extradite'

        " Gitlab remotes handling
        Plug 'shumphrey/fugitive-gitlab.vim'

        " Diff in a gutter
        Plug 'airblade/vim-gitgutter'
        " }
    " }

    " Completion {
        " Asynchronous completion for neovim {
        Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
        " }

        " Misc completions {
        " Automatic pairing for '"()[]{}
        Plug 'jiangmiao/auto-pairs'
        " }
    " }

    " Syntax checking {
    Plug 'neomake/neomake'
    " }

    " Tim Pope goodness {
    " Handle surrounging chars ('"()[]{}) in an easier fashion
    Plug 'tpope/vim-surround'

    " Handy bracket mappings
    Plug 'tpope/vim-unimpaired'

    " Mappings for *ML and templating languages (php, django, jsp...)
    Plug 'tpope/vim-ragtag', { 'for': [ 'xml', 'html', 'djangohtml' ] }
    " }

    " Misc {
    " Undo tree browser
    Plug 'mbbill/undotree'

    " Text alignment utility
    Plug 'godlygeek/tabular'

    " Unite ALL THE THINGS
    Plug 'Shougo/unite.vim'

    " Multiple cursors
    Plug 'kristijanhusak/vim-multiple-cursors'

    " Substitution overview
    Plug 'osyo-manga/vim-over'

    " Pretty icons (needs patched font), must be loaded last
    Plug 'ryanoasis/vim-devicons'
    " }
" }

call plug#end()
" }

" Plugins configuration {
" Interface {
    " vim-airline {
    let g:airline_theme='dark'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    " }

    " Solarized config {
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    colorscheme solarized
    " }

    " Indent guide {
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
    " }
" }

" Utilities {
    " Completion {
        " Deoplete {
        let g:deoplete#enable_at_startup = 1

        " Tab completion (Needs completion to handle actual tab input)
        inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

        " }
    " }

    " Syntax checking {
        " Neomake {
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
        au! BufWritePost * Neomake
        " }
    " }
    " Misc {
        " Undo tree tab {
        if has('persistent_undo')
            set undodir=~/.config/nvim/.undo/
            set undofile
        endif
        let g:undotree_WindowLayout = 4
        let g:undotree_SetFocusWhenToggle = 1
        nnoremap <leader>u :UndotreeToggle<CR>
        " }
        " Unite {
        nnoremap <C-l> :Unite file file_rec<CR>
        " }
    " }
" }

" }
