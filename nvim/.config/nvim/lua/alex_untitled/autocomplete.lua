local keymaps = require("alex_untitled.keymaps")

require("nvim-ts-autotag").setup({})
require("autoclose").setup({})
require("copilot").setup({
	panel = { enabled = false },
	suggestion = { enabled = true },
})
require("copilot_cmp").setup({})
require("Comment").setup({})

local cmp = require("cmp")
local lspkind = require("lspkind")

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup({
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	performance = {
		max_view_entries = 20,
	},
	mapping = keymaps.cmp_mappings,
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "copilot", group_index = 2 },
		{ name = "path", group_index = 4 },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			-- mode = 'symbol',
			maxwidth = 100,
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function(_, vim_item)
				return vim_item
			end,
			symbol_map = { Copilot = "" },
		}),
	},
})
