vim.cmd("colorscheme gruvbox")
require("gitsigns").setup({})

vim.o.signcolumn = "yes"
-- local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = normal_bg })

require("gruvbox").setup({
	contrast = "hard",
	italic = {
		strings = false,
		operators = false,
		comments = false,
	},
})

vim.opt.number = true
vim.opt.mouse = ""
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitright = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Because ftplugins overwrite formatoptions :(
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

vim.filetype.add({
	extension = {
		tcss = "css",
	},
})
