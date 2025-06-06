return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "[f]ind [f]ile" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "[f]ind live [g]rep" },
		{ "<leader>fc", "<cmd>FzfLua files cwd=~/.config<CR>", desc = "[f]ind [c]onfig" },
		{ "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = "[f]ind grep [w]ord" },
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "[f]ind [d]iagnostic" },
		{ "<leader>fr", "<cmd>FzfLua resume<CR>", desc = "[f]ind [r]esume" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "[f]ind [o]ld files" },
		{ "<leader><leader>", "<cmd>FzfLua buffers<CR>", desc = "[f]ind buffer" },
		{ "<leader>/", "<cmd>FzfLua lgrep_curbuf<CR>", desc = "[f]ind live grep" },
	},
}
