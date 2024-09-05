return {
	"ray-x/go.nvim",
	dependencies = {  -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	event = {"CmdlineEnter"},
	ft = {"go", "gomod"},
	-- Install/update all binaries.
	build = ":lua require(\"go.install\").update_all_sync()", 

	config = function()
		local go = require("go")
		go.setup()

		-- Run gofmt + goimport on save
		local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})
	end
}
