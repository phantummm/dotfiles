call plug#begin('~/.config/nvim/plugged')

" LSP stuff
Plug 'neovim/nvim-lspconfig'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'

Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'schickling/vim-bufonly'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'

call plug#end()

lua require('config')

filetype plugin indent on
set smartindent
set listchars=tab:→\ ,eol:¬

colorscheme gruvbox
set background=dark
highlight Normal ctermbg=0

set number
set incsearch
set showcmd
set hidden
set ignorecase
set smartcase
set scrolloff=10
set noswapfile

set wildignore=log/**,*/node_modules/**,target/**,tmp/**,vendor/**,public/**,*.rbc,*.pyc,elm-stuff/**
set completeopt=menuone,noinsert,noselect

set list
set shiftwidth=2
set softtabstop=4
set tabstop=4
set wrap!
set expandtab
set mouse=a
set clipboard+=unnamedplus

let g:ctrlsf_ignore_dir = ['public', 'node_modules', 'venv']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#ale#enabled = 1
let g:airline_theme="zenburn"

let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1
let g:NERDTreeWinPos = "right"

let mapleader = ','

map <leader>a :nohlsearch<CR>

map <leader>t :GFiles --recurse-submodule<CR>
map <leader>T :Files<CR>
map <leader>d :NERDTreeToggle<CR>
map <leader>D :NERDTreeFind<CR>
map <leader>H :Gbrowse<CR>

map <leader>F <Plug>(PrettierAsync)

map <leader>S :source ~/.config/nvim/init.vim<CR>
map <leader>r :e ~/.config/nvim/init.vim<CR>
map <leader>R :e ~/.config/nvim/lua/config.lua<CR>

" Copy filename/filepath, respectively
nmap ,cf :let @*=expand("%")<CR>
nmap ,cp :let @*=expand("%:p")<CR>

map <leader>y "*y
map <leader>p "*p
map <leader>P "*P

map <C-h> <C-w>h
map <C-l> <C-w>l

map <C-j> 5j<CR>
map <C-k> 5k<CR>

map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
map <leader>W :BufOnly<CR>
map <leader>w :bp<CR>:bd #<CR>
map <leader>q :q<CR>
map <leader>v :vsplit<CR>
map <leader>V :split<CR><C-j>
map <leader>B :Git blame<CR>

nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
