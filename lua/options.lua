-- ============================================================================
-- エンコーディング設定
-- ============================================================================
local encoding_options = {
  encoding = "utf-8", -- Vim 内部で使用する文字エンコーディング
  fileencodings = { "utf-8", "sjis", "euc-jp", "iso-2022-jp", "cp932", "latin1" }, -- ファイルを開く際に試行するエンコーディングのリスト
}

-- ============================================================================
-- UI / 表示設定
-- ============================================================================
local ui_options = {
  title = false, -- タイトル文字列を表示しない
  cmdheight = 1, -- コマンドラインの高さ
  showmode = false, -- モード表示を非表示（lightline などのプラグインが代替）
  showtabline = 2, -- タブラインを常に表示
  number = true, -- 行番号を表示
  relativenumber = false, -- 相対行番号を使用しない
  numberwidth = 4, -- 行番号の表示幅
  signcolumn = "yes", -- サインカラムを常に表示（Git や診断情報用）
  cursorline = true, -- カーソル行をハイライト
  wrap = false, -- 行を折り返さない
  termguicolors = true, -- 24bit カラーを有効化
  background = "dark", -- 背景色を暗い色に設定
  guifont = "monospace:h17", -- GUI フォント設定
  winblend = 0, -- ウィンドウの透過度（0 = 不透明）
  pumblend = 5, -- ポップアップメニューの透過度
  conceallevel = 0, -- conceal 機能を無効化
  scrolloff = 8, -- カーソルの上下に常に表示する行数
  sidescrolloff = 8, -- カーソルの左右に常に表示する文字数
}

-- ============================================================================
-- 検索設定
-- ============================================================================
local search_options = {
  hlsearch = true, -- 検索結果をハイライト表示
  smartcase = true, -- 大文字が含まれる場合のみ大文字小文字を区別
  ignorecase = true, -- 検索時に大文字小文字を区別しない
  incsearch = true, -- インクリメンタルサーチを有効化（入力中に検索）
}

-- ============================================================================
-- 編集 / インデント設定
-- ============================================================================
local edit_options = {
  smartindent = true, -- スマートインデントを有効化（C 言語風の自動インデント）
  autoindent = true, -- 新しい行で前の行のインデントを維持
  expandtab = true, -- タブ文字をスペースに展開
  shiftwidth = 2, -- 自動インデント時のスペース数
  tabstop = 2, -- タブ文字の表示幅
}

-- ============================================================================
-- 補完設定
-- ============================================================================
local completion_options = {
  completeopt = { "menuone", "noselect" }, -- 補完メニューの動作（1つでもメニュー表示、自動選択しない）
  pumheight = 10, -- ポップアップメニューの最大表示項目数
  wildoptions = "pum", -- コマンドライン補完でポップアップメニューを使用
  wildmode = { "longest:full", "full" }, -- コマンドライン補完のモード
}

-- ============================================================================
-- ファイル / バックアップ設定
-- ============================================================================
local file_options = {
  backup = false, -- バックアップファイルを作成しない
  swapfile = false, -- スワップファイルを作成しない
  undofile = true, -- アンドゥ履歴をファイルに保存
  writebackup = false, -- ファイル書き込み前のバックアップを作成しない
  backupskip = { "/tmp/*", "/private/tmp/*" }, -- バックアップをスキップするパターン
}

-- ============================================================================
-- その他の設定
-- ============================================================================
local misc_options = {
  clipboard = "unnamedplus", -- システムクリップボードと連携
  mouse = "a", -- すべてのモードでマウスを有効化
  shell = "bash", -- 使用するシェル
  timeoutlen = 300, -- キーマッピングのタイムアウト時間（ミリ秒）
  updatetime = 300, -- スワップファイル書き込み・CursorHold イベントの待機時間（ミリ秒）
  splitbelow = false, -- 横分割時、新しいウィンドウを上に開く
  splitright = false, -- 縦分割時、新しいウィンドウを左に開く
}

-- ============================================================================
-- すべてのオプションを vim.opt に適用
-- ============================================================================
local function apply_options(opts)
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

apply_options(encoding_options)
apply_options(ui_options)
apply_options(search_options)
apply_options(edit_options)
apply_options(completion_options)
apply_options(file_options)
apply_options(misc_options)

-- その他の vim.opt 設定
vim.opt.shortmess:append("c") -- 補完メニューのメッセージを短縮
vim.opt.whichwrap:append("<,>,[,],h,l") -- 行頭・行末で h,l や矢印キーで前後の行に移動可能にする
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- 自動コメント挿入を無効化

-- ============================================================================
-- クリップボード設定（OSC 52 統合）
-- ============================================================================
local function setup_clipboard()
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = { -- ターミナルを操作しているマシンのクリップボードと連携
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste, -- ペースト時はクリップボード連携をしない
      ["*"] = paste,
    },
  }

  -- 無名レジスタの内容を + レジスタにコピー
  vim.keymap.set("n", "+", "<Cmd>let @+ = @@<CR>", { noremap = true, silent = true })
end

setup_clipboard()

-- ============================================================================
-- ファイルタイプ別設定
-- ============================================================================
-- C/C++ ファイルでの特殊設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    -- 自動コメント挿入を無効化（改行時にコメントを継続しない）
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    -- '-' をキーワードから除外（w や * でのカーソル移動時に '-' で区切る）
    vim.opt_local.iskeyword:remove("-")
  end,
})

-- ============================================================================
-- UI / ハイライト設定
-- ============================================================================
local function setup_ui_autocommands()
  -- 検索ハイライトの色設定
  vim.cmd("hi Search ctermbg=Cyan ctermfg=White")

  -- ウィンドウフォーカスに応じた背景色変更
  vim.g.InactiveBackGround = "ctermbg=240"

  local augroup = vim.api.nvim_create_augroup("ChangeBackGround", { clear = true })

  -- フォーカス取得時（colorscheme 準拠に切替）
  vim.api.nvim_create_autocmd("FocusGained", {
    group = augroup,
    callback = function()
      vim.cmd("hi Normal ctermbg=235 guibg=#282c34")
    end,
  })

  -- フォーカス喪失時（非アクティブ背景色に切替）
  vim.api.nvim_create_autocmd("FocusLost", {
    group = augroup,
    callback = function()
      vim.cmd("hi Normal ctermbg=250 guibg=" .. vim.g.InactiveBackGround)
    end,
  })
end

setup_ui_autocommands()
