return {

  ------------------------------------------------------------------------------
  -- 基本ライブラリと共通依存パッケージ
  ------------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  ------------------------------------------------------------------------------
  -- カラースキーム＆見た目の改善
  ------------------------------------------------------------------------------
  {
    "joshdick/onedark.vim",
    config = function()
      vim.cmd("colorscheme onedark")
    end,
  },
  { "osyo-manga/vim-precious" },
  { "Shougo/context_filetype.vim" },

  ------------------------------------------------------------------------------
  -- ステータスライン・バッファライン
  ------------------------------------------------------------------------------
  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-web-devicons",
    config = function()
      -- lightline 用の設定（barbar を使う場合も必要に応じて調整）
      vim.g.lightline = { enable = { statusline = 1, tabline = 0 } }
      vim.g.bufferline_show_unlisted = true

      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "<leader><Tab>", "<Cmd>BufferNext<CR>", opts)
      for i = 1, 9 do
        map("n", "<leader>" .. i, string.format("<Cmd>BufferGoto %d<CR>", i), opts)
      end
      map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

      require("barbar").setup({
        hide = { extensions = false, inactive = false },
        icons = {
          buffer_index = false,
          buffer_number = false,
          button = "-",
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
            [vim.diagnostic.severity.WARN]  = { enabled = false },
            [vim.diagnostic.severity.INFO]  = { enabled = false },
            [vim.diagnostic.severity.HINT]  = { enabled = true },
          },
          gitsigns = {
            added   = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
          filetype = {
            custom_colors = false,
            enabled = true,
          },
          separator = { left = "▎", right = "" },
          modified = { button = "●" },
          pinned = { button = "!", filename = true, separator = { right = "" } },
          alternate = { filetype = { enabled = false } },
          current   = { buffer_index = true },
          inactive  = { button = "×" },
          visible   = { modified = { buffer_number = false } },
        },
      })
    end,
  },
  {
    "itchyny/lightline.vim",
    config = function()
      -- FIXME: lightline の設定を必要に応じて追加
    end,
  },

  ------------------------------------------------------------------------------
  -- ファイルツリー・エクスプローラー
  ------------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        actions = {
          open_file = {
            quit_on_open = true,  -- ファイルを開いたらツリーを閉じる
            resize_window = true, -- 自動で幅調整
          },
        },
      })
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  ------------------------------------------------------------------------------
  -- 自動補完・スニペット関連
  ------------------------------------------------------------------------------
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-vsnip" },
  {
    "hrsh7th/vim-vsnip",
    config = function()
      vim.cmd([[
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
        " ジャンプ設定
        imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
        imap <expr> <C-k>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
        smap <expr> <C-k>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
        imap <expr> <C-j>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
        smap <expr> <C-j>   vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
      ]])
    end,
  },
  { "rafamadriz/friendly-snippets" },
  { "SweiLz/ROS-Snippets" },
  { "onsails/lspkind.nvim" },

  ------------------------------------------------------------------------------
  -- LSP, Mason, Null-ls 関連
  ------------------------------------------------------------------------------
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "jay-babu/mason-null-ls.nvim" },
  { "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "jay-babu/mason-nvim-dap.nvim" },

  ------------------------------------------------------------------------------
  -- デバッグ (DAP) 関連
  ------------------------------------------------------------------------------
  { "mfussenegger/nvim-dap" },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  ------------------------------------------------------------------------------
  -- ナビゲーション＆検索
  ------------------------------------------------------------------------------
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          fullscreen = true,
          preview = { layout = "vertical" },
        },
        previewers = {
          builtin = {
            treesitter = { enabled = true, disabled = { 'lua' } },
          },
        },
      })
      vim.keymap.set("n", "<leader>g", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>")
      vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>")
      vim.keymap.set("v", "<leader>fg", "<cmd>lua require('fzf-lua').grep_visual()<CR>")
      vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>")
      vim.keymap.set("n", "<leader>fm", "<cmd>lua require('fzf-lua').oldfiles()<CR>")
      vim.keymap.set("n", "<leader>fc", "<cmd>lua require('fzf-lua').builtin()<CR>")
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      vim.cmd([[
        nnoremap <Leader><Leader> [hop]
        nnoremap <silent> [hop]w :HopWord<CR>
        nnoremap <silent> [hop]l :HopLine<CR>
        nnoremap <silent> [hop]f :HopChar1<CR>
      ]])
    end,
  },

  ------------------------------------------------------------------------------
  -- Git 関連
  ------------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- 各種操作を強化するプラグイン
  ------------------------------------------------------------------------------
  {
    "tyru/caw.vim",
    config = function()
      vim.cmd([[
        nmap <Leader>c <Plug>(caw:hatpos:toggle)
        vmap <Leader>c <Plug>(caw:hatpos:toggle)
      ]])
    end,
  },
  {
    "rhysd/vim-operator-surround",
    dependencies = { "kana/vim-operator-user" },
    config = function()
      vim.cmd([[
        map <silent>sa <Plug>(operator-surround-append)
        map <silent>sd <Plug>(operator-surround-delete)
        map <silent>sr <Plug>(operator-surround-replace)
      ]])
    end,
  },
  {
    "hrsh7th/vim-eft",
    config = function()
      vim.cmd([[
        nmap f <Plug>(eft-f)
        xmap f <Plug>(eft-f)
        omap f <Plug>(eft-f)
        nmap F <Plug>(eft-F)
        xmap F <Plug>(eft-F)
        omap F <Plug>(eft-F)
      ]])
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter とインデント表示
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "lua", "rust" },
        highlight = { enable = true },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },

  ------------------------------------------------------------------------------
  -- 自動括弧閉じなどの編集支援
  ------------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  ------------------------------------------------------------------------------
  -- UI 強化 (通知や LSP 表示など)
  ------------------------------------------------------------------------------
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"]            = true,
            ["cmp.entry.get_documentation"]              = true,
          },
        },
        presets = {
          command_palette       = true,
          long_message_to_split = true,
          inc_rename            = false,
          lsp_doc_border        = false,
        },
        messages = { enabled = false },
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- ROS 関連・その他の便利機能
  ------------------------------------------------------------------------------
  {
    "taketwo/vim-ros",
    config = function()
      vim.cmd("autocmd BufRead,BufNewFile *.launch setfiletype roslaunch.xml")
    end,
  },
  {
    "voldikss/vim-translator",
    config = function()
      vim.cmd("let g:translator_target_lang = 'ja'")
      vim.cmd("let g:translator_default_engines = ['google']")
    end,
  },
  {
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },
  { "tyru/capture.vim" },
  -- {
  --   "ojroques/nvim-osc52",
  --   config = function()
  --     require("osc52").setup({
  --       max_length       = 0,
  --       silent           = false,
  --       trim             = false,
  --       tmux_passthrough = false,
  --     })
  --     local function copy()
  --       if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
  --         require("osc52").copy_register("+")
  --       end
  --     end
  --     vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  --   end,
  -- },

}
