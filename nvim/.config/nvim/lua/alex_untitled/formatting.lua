require("nvim-treesitter.configs").setup({
	indent = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	ensure_installed = {
		"lua",
		"python",
		"bash",
		"rust",
		"php",
		"javascript",
		"typescript",
		"tsx",
		"ruby",
		"go",
		"html",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		ruby = { "rubocop_fix" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters = {
		rubocop_fix = {
			command = "~/bin/rubocop_format.sh",
			args = {
				"$FILENAME",
			},
			stdin = false,
			timeout_ms = 10000,
			condition = function(_)
				local cwd = vim.fn.getcwd()
				return cwd:match("^/Users/alex/s/apps")
			end,
		},
	},
})
