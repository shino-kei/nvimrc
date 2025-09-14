require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"lua_ls",
		"clangd",
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
})


require("mason-null-ls").setup({
	automatic_setup = true,
	automatic_installation = true,
	ensure_installed = { "stylua", "luacheck", "fixjson", "jsonlint", "black", "isort", "flake8",},
	handlers = {},
})

local null_ls = require("null-ls")
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.formatting.black, -- python formatter
-- 		null_ls.builtins.formatting.isort, -- python import sort
-- 		null_ls.builtins.diagnostics.flake8, -- python linter
-- 		null_ls.builtins.formatting.stylua, -- lua formatter
-- 		null_ls.builtins.diagnostics.luacheck, -- lua linter
-- 		null_ls.builtins.formatting.fixjson, -- jxon formatter
-- 		null_ls.builtins.diagnostics.jsonlint, -- jxon formatter
-- 	},
-- })
