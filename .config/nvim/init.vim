" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

Plug 'Shougo/denite.nvim'
Plug 'vim-scripts/JavaDecompiler.vim'

" Completion engine
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
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

nmap <tab> <ESC>:bnext<CR>
nmap <s-tab> <ESC>:bprev<CR>

map <c-x><c-x> <ESC>:bdel<CR>
map <c-x><c-s> <ESC>:w<CR>

nmap <c-x><c-n> <ESC>:ALENextWrap<CR>
nmap <c-x><c-f> <ESC>:ALEFix<CR>
nmap <c-x><c-g> <ESC>:ALEGoToDefinition<CR>
nmap <c-x><c-i> <ESC>:ALEHover<CR>

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

highlight Pmenu ctermbg=238 ctermfg=white
highlight PmenuSel ctermbg=240 ctermfg=white

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

" ALE {{{

let g:ale_open_list = 0
let g:ale_lint_delay = 50
let g:ale_list_window_size = 50

let g:ale_fix_on_save = 1
let g:ale_completion_tsserver_autoimport = 1

let g:ale_fixers = {
\   '*': [
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ],
\   'typescript': [
\       'remove_trailing_lines',
\       'trim_whitespace',
\       'tslint'
\   ]
\}

" }}}
