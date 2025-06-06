return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- shortcut to <Enter>
					node_incremental = "grn", -- shortcut to <Enter>
					scope_incremental = "grc", -- shortcut to false
					node_decremental = "grm", -- shortcut to <Backspace>
				},
			},
		})

		-- vim.wo.foldmethod = 'expr'
		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end,
}
