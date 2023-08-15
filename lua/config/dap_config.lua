require("mason-nvim-dap").setup({
  ensure_installed = { "python", "codelldb" }
})

local dap = require("dap")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointTextHl" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedTextHl" })
dap.adapters = {
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
      args = { "--port", "${port}" },
    },
  },
  debugpy = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
    args = { "-m", "debugpy.adapter" },
  },
}
dap.configurations = {
  cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/a.out", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  },
  -- python = {
  --   {
  --     name = "Launch file",
  --     type = "debugpy",
  --     request = "launch",
  --     program = "${file}",
  --     pythonPath = vim.fn.fnamemodify("~/.pyenv/shims/python", ":p"),
  --   },
  -- },
}

require("dapui").setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches",     size = 0.20 },
        { id = "stacks",      size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes",      size = 0.40 },
      },
      size = 64,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})

function DapBegin()
  vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', { silent = true })
  require 'dapui'.open()
  -- vim.api.nvim_set_keymap('n', '<2-LeftMouse>', '<Cmd>lua require"dapui".eval()<CR>', { silent = true, buffer = true })
end

function DapEnd()
  local mappings = { '<F4>', '<F5>', '<F10>', '<F11>', '<F12>' }
  for _, map in ipairs(mappings) do
    vim.api.nvim_del_keymap('n', map)
  end
  require 'dapui'.close()
  require 'dap'.clear_breakpoints()
  require 'dap'.disconnect()
end

-- You might want to expose these as commands
vim.cmd("command! DapBegin lua DapBegin()")
vim.cmd("command! DapEnd lua DapEnd()")

vim.cmd([[
  nnoremap <silent><F4>  <Cmd>lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent><F5>  <Cmd>lua require'dap'.continue()<CR>
  hi DapBreakpointTextHl guifg=#AA0000
  hi DapStoppedTextHl guifg=#00c853
]])
