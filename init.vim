" Modeline and description {{{
" Frenchbeard's neovim config
" vim: set sw=4 ts=4 sts=4 tw=78 foldmarker={{{,}}} foldmethod=marker :
" }}}

" 'Before' config if available {{{
if filereadable(expand('~/.config/nvim/init.before.vim'))
    source ~/.config/nvim/init.before.vim
endif
" }}}

" Default configuration {{{
    " Environment {{{
    let g:python_host_prog = exepath('python2')
    let g:python3_host_prog = exepath('python3')
    scriptencoding utf-8
    " }}}

    " Interface {{{
    set tabpagemax=15
    set cursorline
    highlight clear SignColumn
    highlight clear LineNr

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
        set smarttab
        set tabstop=4
        set shiftwidth=4
        set shiftround
        set softtabstop=4
        set expandtab
        set textwidth=79
        set autoindent

        set whichwrap=b,s,h,l,<,>,[,]
        set nowrap
        set scrolljump=5
        set scrolloff=3
        set showmatch
        set foldenable
        set list
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

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

    " Default mappings (all filetypes) {{{
    " Leader
    let g:mapleader = ','
    " Simpler return to normal mode from INSERT and TERMINAL
    inoremap jj <Esc>
    inoremap kk <Esc>
    tnoremap jj <Esc>
    tnoremap kk <Esc>

    " Toggle current fold with space in normal mode
    nnoremap <space> za

    " For when you forget to sudo.. Really write the file.
    cnoremap w!! w !sudo tee % >/dev/null
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
    augroup misc
        autocmd!
        " Automatically switch CWD to current files
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " Automatically remove trailing whitespaces before writing buffer
        autocmd BufWritePre * call StripTrailingWhitespaces()
    augroup END
    " }}}

" }}}

" 'Plugins' and their configuration if available {{{
if filereadable(expand('~/.config/nvim/init.plug.vim'))
    source ~/.config/nvim/init.plug.vim
endif
" }}}

" Credentials config if available {{{
if filereadable(expand('~/.config/nvim/init.creds.vim'))
    source ~/.config/nvim/init.creds.vim
endif
" }}}

" 'After' config if available {{{
if filereadable(expand('~/.config/nvim/init.vim.after'))
    source ~/.config/nvim/init.vim.after
endif
" }}}
