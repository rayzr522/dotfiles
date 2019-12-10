" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'bronson/vim-trailing-whitespace'

Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'

Plug 'vim-scripts/JavaDecompiler.vim'

" REQUIRED: Add a syntax file. YATS is the best
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
Plug 'Shougo/deoplete.nvim'
" For Denite features
Plug 'Shougo/denite.nvim'

call plug#end()

let g:deoplete#enable_at_startup = 1
" }}}

" Unite {{{
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)
" }}}

" Tabs {{{
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

" Folding {{{
set foldmethod=marker

" Bindings
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" }}}

" Auto Commands {{{

autocmd BufWritePost ~/.Xresources :silent !xrdb -merge ~/.Xresources

" }}}

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=8
endif

" set termguicolors
