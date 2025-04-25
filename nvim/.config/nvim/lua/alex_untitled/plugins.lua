-- plugins
-- packer bootstrap
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	local packer_url = "https://github.com/wbthomason/packer.nvim"
	print("Installing packer...")
	vim.fn.system({ "git", "clone", "--depth", "1", packer_url, install_path })
	print("Done.")

	vim.cmd("packadd packer.nvim")
	install_plugins = true
end

if install_plugins then
	return
end

-- specify plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("onsails/lspkind.nvim")

	-- copilot
	use("zbirenbaum/copilot.lua")

	-- autocomplete/snippets
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("zbirenbaum/copilot-cmp")
	use("hrsh7th/nvim-cmp")
	use("m4xshen/autoclose.nvim")

	-- git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")

	-- format/filetypes
	use("stevearc/conform.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use("RRethy/nvim-treesitter-endwise")
	use("windwp/nvim-ts-autotag")
	use({
		"mcauley-penney/tidy.nvim",
		config = true,
	})
	use("numToStr/Comment.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- themes/UI
	use("ellisonleao/gruvbox.nvim")
	use("nvim-lualine/lualine.nvim")
	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		requires = "nvim-tree/nvim-web-devicons",
	})

	if install_plugins then
		print("Syncing packer...")
		require("packer").sync()
	end
end)
