return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16, -- ~60fps
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"CursorMoved",
					"CursorMovedI",
					"ModeChanged",
				},
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = {
				{
					"lsp_status",
					icon = "", -- f013
					symbols = {
						-- Standard unicode symbols to cycle through for LSP progress:
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						-- Standard unicode symbol for when LSP is done:
						done = "✓",
						-- Delimiter inserted between LSP names:
						separator = " ",
					},
					-- List of LSP names to ignore (e.g., `null-ls`):
					ignore_lsp = {},
				},
			},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 4, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
						newfile = "[New]", -- Text to show for newly created file before first write
					},
				},
			},
			lualine_c = {
				{
					"diagnostics",

					-- Table of diagnostic sources, available sources are:
					--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
					-- or a function that returns a table as such:
					--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
					sources = { "nvim_lsp", "vim_lsp", "nvim_diagnostic" },

					-- Displays diagnostics for the defined severity types
					sections = { "error", "warn", "info", "hint" },

					diagnostics_color = {
						-- Same values as the general color option can be used here.
						error = "DiagnosticError", -- Changes diagnostics' error color.
						warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
						info = "DiagnosticInfo", -- Changes diagnostics' info color.
						hint = "DiagnosticHint", -- Changes diagnostics' hint color.
					},
					symbols = { error = "E", warn = "W", info = "I", hint = "H" },
					colored = true, -- Displays diagnostics status in color if set to true.
					update_in_insert = false, -- Update diagnostics in insert mode.
					always_visible = false, -- Show diagnostics even if there are none.
				},
			},
			lualine_x = {
				{
					"diff",
					colored = true, -- Displays a colored diff status if set to true
					diff_color = {
						-- Same color values as the general color option can be used here.
						added = "LuaLineDiffAdd", -- Changes the diff's added color
						modified = "LuaLineDiffChange", -- Changes the diff's modified color
						removed = "LuaLineDiffDelete", -- Changes the diff's removed color you
					},
					symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
					source = nil, -- A function that works as a data source for diff.
					-- It must return a table as such:
					--   { added = add_count, modified = modified_count, removed = removed_count }
					-- or nil on failure. count <= 0 won't be displayed.
				},
			},
			lualine_y = {
				{
					"lsp_status",
					icon = "", -- f013
					symbols = {
						-- Standard unicode symbols to cycle through for LSP progress:
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						-- Standard unicode symbol for when LSP is done:
						done = "✓",
						-- Delimiter inserted between LSP names:
						separator = " ",
					},
					-- List of LSP names to ignore (e.g., `null-ls`):
					ignore_lsp = {},
				},
			},
			lualine_z = {
				"os.date('%a -- %Y-%m-%d %H:%M:%S')",
				"data",
				"require'lsp-status'.status()",
			},
		},
		inactive_winbar = {},
		extensions = {},
	},
}
