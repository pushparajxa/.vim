"/* vim: set filetype=ansible : */
"When finds time read someother options from sensible.vim Configuration

" Pathogen first

"execute pathogen#infect()

" Basic Settings
set nocompatible
set backspace=indent,eol,start
filetype plugin indent on
set ft=ansible
set shell=/bin/zsh
set autoindent
set number
set encoding=utf-8
set incsearch
set hlsearch
"set spell spelllang=en_us
set scrolloff=10 "Number of lines below and above the cursor to be shown.
set autoread
"Enables mouse use in all modes
set mouse=a
"Set this to the name of your terminal that suppots mouse codes.
set ttymouse=xterm2
"Send more characters for redraws
set ttyfast
"With this you can Yank and use to paste else where.https://github.com/mhinz/vim-galore
set clipboard=unnamed
"#################################
"Bracketed Paste Mode
"#################################
if !exists("g:bracketed_paste_tmux_wrap")
  let g:bracketed_paste_tmux_wrap = 1
endif

function! WrapForTmux(s)
  if !g:bracketed_paste_tmux_wrap || !exists('$TMUX') || system('tmux -V')[5] >= '2'
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_ti .= WrapForTmux("\<Esc>[?2004h")
let &t_te .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
"#################################
"End Bracketed Paste Mode
"#################################
"###NERDTREE###############
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden=1

map <F2> :NERDTreeToggle<CR>
"autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"###NERDTREE###############
"Synatx file for yaml files
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/syntax/yaml.vim
"#################################
" Plugin manager
"#################################
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Anisible plugin
Plug 'pearofducks/ansible-vim'

" Initialize plugin system
call plug#end()
"#################################
" End of Plugin manager
"#################################

