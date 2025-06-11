return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
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
				"rust",
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
			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = { query = "@function.outer", desc = "around a function" },
						["if"] = { query = "@function.inner", desc = "inner part of a function" },
						["ac"] = { query = "@class.outer", desc = "around a class" },
						["ic"] = { query = "@class.inner", desc = "inner part of a class" },
						["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
						["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
						["al"] = { query = "@loop.outer", desc = "around a loop" },
						["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
						["ap"] = { query = "@parameter.outer", desc = "around parameter" },
						["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@parameter.inner"] = "v", -- charwise
						["@function.outer"] = "v", -- charwise
						["@conditional.outer"] = "V", -- linewise
						["@loop.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_previous_start = {
						["[f"] = { query = "@function.outer", desc = "Previous function" },
						["[c"] = { query = "@class.outer", desc = "Previous class" },
						["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
					},
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "Next function" },
						["]c"] = { query = "@class.outer", desc = "Next class" },
						["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})

		-- vim.wo.foldmethod = 'expr'
		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end,
}
