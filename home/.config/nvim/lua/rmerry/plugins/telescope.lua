return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	priority = 1000,
	lazy = false,
	config = function()
		local telescope = require('telescope')

		telescope.setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
		}

		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
		vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
		vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
		vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
		vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {})
		vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, {}) -- Behave like the old ctrl-p plugin.
		vim.keymap.set('n', '<leader>wd', require('telescope.builtin').lsp_document_symbols, {})
		vim.keymap.set('n', '<leader>ww', require('telescope.builtin').lsp_dynamic_workspace_symbols, {})
	end
}
