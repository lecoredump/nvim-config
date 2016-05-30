" Modeline and description {
" Frenchbeard's neovim config
" vim: set sw=4 ts=4 sts=4 tw=78 foldmarker={,} foldmethod=marker :
" }

" 'Before' config if available {
if filereadable(expand('~/.config/nvim/init.before.vim'))
    source ~/.config/nvim/init.before.vim
endif
" }

" Default configuration {
    " Environment {
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python3'
    set encoding=utf-8
    scriptencoding utf-8
    " }

    " 'Plugins' config if available {
    if filereadable(expand('~/.config/nvim/init.plug.vim'))
        source ~/.config/nvim/init.plug.vim
    endif
    " }

    " Interface {
    set background=dark

    set tabpagemax=15
    set cursorline
    highlight clear SignColumn
    highlight clear LineNr

        " Ruler configuration {
        if has('cmdline_info')
            set ruler
            set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
            set showcmd
        endif
        " }

        " Statusline configuration {
        if has('statusline')
            set laststatus=2
            " Filename
            set statusline=%<%f\
            " Options
            set statusline+=%w%h%m%r
            " Fugitive integration (Git)
            set statusline+=%{fugitive#statusline()}
            " Filetype
            set statusline+=\ [%{&ff}/%Y]
            " Current directory
            set statusline+=\ [%{getcwd()}]
            " File navigation
            set statusline+=%=%-14.(%l,%c%V%)\ %p%%
        endif
        " }


        """ Tabs, indents, folds and line display {
        set smarttab
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        set textwidth=79
        set autoindent

        set whichwrap=b,s,h,l,<,>,[,]
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
        " }
    " }

    " Search {
    set incsearch
    set hlsearch
    set ignorecase
    set smartcase
    " }

    " Default mappings (all filetypes) {
    " Simpler return to normal mode
    inoremap jj <Esc>
    inoremap kk <Esc>
    vnoremap jk <Esc>

    " For when you forget to sudo.. Really write the file.
    cmap w!! w !sudo tee % >/dev/null
    " }

    " Misc Autocommands {
    augroup misc
        " Automatically switch CWD to current files
        autocmd BufEnter *.* if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

        " Automatically remove trailing whitespaces before writing buffer
        autocmd BufWritePre *.* :%s/\s\+$//e
    augroup END
    " }

" }

" Credentials config if available {
if filereadable(expand('~/.config/nvim/init.creds.vim'))
    source ~/.config/nvim/init.creds.vim
endif
" }

" 'After' config if available {
if filereadable(expand('~/.config/nvim/init.vim.after'))
    source ~/.config/nvim/init.vim.after
endif
" }
