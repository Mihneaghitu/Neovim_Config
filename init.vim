lua require('plugins')

colorscheme tokyonight
"colorscheme dracula
"colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

set nocompatible
filetype on
filetype plugin on
filetype indent on
set autoindent

syntax on
set relativenumber
set number 
set cursorline
set cursorcolumn

set expandtab
set shiftwidth=2
set tabstop=2
set nowrap
set cc=100
"highlight ColorColumn ctermbg=0 guibg=#8f7fb5

nnoremap bl ^
nnoremap el $
inoremap jj <Esc>
nnoremap el $
nnoremap bl ^
nnoremap <S-k> :m-2<CR>
nnoremap <S-j> :m+<CR>
inoremap <S-k> <Esc>:m-2<CR>
inoremap <S-j> <Esc>:m+<CR>
set cc=120
hi ColorColumn ctermbg=magenta guibg=purple
highlight LineNr term=bold cterm=NONE ctermfg=Green ctermbg=DarkGrey gui=NONE guifg=Green guibg=NONE

