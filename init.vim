" Modeline and description {{{
" Frenchbeard's neovim config
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
" }}}

" 'Before' config {{{
if filereadable(expand('~/.config/nvim/init.before.vim'))
    source ~/.config/nvim/init.before.vim
endif
" }}}

" Default configuration {{{
" Environment {{{
" Python elements {{{
" Paths, defaults to system python
if filereadable(expand('~/.pyenv/neovim3/bin/python3'))
    let g:python3_host_prog = expand('~/.pyenv/neovim3/bin/python3')
else
    let g:python3_host_prog = exepath('python3')
endif

if filereadable(expand('~/.pyenv/neovim2/bin/python2'))
    let g:python_host_prog = expand('~/.pyenv/neovim2/bin/python2')
else
    let g:python_host_prog = exepath('python2')
endif
" }}}

scriptencoding utf-8
" }}}

" UI {{{
set cursorline
highlight clear SignColumn
highlight clear LineNr

" Allow virtual edits in VBlock mode
set virtualedit=block

" Ruler configuration {{{
if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
    set noshowmode
endif
" }}}

" Statusline configuration {{{
if has('statusline')
    set laststatus=2
    " Filename
    set statusline=%<%f
    " Options
    set statusline+=\ %w%h%m%r
    if filereadable(expand('~/.config/nvim/plugged/vim-fugitive'))
        " Fugitive integration (Git)
        set statusline+=%{fugitive#statusline()}
    endif
    " Filetype
    set statusline+=\ [%{&ff}/%Y]
    " Current directory
    set statusline+=\ [%{getcwd()}]
    " File navigation
    set statusline+=\ %=%-14.(%l,%c%V%)\ %p%%
endif
" }}}

" Tabs, indents, folds and line display {{{
" General indent behaviour
set smarttab
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
set autoindent

" Buffer limits
set textwidth=79
set whichwrap=b,s,h,l,<,>,[,]
set nowrap
set scroll=15
set scrolloff=3
set sidescroll=10
set sidescrolloff=5

set showmatch
set foldenable
set list
set listchars=tab:›\ ,trail:•,extends:#,precedes:>,nbsp:✯

set backspace=indent,eol,start
set linespace=0
set winminheight=0
set wildmenu
set wildmode=list:longest,full

" Relative line numbers, except for current
set relativenumber number
" }}}


" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" Split behaviour {{{
set splitbelow
set splitright
" }}}

" Default mappings (all filetypes) {{{
" Mainly "general" motions
" Leader
let mapleader = "\<SPACE>"

" Why 2 keystrokes for command mode ? {{{
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
" }}}

" Simpler return to normal mode from INSERT, COMMAND MODE and TERMINAL {{{
inoremap jk <Esc>
tnoremap jk <C-\><C-n>
cnoremap jk <Esc>
vnoremap jk <Esc>
" }}}

" Less cumbersome movement between "splits" {{{
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }}}

" DO NOT USE ARROW KEYS !
" I MEAN IT
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Indent whole file
nnoremap == ggVG=

" Move visual selection arround, while updating indentation
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Indent with tab in visual mode, because we can
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Toggle fold
nnoremap <leader><space> za
" Toggle paste mode
nnoremap <leader>p :setlocal paste!<CR>

" }}}

" Functions {{{
" Strips trailing whitespaces based on filetype
function! StripTrailingWhitespaces()
    let l:curPos = winsaveview()
    if exists('g:specific_strip_whitespace_filetypes')
        if index(g:specific_strip_whitespace_filetypes, &filetype) != -1
            %sm/\(.*[^) ]\{1,}\)\s\+$/\1/e
            %sm/)\+\s\{3,}$/)  /e
            %sm/^\s\+$//e
        else
            %sm/\s\+$//e
        endif
    endif
    call winrestview(l:curPos)
endfunction
" }}}

" Misc Autocommands {{{
augroup init_vim
    autocmd!
    " Automatically switch CWD to current files
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    " Automatically remove trailing whitespaces before writing buffer
    autocmd BufWritePre * :call StripTrailingWhitespaces()

    " Automatically resize following terminal
    autocmd VimResized * :wincmd =

    " Leave paste mode on InsertLeave
    autocmd InsertLeave * silent! set nopaste
augroup END
" }}}

" }}}

" Plugins management {{{
if filereadable(expand('~/.config/nvim/init.plug.vim'))
    source ~/.config/nvim/init.plug.vim
endif
" }}}

" Misc filetypes {{{
" Not complex enough to require a plugin
if filereadable(expand('~/.config/nvim/init.filetypes.vim'))
    source ~/.config/nvim/init.filetypes.vim
endif
"}}}

" Credentials config {{{
if filereadable(expand('~/.config/nvim/init.creds.vim'))
    source ~/.config/nvim/init.creds.vim
endif
" }}}

" 'After' config {{{
if filereadable(expand('~/.config/nvim/init.vim.after'))
    source ~/.config/nvim/init.vim.after
endif
" }}}
