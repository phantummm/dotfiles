local config_path = vim.fn.stdpath("config") .. "/init.lua"

vim.g.mapleader = ","
vim.keymap.set({ "n", "x" }, "cy", '"+y')
vim.keymap.set({ "n", "x" }, "cp", '"+p')
vim.keymap.set({ "n" }, "cl", "<cmd>CopyFilePathWithLine<cr>")
vim.keymap.set({ "n" }, "DD", "<cmd>DuplicateFile<cr>")
vim.keymap.set({ "n" }, "<leader>L", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

vim.keymap.set({ "n" }, "<leader>r", "<cmd>e " .. config_path .. "<cr>")
vim.keymap.set({ "n" }, "<leader>R", "<cmd>source " .. config_path .. "<cr>")

vim.keymap.set({ "n" }, "<C-c>", "<cmd>cnext<CR>")
vim.keymap.set({ "n" }, "<C-d>", "<cmd>cprev<CR>")
vim.keymap.set({ "n" }, "<C-x>", "<cmd>cclose<cr>")
vim.keymap.set({ "n" }, "<leader>v", "<cmd>vsplit<cr>")
-- Buffer cycling
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<cr>")

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })

-- Close all buffers except harpooned ones
vim.keymap.set("n", "<leader>Z", function()
	local harpooned = {}
	local list = harpoon:list()
	for i = 1, list:length() do
		local item = list:get(i)
		if item then
			harpooned[vim.fn.fnamemodify(item.value, ":p")] = true
		end
	end

	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if not harpooned[buf.name] then
			vim.api.nvim_buf_delete(buf.bufnr, { force = false })
		end
	end
end, { desc = "Close non-harpooned buffers" })
vim.keymap.set({ "n" }, "<leader>q", "<cmd>q<cr>", { silent = true })
vim.keymap.set({ "n" }, "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", { silent = true })

vim.keymap.set("n", "<leader>B", "<cmd>Git blame<cr>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>Gitsigns toggle_current_line_blame<cr>")

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal current file in tree" })

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>t", "<cmd>AboonFinder<cr>", {})
vim.keymap.set("n", "<leader>d", function()
	require("telescope").extensions.file_browser.file_browser({ respect_gitignore = false })
end)
vim.keymap.set("n", "<leader>D", function()
	require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true, respect_gitignore = false })
end)
-- vim.keymap.set("n", "<leader>D", file_browser.file_browser, { path = "%:p:h", select_buffer = true })
vim.keymap.set("n", "<leader>T", function()
	telescope_builtin.find_files({ no_ignore = true })
end, {})
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
