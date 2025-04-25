local config_path = vim.fn.stdpath("config") .. "/init.lua"

vim.g.mapleader = ","
vim.keymap.set({ "n", "x" }, "cp", '"+y')
vim.keymap.set({ "n", "x" }, "cv", '"+p')
vim.keymap.set({ "n" }, "cl", "<cmd>CopyFilePathWithLine<cr>")
vim.keymap.set({ "n" }, "DD", "<cmd>DuplicateFile<cr>")

vim.keymap.set({ "n" }, "<leader>r", "<cmd>e " .. config_path .. "<cr>")
vim.keymap.set({ "n" }, "<leader>R", "<cmd>source " .. config_path .. "<cr>")

vim.keymap.set({ "n" }, "<C-c>", "<cmd>cnext<CR>")
vim.keymap.set({ "n" }, "<C-d>", "<cmd>cprev<CR>")
vim.keymap.set({ "n" }, "<C-x>", "<cmd>cclose<cr>")
vim.keymap.set({ "n" }, "<leader>v", "<cmd>vsplit<cr>")
vim.keymap.set({ "n" }, "<Tab>", "<cmd>bn<cr>")
vim.keymap.set({ "n" }, "<S-Tab>", "<cmd>bp<cr>")
vim.keymap.set({ "n" }, "<leader>a", "<cmd>BufferLineTogglePin<cr>")
vim.keymap.set({ "n" }, "<leader>z", "<cmd>BufferLineGroupToggle ungrouped<cr>")
vim.keymap.set({ "n" }, "<leader>W", "<cmd>BufferLineGroupClose ungrouped<cr>")
vim.keymap.set({ "n" }, "<leader>1", "<cmd>BufferLinePick<cr>")
vim.keymap.set({ "n" }, "<leader>w", "<cmd>CloseBufferSmartly<cr>")
vim.keymap.set({ "n" }, "<leader>q", "<cmd>q<cr>", { silent = true })
vim.keymap.set({ "n" }, "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", { silent = true })

vim.keymap.set("n", "<leader>d", "<cmd>:NvimTreeToggle<cr>", {})
vim.keymap.set("n", "<leader>D", "<cmd>:NvimTreeFindFile<cr>", {})

vim.keymap.set("n", "<leader>B", "<cmd>Git blame<cr>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>Gitsigns toggle_current_line_blame<cr>")

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>t", "<cmd>AboonFinder<cr>", {})
vim.keymap.set("n", "<leader>T", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>F", telescope_builtin.live_grep, {})
vim.keymap.set("n", "fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "fh", telescope_builtin.help_tags, {})
vim.keymap.set("n", "fo", telescope_builtin.oldfiles, {})

vim.api.nvim_create_autocmd("User", {
	pattern = "LspAttached",
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		bufmap("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

-- Gotta export these to get used in autocomplete setup
local cmp = require("cmp")
local M = {}

M.cmp_mappings = cmp.mapping.preset.insert({
	["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<CR>"] = cmp.mapping({
		i = function(fallback)
			if cmp.visible() and cmp.get_active_entry() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
			else
				fallback()
			end
		end,
		s = cmp.mapping.confirm({ select = true }),
		c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	}),
})

return M
