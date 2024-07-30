return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},

	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Cscope" },
				{ "<leader>s", group = "Search" },
				{ "<leader>lw", group = "Workspace" },
				{ "<leader>x", group = "Trouble" },
				{ "<leader>l", group = "Lsp" },
				{ "<leader>q", group = "Session" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>m", group = "Bookmarks" },
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				active = true,
				on_config_done = nil,
				-- size can be a number or function which is passed the current terminal
				size = 20,
				-- open_mapping = [[<c-/>]],
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
				start_in_insert = true,
				insert_mappings = true, -- whether or not the open mapping applies in insert mode
				persist_size = false,
				-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
				direction = "float",
				close_on_exit = true, -- close the terminal window when the process exits
				shell = nil, -- change the default shell
				-- This field is only relevant if direction is set to 'float'
				float_opts = {
					-- The border key is *almost* the same as 'nvim_win_open'
					-- see :h nvim_win_open for details on borders however
					-- the 'curved' border is a custom border type
					-- not natively supported but implemented in this plugin.
					-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
					border = "curved",
					-- width = <value>,
					-- height = <value>,
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				-- Add executables on the config.lua
				-- { cmd, keymap, description, direction, size }
				-- lvim.builtin.terminal.execs = {...} to overwrite
				-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
				-- TODO: pls add mappings in which key and refactor this
				-- execs = {
				-- 	{ nil, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
				-- 	{ nil, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
				-- 	{ nil, "<M-3>", "Float Terminal", "float", nil },
				-- },
			})
			vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "ToggleTerm" })
			vim.keymap.set(
				"n",
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<CR>",
				{ desc = "ToggleTerm Horizontal" }
			)
			vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "ToggleTerm Float" })
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		-- Lua
		config = function()
			-- Lua
			vim.keymap.set("n", "<leader>xx", function()
				require("trouble").toggle()
			end, { desc = "TroubleToggle" })
			vim.keymap.set("n", "<leader>xw", function()
				require("trouble").toggle("workspace_diagnostics")
			end, { desc = "workspace_diagnostics" })
			vim.keymap.set("n", "<leader>xd", function()
				require("trouble").toggle("document_diagnostics")
			end, { desc = "document_diagnostics" })
			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").toggle("quickfix")
			end, { desc = "quickfix" })
			vim.keymap.set("n", "<leader>xl", function()
				require("trouble").toggle("loclist")
			end, { desc = "loclist" })
			vim.keymap.set("n", "gR", function()
				require("trouble").toggle("lsp_references")
			end, { desc = "lsp_references" })
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
	{
		"LunarVim/bigfile.nvim",
		config = function()
			-- default config
			require("bigfile").setup({
				filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
				pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
				features = { -- features to disable
					"indent_blankline",
					"illuminate",
					--'lsp',
					"treesitter",
					--'syntax',
					--'matchparen',
					--'vimopts',
					--'filetype',
				},
			})
		end,
	},
	{
		"dhananjaylatkar/cscope_maps.nvim",
		dependencies = {
			"folke/which-key.nvim", -- optional [for whichkey hints]
			"nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
			"ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
			"nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
		},
		opts = {},
		config = function()
			require("cscope_maps").setup({
				-- maps related defaults
				disable_maps = false, -- "true" disables default keymaps
				skip_input_prompt = true, -- "true" doesn't ask for input
				prefix = "<leader>c", -- prefix to trigger maps

				-- cscope related defaults
				cscope = {
					-- location of cscope db file
					db_file = "./cscope.out",
					-- cscope executable
					exec = "cscope", -- "cscope" or "gtags-cscope"
					-- choose your fav picker
					picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
					-- size of quickfix window
					qf_window_size = 5, -- any positive integer
					-- position of quickfix window
					qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
					-- "true" does not open picker for single result, just JUMP
					skip_picker_for_single_result = false, -- "false" or "true"
					-- these args are directly passed to "cscope -f <db_file> <args>"
					db_build_cmd_args = { "-bqkv" },
					-- statusline indicator, default is cscope executable
					statusline_indicator = nil,
					-- try to locate db_file in parent dir(s)
					project_rooter = {
						enable = false, -- "true" or "false"
						-- change cwd to where db_file is located
						change_cwd = false, -- "true" or "false"
					},
				},
			})
		end,
	},
	-- "hari-rangarajan/CCTree", -- doesn't seem to work, cant even load the cscope.out file, errors on loading.
	{
		"ldelossa/litee-calltree.nvim",
		dependencies = {
			"ldelossa/litee.nvim",
		},
		opts = {},
		config = function()
			require("litee.lib").setup({
				tree = {
					icon_set = "codicons",
				},
				panel = {
					orientation = "right",
					panel_size = 30,
				},
			})
			require("litee.calltree").setup({})
			-- vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, { desc = "vim.lsp.buf.outgoing_calls" })
			vim.keymap.set("n", "<leader>co", vim.lsp.buf.incoming_calls, { desc = "Open Call Tree" })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"LintaoAmons/bookmarks.nvim", -- "tristone13th/lspmark.nvim" -- more powerful but complex
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
		},
		config = function()
			local function call_bookmark_command()
				local commands = require("bookmarks.adapter.commands").commands
				local command
				for _, c in ipairs(commands) do
					if c.name == "[Mark] Bookmarks of current project" then -- change it to one of the command above
						command = c
					end
				end

				if command then
					command.callback()
				end
			end

			vim.keymap.set({ "n", "v" }, "<leader>mm", "<cmd>BookmarksMark<cr>", { desc = "Add mark at current line" })
			vim.keymap.set({ "n", "v" }, "<leader>ml", call_bookmark_command, { desc = "List project marks" })
			vim.keymap.set({ "n", "v" }, "<leader>mo", "<cmd>BookmarksGoto<cr>", { desc = "List all marks" })
			vim.keymap.set({ "n", "v" }, "<leader>mc", "<cmd>BookmarksCommands<cr>", { desc = "Commands" })
			vim.keymap.set({ "n", "v" }, "<leader>mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Goto recent" })
		end,
	},
}
