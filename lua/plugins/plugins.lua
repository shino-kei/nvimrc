return {
  {
    "windwp/nvim-autopairs",
    config = true,
  },

  {"nvim-lua/plenary.nvim"},

  -- color schemes
  {"joshdick/onedark.vim"},

  {"nvim-tree/nvim-web-devicons"},

  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-web-devicons",
    config = function()
      vim.g.lightline = {
        enable = { statusline = 1, tabline = 0 },
      }
      vim.g.bufferline_show_unlisted = true

      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "<leader><Tab>", "<Cmd>BufferNext<CR>", opts)
      map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
      map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
      map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
      map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
      map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
      map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
      map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
      map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
      map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
      map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

      require("barbar").setup({
        hide = { extensions = false, inactive = false },
        icons = {
          -- Configure the base icons on the bufferline.
          -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
          buffer_index = false,
          buffer_number = false,
          button = "-",
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = true },
          },
          gitsigns = {
            added = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
          filetype = {
            -- Sets the icon's highlight group.
            -- If false, will use nvim-web-devicons colors
            custom_colors = false,

            -- Requires `nvim-web-devicons` if `true`
            enabled = true,
          },
          separator = { left = "▎", right = "" },

          -- Configure the icons on the bufferline when modified or pinned.
          -- Supports all the base icon options.
          modified = { button = "●" },
          pinned = { button = "!", filename = true, separator = { right = "" } },

          -- Configure the icons on the bufferline based on the visibility of a buffer.
          -- Supports all the base icon options, plus `modified` and `pinned`.
          alternate = { filetype = { enabled = false } },
          current = { buffer_index = true },
          inactive = { button = "×" },
          visible = { modified = { buffer_number = false } },
        },
      })

      -- require'bufferline'.setup { }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-cmdline"},
  {"hrsh7th/nvim-cmp"},
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  {"jay-babu/mason-nvim-dap.nvim"},
  {"hrsh7th/cmp-vsnip"},
  {
    "hrsh7th/vim-vsnip",
    config = function()
      vim.cmd([[
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
        " Jump forward or backward
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <C-k>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <C-k>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        imap <expr> <C-j> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <C-j> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      ]])
    end,
  },

  {"rafamadriz/friendly-snippets"},
  {"SweiLz/ROS-Snippets"},
  {"onsails/lspkind.nvim"},
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
  },
  { "nvimtools/none-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },


  { "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          fullscreen = true,
          preview = {
            layout = "vertical",
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

  { "itchyny/lightline.vim",
    config = function()
      -- FIXME
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- mappings
  {
    "tyru/caw.vim",
    config = function()
      vim.cmd([[
      nmap <Leader>c <Plug>(caw:hatpos:toggle)
      vmap <Leader>c <Plug>(caw:hatpos:toggle)
      ]])
    end,
  },


  -- {"kana/vim-operator-user"},
  --
  -- {
  --   "rhysd/vim-operator-surround",
  --   config = function()
  --     vim.cmd([[map <silent>sa <Plug>(operator-surround-append)]])
  --     vim.cmd([[map <silent>sd <Plug>(operator-surround-delete)]])
  --     vim.cmd([[map <silent>sr <Plug>(operator-surround-replace)]])
  --   end,
  -- },

  {
    "hrsh7th/vim-eft",
    config = function()
      vim.cmd([[
      nmap f <Plug>(eft-f)
      xmap f <Plug>(eft-f)
      omap f <Plug>(eft-f)
      nmap F <Plug>(eft-F)
      xmap F <Plug>(eft-F)
      omap F <Plug>(eft-F) ]])
    end,
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",     -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

      vim.cmd([[
        nmap <Leader><Leader> [hop]
        nnoremap <silent> [hop]w :HopWord<CR>
        nnoremap <silent> [hop]l :HopLine<CR>
        nnoremap <silent> [hop]f :HopChar1<CR>
      ]])
    end,
  },


  -- appearence
  {"osyo-manga/vim-precious"},
  {"Shougo/context_filetype.vim"},

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          -- bottom_search = false,   -- use a classic bottom cmdline for search
          command_palette = true,                 -- position the cmdline and popupmenu together
          long_message_to_split = true,           -- long messages will be sent to a split
          inc_rename = false,                     -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,                 -- add a border to hover docs and signature help
        },
        messages = {
          enabled = false,
        },
      })
    end,
  },

  {
    "taketwo/vim-ros",
    config = function()
      vim.cmd([[autocmd BufRead,BufNewFile *.launch setfiletype roslaunch.xml]])
    end,
  },

  {
    "voldikss/vim-translator",
    config = function()
      vim.cmd([[let g:translator_target_lang = 'ja' ]])
      vim.cmd([[let g:translator_default_engines = ['google'] ]])
    end,
  },

  {
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },

  { "tyru/capture.vim" },

  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0,                   -- Maximum length of selection (0 for no limit)
        silent = false,                   -- Disable message on successful copy
        trim = false,                     -- Trim surrounding whitespaces before copy
        tmux_passthrough = false,         -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
      })
      function copy()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
          require("osc52").copy_register("+")
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },

} -- END OF CONFIG --

