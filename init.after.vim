" Modeline and description {{{
" Frenchbeard's neovim config final loading
" vim: set sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={{{,}}} foldmethod=marker :
" }}}

" Coloresque everywhere {{{
    syn include syntax/css/vim-coloresque.vim
" }}}

" Let's put a smile on that face
if filereadable(expand('~/.config/nvim/smile.vim'))
    source ~/.config/nvim/smile.vim
endif

" Modeline handling {{{
set modeline
set modelines=5
" }}}
