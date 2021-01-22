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

set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" search settings 
set ignorecase
set smartcase
set incsearch
" スワップファイルを作らない
set noswapfile

" don't send wheelscroll event to tmux
set mouse=a

let mapleader = "\<Space>"
nnoremap Q <Nop> 
inoremap <silent> jj <ESC>
inoremap <silent> AA <ESC>A
inoremap <silent> ;; <C-o>A;
inoremap <c-j> <esc>

nnoremap <Leader>o :only<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>t gt
nnoremap <Leader>; A;<ESC>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>m :w<CR>:make<CR>
nnoremap <Leader>r :w<CR>:QuickRun<CR>
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>

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

if executable('atcoder-tools')
  command! AtcoderTest !g++ main.cpp && atcoder-tools test
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
hi Search ctermfg=red

autocmd Filetype * set formatoptions-=ro

let g:InactiveBackGround = 'ctermbg=240'

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

colorscheme onedark
hi Search ctermbg=Cyan
hi Search ctermfg=White
