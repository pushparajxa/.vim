"When finds time read someother options from sensible.vim
" Configuration

" Pathogen first

execute pathogen#infect()

" Basic Settings

filetype plugin indent on
syntax on
set shell=/bin/zsh
"set autoindent
set number
set encoding=utf-8
set incsearch
set hlsearch
set spell spelllang=en_us
set scrolloff=1 "Number of lines below and above the cursor to be shown.
set autoread
