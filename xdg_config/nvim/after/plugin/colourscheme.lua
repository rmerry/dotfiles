vim.opt.termguicolors = true

if pcall(require, "colorizer") then
  require("colorizer").setup()
end

-- if not pcall(require, "colorbuddy") then
--   return
-- end

-- require("colorbuddy").colorscheme("gruvbuddy")

-- vim.g.vscode_style = "dark"
-- vim.g.vscode_transparent = 1
vim.g.vscode_italic_comment = 1
require('vscode').change_style("dark") 
