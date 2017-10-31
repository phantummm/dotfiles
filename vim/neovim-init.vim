call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'schickling/vim-bufonly'

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
set cursorline
set showcmd
set hidden
set ignorecase
set smartcase
set scrolloff=10
set noswapfile

set wildignore=log/**,*/node_modules/**,target/**,tmp/**,vendor/**,public/**,*.rbc,*.pyc,elm-stuff/**
set completeopt-=preview

set list
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wrap!
set expandtab
set mouse=a
set clipboard+=unnamedplus

let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

let g:neosnippet#snippets_directory='~/.config/snippets'

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
let g:airline#extensions#ale#enabled = 1
let g:airline_theme="gruvbox"

let g:NERDTreeWinSize=80
let g:NERDSpaceDelims=1

let g:NERDSpaceDelims=1

let g:pencil#wrapModeDefault = 'soft'

let mapleader = ','

if has("autocmd")
  augroup fthacks
      autocmd FileType markdown let b:deoplete_disable_auto_complete=1
      autocmd FileType markdown set nocursorline
  augroup END

  augroup pencil
    autocmd!
    autocmd FileType markdown,mkd,md call pencil#init()
    autocmd FileType text call pencil#init({'wrap': 'hard'})
  augroup END
end

map <leader>a :nohlsearch<CR>

map <leader>t :FZF<CR>
map <leader>d :NERDTreeToggle<CR>
map <leader>D :NERDTreeFind<CR>

map <leader>S :source ~/.config/nvim/init.vim<CR>
map <leader>r :e ~/.config/nvim/init.vim<CR>

map <leader>y "*y
map <leader>p "*p
map <leader>P "*P

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-s> <C-w>s
map <C-S> <C-w>v

map <Tab> :bn<CR>
map <S-Tab> :bp<CR>
map <leader>W :BufOnly<CR>
map <leader>w :bp<CR>:bd #<CR>
map <leader>q :q<CR>
map <leader>v :vsplit<CR><C-l>

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

map <leader>g :Goyo<CR>
