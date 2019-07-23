set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed
set hls
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
set autoread

" search settings 
set ignorecase
set smartcase
set incsearch
" スワップファイルを作らない
set noswapfile

let mapleader = "\<Space>"
inoremap <silent> jj <ESC>
inoremap <silent> AA <ESC>A

nnoremap <Leader>o :only<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>; A;<ESC>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>m :w<CR>:make<CR>
nnoremap <Leader>r :QuickRun<CR>
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>

" replace ';' and ':'
noremap ; :
noremap : ;


if has('persistent_undo')
  set undodir=~/.cache/undo
  set undofile
endif

" dein自体の自動インストール
let s:cache_home = expand('~/.cache')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if &compatible
  set nocompatible
endif
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable

:command UP UpdateRemotePlugins

