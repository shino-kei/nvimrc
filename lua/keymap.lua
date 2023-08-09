local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal -h
-- Better window navigation
-- keymap("n", "<h-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "gn", ":tabnew<Return>", opts)
-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
-- keymap("n", ";", ":", { noremap = false, silent = true })
-- keymap("n", ":", ";", { noremap = false, silent = true })

vim.cmd([[
  noremap ; :
  noremap : ;
]])

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>:noh<Return>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)
keymap("i", "AA", "<ESC>A", opts)
keymap("i", ";;", "<C-o>A;<ESC>", opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)

-- <Leader>w でバッファに書き込み
keymap("n", "<Leader>w", ":w<Return>", opts)

vim.cmd([[
if executable('atcoder-tools')
  command! AtcoderTest !g++ -std=gnu++17 -Wall -Wextra -Wno-unused-result -O2 main.cpp -I /Users/keisuke/workspace/atcoder/ac-library && atcoder-tools test
  command! AtcoderDebug !g++ -std=gnu++17 -Wall -Wextra -Wno-unused-result -DLOCAL -O0 -g3 main.cpp && atcoder-tools test
  nnoremap <Leader>at :AtcoderTest<CR>
  endif
  ]])

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set("n", "e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local lspopts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lspopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, lspopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, lspopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, lspopts)
		-- vim.keymap.set('n', '', vim.lsp.buf.signature_help, lspopts)
		-- vim.keymap.set('n', 'wa', vim.lsp.buf.add_workspace_folder, lspopts)
		-- vim.keymap.set('n', 'wr', vim.lsp.buf.remove_workspace_folder, lspopts)
		-- vim.keymap.set('n', 'wl', function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, lspopts)
		-- vim.keymap.set('n', 'D', vim.lsp.buf.type_definition, lspopts)
		vim.keymap.set("n", "rn", vim.lsp.buf.rename, lspopts)
		-- vim.keymap.set({ 'n', 'v' }, 'ca', vim.lsp.buf.code_action, lspopts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, lspopts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, lspopts)
	end,
})
