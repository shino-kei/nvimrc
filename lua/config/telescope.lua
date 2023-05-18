  nnoremap <Leader>ff :Telescope find_files<CR>
  nnoremap <Leader>fb :Telescope buffers<CR>
  nnoremap <leader>fg :Telescope live_grep<CR>
  nnoremap <leader>fm :Telescope oldfiles<CR>
lua << EOF
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
require('telescope').load_extension('fzf')
