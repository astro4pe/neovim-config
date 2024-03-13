-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- NOTE: My autocommand to turn backgroud transparent
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
		vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
