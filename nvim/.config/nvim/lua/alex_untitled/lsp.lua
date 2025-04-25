require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"pyright",
		"bashls",
		"intelephense",
		"ts_ls",
		"tailwindcss",
		"eslint",
		"ruby_lsp",
		"rubocop",
		"gopls",
		"html",
	},
})

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(_, _)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end,
}

lspconfig.util.default_config =
	vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults, { capabilities = cmp_capabilities })

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.bashls.setup({})
lspconfig.intelephense.setup({})
lspconfig.ts_ls.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
})
lspconfig.tailwindcss.setup({})
lspconfig.eslint.setup({})
lspconfig.ruby_lsp.setup({})
lspconfig.rubocop.setup({})
lspconfig.gopls.setup({})
lspconfig.html.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})
