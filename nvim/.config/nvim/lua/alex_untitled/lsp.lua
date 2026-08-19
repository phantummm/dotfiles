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
		"clangd",
	},
	-- mason-lspconfig calls vim.lsp.enable() for everything above once installed
})

-- shared defaults for every server, merged under any per-server vim.lsp.config() below
vim.lsp.config("*", {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(_, _)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("ts_ls", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
})

vim.lsp.config("ruby_lsp", {
	init_options = {
		addonSettings = {
			["Ruby LSP Rails"] = {
				enablePendingMigrationsPrompt = false,
			},
		},
	},
})

-- not mason-managed (ships with Xcode), so it needs an explicit enable
vim.lsp.config("sourcekit", {
	filetypes = { "swift", "objective-c", "objective-cpp" },
	cmd = { "xcrun", "sourcekit-lsp" },
})
vim.lsp.enable("sourcekit")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})
