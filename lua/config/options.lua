-- convert tabs to spaces
vim.opt.expandtab = true
-- amount to indent with << and >>
vim.opt.shiftwidth = 2

-- how many spaces shown per tab
vim.opt.tabstop = 2
-- how many spaces are applied when pressing tab
vim.opt.softtabstop = 2

vim.opt.smarttab = true
vim.opt.smartindent = true
-- keep identation from previous line
vim.opt.autoindent = true

-- always show relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- show line under cursor
vim.opt.cursorline = true

-- store undos between session
vim.opt.undofile = true

-- enable mouse mode
vim.opt.mouse = "a"

-- don't show the mode, since its already in mini-statusline
vim.opt.showmode = false

-- enable break indent
vim.opt.breakindent = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250

-- confiure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- TODO: Find the symbols
-- set how nvim will display certain whitespaces characters in the editor
--vim.opt.list = true
-- vim.opt.listchars = { tab = " ", trail="", nbsp = ""}

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- disable command line until its needed
vim.opt.cmdheight = 0

-- highlight text for some time after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", {
		clear = true,
	}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})
