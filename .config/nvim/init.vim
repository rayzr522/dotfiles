" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

Plug 'Shougo/denite.nvim'
Plug 'vim-scripts/JavaDecompiler.vim'

" Completion engine
Plug 'Shougo/deoplete.nvim'
" Linting engine
Plug 'w0rp/ale'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'bronson/vim-trailing-whitespace'

call plug#end()

let g:deoplete#enable_at_startup = 1
" }}}

" Tabs {{{
set expandtab
set tabstop=4
set shiftwidth=4
" }}}

" Binds {{{

map <tab> <ESC>:bnext<CR>
map <s-tab> <ESC>:bprev<CR>

map <c-w> <ESC>:bdel<CR>

map <c-s> <ESC>:w<CR>

" }}}

" Auto Commands {{{

autocmd BufWritePost ~/.Xresources :silent !xrdb -merge ~/.Xresources

" }}}

" Visual {{{
" Doesn't work (well) with urxvt
" set termguicolors

set number
highlight LineNr ctermfg=grey

highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=green
highlight GitGutterDelete ctermfg=red

let g:gitgutter_async = 0
set updatetime=100

" }}}

" Quality of Life {{{

" Folding
set foldmethod=marker

" Don't be stupid
set hidden
set nocompatible

" Better searching
set ignorecase
set smartcase

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}

" Airline {{{

let g:airline_theme = 'biogoo'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 2

let g:airline_powerline_fonts = 1

" }}}
