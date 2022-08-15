set number
set autoindent
set smartindent
set expandtab
set splitright
set clipboard=unnamed
set hls
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
set autoread

set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" indent settings
set tabstop=2
set shiftwidth=2
if has("autocmd")
  filetype plugin on
  filetype indent on
  autocmd FileType markdown setlocal sw=4 sts=4 ts=4 et
endif

" search settings 
set ignorecase
set smartcase
set incsearch
" スワップファイルを作らない
set noswapfile

" increment/ decrement hex and alphabet
set nf=alpha,hex

" don't send wheelscroll event to tmux
set mouse=a

let mapleader = "\<Space>"
nnoremap Q <Nop> 
inoremap <silent> jj <ESC>
inoremap <silent> AA <ESC>A
inoremap <silent> ;; <C-o>A;<ESC>
inoremap <c-j> <esc>

" toggle 0 and ^
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'

nnoremap <Leader>o :only<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>t gt
nnoremap <Leader>; A;<ESC>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>m :w<CR>:make<CR>
nnoremap <Leader>r :w<CR>:QuickRun<CR>

if exists('g:vscode')
  nnoremap <silent> <Leader>w <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
  nnoremap k gk
  nnoremap gk k
  nnoremap j gj
  nnoremap gj j
else 
  nnoremap <Leader>w :w<CR>
  set ambiwidth=single
endif

" replace ';' and ':'
noremap ; :
noremap : ;

" visual mode setting
vnoremap < <gv
vnoremap > >gv

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nnoremap <ESC><ESC> :nohlsearch<CR>

" in command line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
set wildmenu
set wildmode=longest:full,full

if executable('atcoder-tools')
  command! AtcoderTest !g++ -std=gnu++17 -Wall -Wextra -Wno-unused-result -O2 main.cpp && atcoder-tools test
  command! AtcoderDebug !g++ -std=gnu++17 -Wall -Wextra -Wno-unused-result -DLOCAL -O2 main.cpp && atcoder-tools test

  nnoremap <Leader>at :AtcoderTest<CR>
endif

if executable('oj')
  command! OjTest !g++ main.cpp && oj test
endif

" terminal setting
" tnoremap <silent> <ESC> <C-\><C-n>

if has('persistent_undo')
  set undodir=~/.cache/undo
  set undofile
endif

" dein自体の自動インストール
let s:cache_home = expand('~/.cache')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein#auto_recache = 1
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

" テキスト背景色
au ColorScheme * hi Normal ctermbg=none

autocmd Filetype * set formatoptions-=ro

let g:InactiveBackGround = 'ctermbg=240'

colorscheme onedark
hi Search ctermbg=Cyan
hi Search ctermfg=White

"Neovim自体からフォーカスを外したりした際の切替設定
"(フォーカスした時の設定はcolorschemeに合わせて変更）
augroup ChangeBackGround
autocmd!
" フォーカスした時(colorscheme準拠に切替)
autocmd FocusGained * hi Normal ctermbg=235 " :hi Normalで取得した値
autocmd FocusGained * hi NonText ctermbg=235 " :hi NonTextで取得した値
autocmd FocusGained * hi SpecialKey ctermbg=235 " :hi SpecialKeyで取得した値
autocmd FocusGained * hi EndOfBuffer ctermbg=none " EndOfBufferの設定は恐らくclearなのでnoneを入れる
" フォーカスを外した時（フォーカスしていない時の背景色に切替)
autocmd FocusLost * execute('hi Normal '.g:InactiveBackGround)
autocmd FocusLost * execute('hi NonText '.g:InactiveBackGround)
autocmd FocusLost * execute('hi SpecialKey '.g:InactiveBackGround)
autocmd FocusLost * execute('hi EndOfBuffer '.g:InactiveBackGround)
augroup end

