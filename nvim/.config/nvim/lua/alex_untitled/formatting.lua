-- swift's parser must be generated locally, and this nvim-treesitter branch is
-- archived and still passes --no-bindings, which newer tree-sitter CLIs reject
require("nvim-treesitter.install").ts_generate_args = { "generate", "--abi", vim.treesitter.language_version }

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
		"css",
		"swift",
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		ruby = { "rubocop" },
		eruby = { "rustywind" },
		swift = { "swift_format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters = {
		rustywind = {
			command = "rustywind",
			args = { "--stdin" },
			stdin = true,
		},
	},
})
