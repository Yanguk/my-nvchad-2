vim.api.nvim_set_keymap("n", "<leader>rp", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rn", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rr", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rl", ":lua require('kulala').replay()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>re",
  ":lua require('kulala').set_selected_env()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>rs", ":lua require('kulala').scratchpad()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>rh",
  ":lua require('kulala').toggle_view()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_command("set commentstring=#%s")
