local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Normal mode
map("n", "<space>dw", "<cmd>lua require('diaglist').open_all_diagnostics()<cr>")
map("n", "<space>d0", "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>")

-- Vim Config Edits
map("n", "<leader>vei", "<cmd>e $MYVIMRC<cr>")
map("n", "<leader>vek", "<cmd>e ~/.config/nvim/plugin/keymaps.lua<cr>")
map("n", "<leader>veo", "<cmd>e ~/.config/nvim/plugin/options.lua<cr>")
map("n", "<leader>vep", "<cmd>e ~/.config/nvim/lua/rmerry/plugins.lua<cr>")

-- Terminal
map("t", "<leader><Esc>", "<C-\\><C-n>")
map("t", "<Esc><Esc>", "<C-\\><C-n>")
map("t", "<A-h>", "<C-\\><C-n><C-w>h")
map("t", "<A-j>", "<C-\\><C-n><C-w>j")
map("t", "<A-k>", "<C-\\><C-n><C-w>k")
map("t", "<A-l>", "<C-\\><C-n><C-w>l")
