" Options

set relativenumber number
set clipboard=unnamed
syntax on

set tabstop=4
set scrolloff=8
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set smartcase
set ignorecase
set breakindent

set termguicolors
set list
set listchars=tab:»·,trail:·,nbsp:␣
set cursorlineopt=number
set signcolumn=yes
set hlsearch

set splitbelow
set splitright

set wrap

set backup!
set swapfile!
set updatetime=250
set timeoutlen=1000 ttimeoutlen=0

" Keymap

nmap <ESC> <CMD>nohlsearch<CR>

inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>

" Move lines in visual mode
vnoremap <silent> J :<C-U>execute "'<,'>m '>+1"<CR>gv=gv
vnoremap <silent> K :<C-U>execute "'<,'>m '<-2"<CR>gv=gv

" Colorscheme
colorscheme sorbet
