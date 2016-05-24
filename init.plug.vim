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

"" Interface {
""" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

""" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Colorschemes
Plug 'altercation/vim-colors-solarized'

"" }

"" Completion {
""" Asynchronous completion for neovim
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

"" }

"" Syntax {
""" Pandoc {
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc' , 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }
""" }

"" }

"" Utilities {
""" Versionning {
""" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'int3/vim-extradite'
""" }
"" }
call plug#end()
" }

" Plugin configuration {
" }
