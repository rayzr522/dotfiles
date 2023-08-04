" install vim-plug if not already present
if empty(glob('~/.config/nvim-vscode/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim-vscode/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set rtp+=~/.config/nvim-vscode

call plug#begin('~/.config/nvim-vscode/plug')
Plug 'chaoren/vim-wordmotion'
Plug 'jeetsukumaran/vim-indentwise'
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" functions
function! EditFile(...)
  call VSCodeExtensionNotify('open-file', expand(a:1))
endfunction

" code format settings
set autoindent expandtab tabstop=2 shiftwidth=2 ignorecase smartcase

" keybinds
let mapleader = ' '
let g:wordmotion_prefix = ','
nmap ]d <cmd>call VSCodeNotify('editor.action.marker.next')<cr>
nmap [d <cmd>call VSCodeNotify('editor.action.marker.prev')<cr>
nmap <leader>zr <cmd>source ~/.config/nvim-vscode/init.vim<cr><cmd>echo "Reloaded config!"<cr>
nmap <leader>ze <cmd>call EditFile('~/.config/nvim-vscode/init.vim')<cr>
nmap <leader>zp <cmd>echo "Running PlugInstall..."<cr><cmd>PlugInstall --sync<cr><cmd>q<cr><cmd>echo "Done!"<cr>
nmap <leader>c <cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>
