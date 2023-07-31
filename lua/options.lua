local options = {
	encoding = "utf-8",
	-- fileencoding = {"utf-8", "sjis"},
	title = true,
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	ignorecase = true, 
	incsearch = true, 
	smartindent = true,
	autoindent = true, 
	expandtab = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	shell = "bash",
	backupskip = { "/tmp/*", "/private/tmp/*" },
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = false,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	winblend = 0,
	wildoptions = "pum",
  wildmode = {"longest:full",  "full"},
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
	sidescrolloff = 8,
	guifont = "monospace:h17",
	splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
	splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[nnoremap + <Cmd>let @+ = @@<CR>]])

vim.cmd("au FileType cpp set fo-=c fo-=r fo-=o")
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work


vim.cmd 'colorscheme onedark'
vim.cmd([[
  let g:InactiveBackGround = 'ctermbg=240'
  hi Search ctermbg=Cyan
  hi Search ctermfg=White
  augroup ChangeBackGround
    autocmd!
    " フォーカスした時(colorscheme準拠に切替)
    autocmd FocusGained * hi Normal ctermbg=235 guibg=#282c34" :hi Normalで取得した値
""    autocmd FocusGained * hi NonText ctermbg=235 guibg=#282c34 " :hi NonTextで取得した値
""    autocmd FocusGained * hi SpecialKey ctermbg=235 guibg=#282c34 " :hi SpecialKeyで取得した値
""    autocmd FocusGained * hi EndOfBuffer ctermbg=235 " EndOfBufferの設定は恐らくclearなのでnoneを入れる
    " フォーカスを外した時（フォーカスしていない時の背景色に切替)
    autocmd FocusLost * hi Normal ctermbg=250 guibg=.g:InactiveBackGround" 
""    autocmd FocusLost * hi NonText ctermbg=250 guibg=.g:InactiveBackGround" 
""    autocmd FocusLost * hi SpecialKey ctermbg=250 guibg=.g:InactiveBackGround" 
""    autocmd FocusLost * hi EndOfBuffer ctermbg=250 guibg=.g:InactiveBackGround"
  augroup end
]]) 

