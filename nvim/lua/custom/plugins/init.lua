-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

	-- ocaml indenting?
	{
		{
			"ocaml/vim-ocaml",
			lazy = false,
		},
	},

	-- a markdown / latex previewer
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- do not enable previews by default
		config = function()
			require("markview").setup({
				preview = { enable = false },
			})
		end,

		-- Completion for `blink.cmp`
		-- dependencies = { "saghen/blink.cmp" },
	},

	-- oil nvim!!!
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},

	-- folding plugin
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			useLspFoldsWithTreesitterFallback = {
				enabled = true,
				foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
			},
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = {
					width = 4,
				},
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
				setup = false,
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
		lazy = true,
		ft = "markdown",

		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},

		opts = {

			workspaces = {
				{
					name = "obsidian",
					path = "~/Obsidian",
				},
			},

			ui = {
				enable = false,
			},

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				blink = true,
				-- min_chars = 2, -- Trigger completion at 2 chars.
			},

			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},

			frontmatter = {
				enabled = true,
				func = function(note)
					local out = { id = note.id, aliases = note.aliases }
					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end
					return out
				end,
				sort = { "id", "aliases" },
			},

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
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},

			legacy_commands = false,
		},
	},
}
