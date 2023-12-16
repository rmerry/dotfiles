return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp'
	},

	config = function()
		local lspconfig = require("lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local opts = { buffer = bufnr, remap = false }
		local on_attach_func = function(client, bufnr)
			vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
			vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
			vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

			vim.keymap.set('n', '<leader>vs', function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
			vim.keymap.set('n', '<leader>R', function() vim.lsp.buf.rename() end, opts)

			vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)

			vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach_func,
		})
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach_func,
		})
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach_func,
		})
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach_func,
		})
	end
}





