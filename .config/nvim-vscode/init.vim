" code format settings
set autoindent expandtab tabstop=2 shiftwidth=2

" keybinds
nnoremap <C-w>r <Cmd>source ~/.config/nvim-vscode/init.vim<cr>

if empty(glob('~/.config/nvim-vscode/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim-vscode/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | q
    \| endif
endif

set rtp+=~/.config/nvim-vscode

call plug#begin('~/.config/nvim-vscode/plug')
Plug 'chaoren/vim-wordmotion'
call plug#end()

let g:wordmotion_prefix = ','
