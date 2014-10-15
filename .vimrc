set nocompatible
syntax enable

filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

call vundle#end()

filetype plugin indent on
filetype on

colorscheme solarized
highlight clear SignColumn

set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set directory-=.
set encoding=utf-8
set expandtab
set incsearch
set laststatus=2
set number
set ruler
set shiftwidth=2
set showcmd
set smartcase
set softtabstop=2
set tabstop=8
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc

set mouse=a

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <C-w> :bd<CR>
nnoremap <C-W> :bd!<CR>
nnoremap <leader>p :e ~/.vimrc<CR>
nnoremap <leader>P :e ~/.vimrc.bundles<CR>
nnoremap <leader>S :source ~/.vimrc<CR>

nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>B :!python %<CR>
