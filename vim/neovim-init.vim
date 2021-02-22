call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'alvan/vim-closetag'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'

call plug#end()

filetype plugin indent on
set smartindent
set listchars=tab:→\ ,eol:¬

colorscheme gruvbox
set background=dark

set number
set incsearch
set showcmd
set hidden
set ignorecase
set smartcase
set scrolloff=10
set noswapfile

set wildignore=log/**,*/node_modules/**,target/**,tmp/**,vendor/**,public/**,*.rbc,*.pyc,elm-stuff/**
set completeopt-=preview

set list
set shiftwidth=2
set softtabstop=4
set tabstop=4
set wrap!
set expandtab
set mouse=a
set clipboard+=unnamedplus

let g:python_host_prog = '/Users/alex/.pyenv/versions/py2nvim/bin/python'
let g:python3_host_prog = '/Users/alex/.pyenv/versions/py3nvim/bin/python'

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'

let g:neosnippet#snippets_directory='~/.config/snippets'

let g:ctrlsf_ignore_dir = ['public', 'node_modules', 'venv']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#ale#enabled = 1
let g:airline_theme="zenburn"

let g:NERDTreeWinSize=40
let g:NERDSpaceDelims=1

let mapleader = ','

if has("autocmd")
  " Prettier auto-format
  " let g:prettier#autoformat = 0
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
end

map <leader>a :nohlsearch<CR>

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>h :<C-U>call CocAction('doHover')<CR>

map <leader>t :GFiles --recurse-submodule<CR>
map <leader>T :Files<CR>
map <leader>d :NERDTreeToggle<CR>
map <leader>D :NERDTreeFind<CR>
map <leader>H :Gbrowse<CR>

map <leader>S :source ~/.config/nvim/init.vim<CR>
map <leader>r :e ~/.config/nvim/init.vim<CR>

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
map <leader>v :vsplit<CR>:bp<CR>
map <leader>V :split<CR><C-j>
map <leader>B :Gblame<CR>

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

imap <C-l>     <Plug>(neosnippet_expand_or_jump)
smap <C-l>     <Plug>(neosnippet_expand_or_jump)
xmap <C-l>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable()
    \ ? "\<Plug>(neosnippet_expand_or_jump)"
    \ : "\<TAB>"
