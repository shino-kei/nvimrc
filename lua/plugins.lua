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
    vim.g.lightline = {
      enable = { statusline = 1, tabline = 0 }
    }
    vim.g.bufferline_show_unlisted = true

    require'barbar'.setup{
      icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        buffer_index = false,
        buffer_number = false,
        button = '-',
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
          [vim.diagnostic.severity.WARN] = {enabled = false},
          [vim.diagnostic.severity.INFO] = {enabled = false},
          [vim.diagnostic.severity.HINT] = {enabled = true},
        },
        gitsigns = {
          added = {enabled = true, icon = '+'},
          changed = {enabled = true, icon = '~'},
          deleted = {enabled = true, icon = '-'},
        },
        filetype = {
          -- Sets the icon's highlight group.
          -- If false, will use nvim-web-devicons colors
          custom_colors = false,

          -- Requires `nvim-web-devicons` if `true`
          enabled = true,
        },
        separator = {left = '▎', right = ''},

        -- Configure the icons on the bufferline when modified or pinned.
        -- Supports all the base icon options.
        modified = {button = '●'},
        pinned = {button = '!', filename = true, separator = {right = ''}},

        -- Configure the icons on the bufferline based on the visibility of a buffer.
        -- Supports all the base icon options, plus `modified` and `pinned`.
        alternate = {filetype = {enabled = false}},
        current = {buffer_index = true},
        inactive = {button = '×'},
        visible = {modified = {buffer_number = false}},
      },
    }

    -- require'bufferline'.setup { }
  end}

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("nvim-tree").setup()
      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
    end
  }


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
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
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
