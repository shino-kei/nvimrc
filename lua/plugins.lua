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

return require('packer').startup(function(use)
  -- plugin manager
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'

  -- color schemes
  use 'joshdick/onedark.vim'

  use 'nvim-tree/nvim-web-devicons'
  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons',  config=function()

    require'bufferline'.setup {
      -- Enable/disable animations
      animation = false,

      -- Enable/disable auto-hiding the tab bar when there is a single buffer
      auto_hide = false,

      -- Enable/disable current/total tabpages indicator (top right corner)
      tabpages = true,

      -- Enable/disable close button
      closable = true,

      -- Enables/disable clickable tabs
      --  - left-click: go to buffer
      --  - middle-click: delete buffer
      clickable = true,

      -- Enables / disables diagnostic symbols
      diagnostics = {
        -- you can use a list
        {enabled = true, icon = 'ﬀ'}, -- ERROR
        {enabled = false}, -- WARN
        {enabled = false}, -- INFO
        {enabled = true},  -- HINT

        -- OR `vim.diagnostic.severity`
        [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
        [vim.diagnostic.severity.WARN] = {enabled = false},
        [vim.diagnostic.severity.INFO] = {enabled = false},
        [vim.diagnostic.severity.HINT] = {enabled = true},
      },

      -- Excludes buffers from the tabline
      exclude_ft = {'javascript'},
      exclude_name = {'package.json'},

      -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
      -- Valid options are 'left' (the default) and 'right'
      focus_on_close = 'left',

      -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
      hide = {extensions = true, inactive = true, current=false},

      -- Disable highlighting alternate buffers
      highlight_alternate = false,

      -- Disable highlighting file icons in inactive buffers
      highlight_inactive_file_icons = false,

      -- Enable highlighting visible buffers
      highlight_visible = true,

      -- Enable/disable icons
      -- if set to 'numbers', will show buffer index in the tabline
      -- if set to 'both', will show buffer index and icons in the tabline
      icons = true,

      -- If set, the icon color will follow its corresponding buffer
      -- highlight group. By default, the Buffer*Icon group is linked to the
      -- Buffer* group (see Highlighting below). Otherwise, it will take its
      -- default value as defined by devicons.
      icon_custom_colors = false,

      -- Configure icons on the bufferline.
      icon_separator_active = '▎',
      icon_separator_inactive = '▎',
      icon_close_tab = '',
      icon_close_tab_modified = '●',
      icon_pinned = '車',

      -- If true, new buffers will be inserted at the start/end of the list.
      -- Default is to insert after current buffer.
      insert_at_end = false,
      insert_at_start = false,

      -- Sets the maximum padding width with which to surround each tab
      maximum_padding = 1,

      -- Sets the minimum padding width with which to surround each tab
      minimum_padding = 1,

      -- Sets the maximum buffer name length.
      maximum_length = 30,

      -- If set, the letters for each buffer in buffer-pick mode will be
      -- assigned based on their name. Otherwise or in case all letters are
      -- already assigned, the behavior is to assign letters in order of
      -- usability (see order below)
      semantic_letters = true,

      -- New buffer letters are assigned in this order. This order is
      -- optimal for the qwerty keyboard layout but might need adjustement
      -- for other layouts.
      letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

      -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
      -- where X is the buffer number. But only a static string is accepted here.
      no_name_title = nil,
    }
  end}


  -- LSP settings
  use {'neoclide/coc.nvim', branch='release' , 
  config = function() 
    local mypath = os.getenv("HOME") .. "/.config/nvim/lua"
    vim.cmd(string.format('source %s/config/coc.vim', mypath))
  end }
  use {'Shougo/neosnippet.vim',  config=function()
    vim.cmd([[
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory='~/.nvim/snippets'
    ]]) end }

    use 'Shougo/neosnippet-snippets'

    -- telescope
    use { 'nvim-telescope/telescope.nvim',  config=function()
      vim.cmd[[
      nnoremap <Leader>ff :Telescope find_files<CR>
      nnoremap <Leader>fb :Telescope buffers<CR>
      nnoremap <leader>fg :Telescope live_grep<CR>
      nnoremap <leader>fm :Telescope oldfiles<CR>
      ]]
      local actions = require("telescope.actions")
      require("telescope").setup{
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          },
        },
      }

      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        }
      }
      -- require('telescope').load_extension('fzf')
    end }

    -- status bar
    use {'itchyny/lightline.vim',  config=function()
      -- FIXME
    end }

    -- mappings
    use {'tyru/caw.vim',  config=function()
      vim.cmd([[
      nmap <Leader>c <Plug>(caw:hatpos:toggle)
      vmap <Leader>c <Plug>(caw:hatpos:toggle)
      ]]) end}
      use "kana/vim-operator-user"
      use {'rhysd/vim-operator-surround',  config=function()
        vim.cmd([[map <silent>sa <Plug>(operator-surround-append)]])
        vim.cmd([[map <silent>sd <Plug>(operator-surround-delete)]])		  
        vim.cmd([[map <silent>sr <Plug>(operator-surround-replace)]])
      end}

      -- others
      use 'osyo-manga/vim-precious'
      use 'Shougo/context_filetype.vim'
      use 'cespare/vim-toml'
      use 'taketwo/vim-ros'

      use { 'voldikss/vim-translator',  config=function()
        vim.cmd([[let g:translator_target_lang = 'ja' ]])  
        vim.cmd([[let g:translator_default_engines = ['google'] ]])
      end}



    end)
