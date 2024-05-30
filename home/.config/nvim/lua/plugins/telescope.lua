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

		-- File pickers
		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {desc = 'Find files'})
		vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, {desc = 'Find (GIT) files'})
		vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {desc = 'Find buffers'})
		vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, {desc = 'Find recent Files'})
		vim.keymap.set('n', '<leader>fm', require('telescope.builtin').man_pages, {desc = 'Find man page'})

		-- GREP pickers
		vim.keymap.set('n', '<leader>gs', require('telescope.builtin').lsp_dynamic_workspace_symbols, {})
		vim.keymap.set('n', '<leader>gc', require('telescope.builtin').grep_string, {desc = 'GREP string under cursor'})
		vim.keymap.set('n', '<leader>gf', require('telescope.builtin').live_grep, {desc = 'GREP files'})
		vim.keymap.set('n', '<leader>gh', require('telescope.builtin').help_tags, {desc = 'GREP help'})

		-- LSP pickers
		vim.keymap.set('n', '<leader>rc', require('telescope.builtin').lsp_references, {desc = 'Reference string under cursor'})
		vim.keymap.set('n', '<leader>ri', require('telescope.builtin').lsp_incoming_calls, {desc = 'References incomming calls string under cursor'})
		vim.keymap.set('n', '<leader>ro', require('telescope.builtin').lsp_outgoing_calls, {desc = 'References outgoing calls string under cursor'})
		vim.keymap.set('n', '<leader>rd', require('telescope.builtin').lsp_document_symbols, {desc = 'References DOCUMENT grep'})
		vim.keymap.set('n', '<leader>ra', require('telescope.builtin').lsp_workspace_symbols, {desc = 'References ALL grep'})
		-- vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definition, {desc = 'GOTO definition (of word under cursor)'})
		-- vim.keymap.set('n', '<leader>gD', require('telescope.builtin').lsp_declaration, {desc = 'GOTO declaration (of word under cursor)'})
		-- vim.keymap.set('n', '<leader>gi', require('telescope.builtin').lsp_implementation, {desc = 'GOTO implementation (of word under cursor)'})

	end
}
