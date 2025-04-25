require("nvim-tree").setup({
	hijack_directories = {
		auto_open = false,
	},
	renderer = {
		highlight_opened_files = "all",
	},
	actions = {
		change_dir = {
			restrict_above_cwd = true,
		},
	},
	view = {
		side = "right",
		width = 50,
	},
})

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})

require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		icons_enabled = false,
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
	},
})

local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local fzy = require("telescope.algos.fzy")

local function custom_sorter()
	return sorters.Sorter:new({
		scoring_function = function(prompt, line)
			local score = fzy.score(prompt, line)
			if not score or score < 1 then
				return -1
			end

			if line:match("/db/migrate/") then
				score = score * 1.0
			elseif line.match("app/avo/%.rb") then
				score = score * 1.2
			elseif line:match("schemas/%.yml$") then
				score = score * 1.6
			elseif line:match("%.rb$") then
				score = score * 2
			elseif line:match("%.ts$") then
				score = score * 1.8
			elseif line:match("%.tsx$") then
				score = score * 1.9
			end

			return score
		end,
		highlighter = sorters.ngram_highlighter,
	})
end

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"/api/gen/",
		},
		sorter = custom_sorter(),
		mappings = {
			i = {
				["<C-v>"] = function(prompt_bufnr)
					actions.select_vertical(prompt_bufnr)
				end,
			},
			n = {
				["<C-v>"] = actions.select_vertical,
			},
		},
	},
})

vim.api.nvim_create_user_command("CloseBufferSmartly", function()
	vim.cmd("bdelete")

	local remaining_buffers = vim.fn.getbufinfo({ buflisted = 1 })
	local remaining_count = #remaining_buffers

	if remaining_count == 0 and vim.fn.winnr("$") == 1 and vim.fn.exists("*NvimTreeFindFile") == 1 then
		vim.cmd("enew")
		vim.cmd("NvimTreeFindFile")
	elseif remaining_count > 0 then
		vim.cmd("bp")
	end
end, { desc = "Close buffer smartly" })

vim.api.nvim_create_user_command("DuplicateFile", function()
	local source = vim.fn.expand("%:p")
	if source == "" then
		print("No file loaded in current buffer")
		return
	end

	vim.ui.input({ prompt = "Duplicate to (path): ", default = source }, function(dest)
		if dest and dest ~= "" then
			vim.fn.mkdir(vim.fn.fnamemodify(dest, ":h"), "p") -- create dirs if needed
			vim.fn.writefile(vim.fn.readfile(source), dest)
			print("File duplicated to: " .. dest)
		else
			print("Duplicate cancelled.")
		end
	end)
end, { desc = "Duplicate current file to a new path" })

vim.api.nvim_create_user_command("CopyFilePathWithLine", function()
	local path = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local full = path .. ":" .. line
	vim.fn.setreg("+", full)
	print("Copied to clipboard: " .. full)
end, { desc = "Copy file path + line to system clipboard" })
