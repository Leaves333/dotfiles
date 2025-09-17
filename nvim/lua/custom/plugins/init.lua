-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

	-- folding plugin
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			useLspFoldsWithTreesitterFallback = true,
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = 4,
				lineCount = {
					template = "%d lines", -- `%d` is replaced with the number of folded lines
					hlgroup = "Comment",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = true, -- requires `gitsigns.nvim`
			},
			autoFold = {
				enabled = false,
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			foldKeymaps = {
				setup = false, -- modifies `h` and `l`
				hOnlyOpensOnFirstColumn = false,
			},
		},

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},

	-- vimtex???
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_format_enabled = true
		end,
	},

	-- lualine: nicer line at the bottom, complete with fancy icons
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				icons_enabled = true,
				theme = "ayu-dark",
			})
		end,
	},

	-- undotree !!!
	{
		"mbbill/undotree",
	},

	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		---@module 'obsidian'
		---@type obsidian.config
		opts = {

			legacy_commands = false,

			workspaces = {
				{
					name = "obsidian",
					path = "~/Obsidian/",
				},
			},

			-- see below for full list of options 👇
			ui = {
				enable = false,
			},

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				blink = true,
				nvim_cmp = false,
				min_chars = 2,
			},

			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},

			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = true,

			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "dailies",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y-%m-%d",
				-- Optional, if you want to change the date format of the default alias of daily notes.
				-- alias_format = "%B %-d, %Y",
				-- Optional, default tags to add to each new daily note created.
				default_tags = { "daily-notes" },
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = "templates/daily.md",
			},

			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
				name = "telescope.nvim",
				note_mappings = {
					new = "<C-x>",
					insert_link = "<C-l>",
				},
				tag_mappings = {
					tag_note = "<C-x>",
					insert_tag = "<C-l>",
				},
			},

			footer = {
				enabled = false,
			},
		},
	},
}
