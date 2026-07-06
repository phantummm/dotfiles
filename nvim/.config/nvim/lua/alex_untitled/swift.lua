local ok, xcodebuild = pcall(require, "xcodebuild")
if not ok then
	return
end

xcodebuild.setup({
	code_coverage = {
		enabled = false,
	},
	logs = {
		auto_open_on_failed_tests = true,
		auto_open_on_failed_build = true,
		auto_close_on_success = true,
	},
	test_search = {
		target_matching = "file_pattern",
	},
})

-- Keymaps: <leader>x prefix (leader = ,)
vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle build logs" })
vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build project" })
vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & run" })
vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run all tests" })
vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run tests in current file" })
vim.keymap.set("n", "<leader>xn", "<cmd>XcodebuildTestNearest<cr>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select scheme" })
vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select device/simulator" })
vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select test plan" })
vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildCleanBuild<cr>", { desc = "Clean build" })
