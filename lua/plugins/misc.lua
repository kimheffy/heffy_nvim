return {
	{
		-- tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
	{
		-- detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- powerful git integration for vim
		"tpope/vim-fugitive",
	},
	{
		-- github integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- diff open vim
		"sindrets/diffview.nvim",
	},
	{
		-- autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
}
