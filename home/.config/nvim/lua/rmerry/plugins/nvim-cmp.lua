return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
	},

	config = function()
		local cmp = require('cmp')

		local luasnip = require("luasnip")

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				['<C-space>'] = cmp.mapping.complete(),
				--['<C-f>'] = cmp_action.luasnip_jump_forward(),
				--['<C-b>'] = cmp_action.luasnip_jump_backward(),
				-- ['<C-p>'] = cmp.mapping.select_previous_item(),
				-- ['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
		})
	end
}
