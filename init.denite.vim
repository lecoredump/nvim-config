" Modeline and description {{{ Denite specific configuration cf.
" https://github.com/Shougo/denite.nvim vim: set sw=4 ts=4 sts=4 tw=78 ft=vim
" foldmarker={{{,}}} foldmethod=marker :
" TODO Add mappings for specific denites
" }}}

" Third-party elements {{{
" Fruzzy configuration
let g:fruzzy#usenative   = 1
let g:fruzzy#sortonempty = 1

" Neoyank history configuration
let g:neoyank#file   = expand('~/.config/nvim/.yank_hist')
let g:neoyank#limit  = 50
let g:neoyank#length = 10000
" Explicitly save only default yank buffer
let g:neoyank#save_registers = [ '"' ]

" Handle 'sensitive' file types and prevent accidentaly storing their content
" TODO inventory required file types
autocmd BufWinEnter \(*.asc\|*.gpg\) let g:neoyank#disable_write = 1
autocmd BufWinLeave \(*.asc\|*.gpg\) let g:neoyank#disable_write = 0
" }}}

" Shared configuration {{{
call denite#custom#option('_', 'statusline', v:false)
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
" }}

" Mappings {{{

" For Normal mode {{{
nnoremap <leader>l :DeniteBufferDir file/rec<CR>
nnoremap <leader>gl :DeniteProjectDir file/rec<CR>
" }}}

" For denite buffer {{{
autocmd FileType denite call s:denite_settings()

function! s:denite_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction
" }}}

" Disable other functionalities in Denite filter buffer {{{
autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings() abort
    " Disable deoplet auto-completion when filtering results
    call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
" }}}

