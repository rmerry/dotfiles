-- LSP goodies when working with the nvim lua API.
return {
	"folke/neodev.nvim", 
	opts = {},
	config = function()
		-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
		local neodev = require("neodev")
		neodev.setup({
			-- add any options here, or leave empty to use the default settings
		})
	end
}
