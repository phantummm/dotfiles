call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'dyng/ctrlsf.vim'
Plug 'schickling/vim-bufonly'

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'

Plug 'w0rp/ale'
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

Plug 'sheerun/vim-polyglot'
Plug 'ElmCast/elm-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'flowtype/vim-flow'

Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

call plug#end()

let g:polyglot_disabled = ['elm', 'javascript', 'jsx']

filetype plugin indent on
set smartindent
set listchars=tab:▸\ ,eol:¬

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

set list
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wrap!
set expandtab
set mouse=a

let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

let g:flow#timeout = 5
let g:flow#autoclose = 1
let g:flow#enable = 0
let g:showquickfix = 0

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linters = { 'javascript': ['eslint', 'flow'] }

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline_theme="gruvbox"

let g:NERDTreeWinSize=30
let g:NERDSpaceDelims=1

let g:pencil#wrapModeDefault = 'soft'

let mapleader = ','

map <leader>a :nohlsearch<CR>

map <leader>t :FZF<CR>
map <leader>d :NERDTreeToggle<CR>

map <leader>S :source ~/.config/nvim/init.vim<CR>
map <leader>p :e ~/.config/nvim/init.vim<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-s> <C-w>s
map <C-S> <C-w>v

map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
map <leader>w :bd<CR>
map <leader>W :bp<CR>:bd #<CR>
map <leader>q :q<CR>

map <leader>g :Goyo<CR>
