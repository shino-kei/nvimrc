local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return require("packer").startup(function(use)
  -- plugin manager
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")

  -- color schemes
  use("joshdick/onedark.vim")

  use("nvim-tree/nvim-web-devicons")
  use({
    "romgrk/barbar.nvim",
    requires = "nvim-web-devicons",
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
  })

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  })

  -- LSP settings
  -- https://namileriblog.com/mac/neovim_lsp/#i-1
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-vsnip")
  use({
    "hrsh7th/vim-vsnip",
    config = function()
      vim.cmd([[
        let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
        " Jump forward or backward
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      ]])
    end,
  })
  use("rafamadriz/friendly-snippets")
  use("SweiLz/ROS-Snippets")
  use("onsails/lspkind.nvim")
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
  })
  use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

  -- telescope
  use({
    "ibhagwan/fzf-lua",
    -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" },
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
  })

  -- status bar
  use({
    "itchyny/lightline.vim",
    config = function()
      -- FIXME
    end,
  })

  -- git
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  -- mappings
  use({
    "tyru/caw.vim",
    config = function()
      vim.cmd([[
      nmap <Leader>c <Plug>(caw:hatpos:toggle)
      vmap <Leader>c <Plug>(caw:hatpos:toggle)
      ]])
    end,
  })

  use("kana/vim-operator-user")

  use({
    "rhysd/vim-operator-surround",
    config = function()
      vim.cmd([[map <silent>sa <Plug>(operator-surround-append)]])
      vim.cmd([[map <silent>sd <Plug>(operator-surround-delete)]])
      vim.cmd([[map <silent>sr <Plug>(operator-surround-replace)]])
    end,
  })

  -- appearence
  use("osyo-manga/vim-precious")
  use("Shougo/context_filetype.vim")

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.list = true
      -- vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")

      vim.cmd([[
        augroup IndentBlanklineContextAutogroup
          autocmd!
          autocmd CursorMoved * IndentBlanklineRefresh
        augroup END
      ]])

      require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })


  use({
    "folke/noice.nvim",
    requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", },
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
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        messages = {
          enabled = false
        },
      })
    end
  })


  -- others
  use("cespare/vim-toml")
  use({
    "taketwo/vim-ros",
    config = function()
      vim.cmd([[autocmd BufRead,BufNewFile *.launch setfiletype roslaunch.xml]])
    end,
  })

  use({
    "voldikss/vim-translator",
    config = function()
      vim.cmd([[let g:translator_target_lang = 'ja' ]])
      vim.cmd([[let g:translator_default_engines = ['google'] ]])
    end,
  })

  use({
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  })

  use({ "tyru/capture.vim" })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
