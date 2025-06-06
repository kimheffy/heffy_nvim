return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    {"<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find file in current dir"}},
    {"<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Find by grepping current dir"}},
    {"<leader>fc", "<cmd>FzfLua files cwd=~/.config<CR>", { desc = "Find in neovim config"}},
    {"<leader>fw", "<cmd>FzfLua grep_cword<CR>", { desc = "Find current word"}},
    {"<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Find Diagnostics"}},
    {"<leader>fr", "<cmd>FzfLua resume<CR>", { desc = "Find resume"}},
    {"<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "Find old files"}},
    {"<leader><leader>", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers"}},
    {"<leader>/", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Live grep cur buffer"}},
  }
}
