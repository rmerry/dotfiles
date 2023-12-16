vim.keymap.set('n', '-', vim.cmd.Ex)

-- Move highlighted blocks up and down.
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Key you cursor in the same spot when using J to join lines.
vim.keymap.set('n', 'J', 'mzJ`z')

-- Key your search terms in the middle (vertically).
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste over a highlighted text without clobbering the buffer.
vim.keymap.set('x', '<leader>p', '"_dP')
